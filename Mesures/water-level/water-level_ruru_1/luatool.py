#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-
version = "0.6.9 zf201003.1101"

print("luatool.py ver " + version)

#Améliorations
# Pour voir les améliorations il faut 'chercher' les zzz


#
# ESP8266 luatool
# Author e-mail: 4ref0nt@gmail.com
# Site: http://esp8266.ru
# Contributions from: https://github.com/sej7278
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
# Street, Fifth Floor, Boston, MA 02110-1301 USA.

import sys
import serial
from time import sleep
import socket
import argparse
from os.path import basename


tqdm_installed = True
try:
    from tqdm import tqdm
except ImportError, e:
    if e.message == 'No module named tqdm':
        tqdm_installed = False
    else:
        raise



class TransportError(Exception):
    """Custom exception to represent errors with a transport
    """
    def __init__(self, message):
        self.message = message

    def __str__(self):
        return self.message

class AbstractTransport:
    def __init__(self):
        raise NotImplementedError('abstract transports cannot be instantiated.')

    def close(self):
        raise NotImplementedError('Function not implemented')

    def read(self, length):
        raise NotImplementedError('Function not implemented')

    def writeln(self, data, check=1):
        raise NotImplementedError('Function not implemented')

    def writer(self, data):
        ##zzz191124 enlève la fin de ligne afin de ne pas perturber la vérification finale
        data = data.rstrip('\r\n')
        self.writeln("file.writeline([==[" + data + "]==])\r")

    def performcheck(self, expected):
        line = ''
        char = ''
        i = -1
        while char != chr(62):  # '>'
            char = self.read(1)
            if char == '':
                raise Exception('No proper answer from MCU')
            if char == chr(13) or char == chr(10):  # LF or CR
                if line != '':
                    #zzz191124 line = line.strip()
                    # zzz191021 Affiche ce que l'on a reçu du NodeMCU
                    if args.verbose:
                        print("\n\nzread0957: {" + line + "\n}\n")

                    if line+'\r' == expected and not args.bar:
                        sys.stdout.write(" -> ok")
                    elif line+'\r' != expected:
                        if line[:4] == "lua:":
                            sys.stdout.write("\r\n\r\nLua ERROR: %s" % line)
                            raise Exception('ERROR from Lua interpreter\r\n\r\n')
                        else:
                            expected = expected.split("\r")[0]
                            sys.stdout.write("\r\n\r\nERROR")
                            sys.stdout.write("\r\n send string    : '%s'" % expected)
                            sys.stdout.write("\r\n expected echo  : '%s'" % expected)
                            sys.stdout.write("\r\n but got answer : '%s'" % line)
                            sys.stdout.write("\r\n\r\n")
                            raise Exception('Error sending data to MCU\r\n\r\n')
                    line = ''
            else:
                line += char
                if char == chr(62) and expected[i] == char:
                    char = ''
                i += 1


class SerialTransport(AbstractTransport):
    def __init__(self, port, baud, delay):
        self.port = port
        self.baud = baud
        self.serial = None
        self.delay = delay

        try:
            self.serial = serial.Serial(port, baud)
        except serial.SerialException as e:
            raise TransportError(e.strerror)

        self.serial.timeout = 3
        self.serial.interCharTimeout = 3

        # zzz191021 juste après l'ouverture du port série, on attend le caractère '>'
        line = ''
        char = ''
        i = -1
        while char != chr(62):  # '>'
            char = self.read(1)
            if char == '':
                raise Exception('No proper answer from MCU')
            line += char
            i += 1
        if args.verbose:
            print("line: ." + line + ".")


    def writeln(self, data, check=1):
        # zzz191020 on fait une petite pause avant l'envoi de chaque ligne
        sleep(self.delay)
        if self.serial.inWaiting() > 0:
            self.serial.flushInput()
        if len(data) > 0 and not args.bar:
            sys.stdout.write("\r\n->")
            sys.stdout.write(data.split("\r")[0])
        ##zzz191124 attend encore un petit peu avant d'envoyer
        sleep(self.delay)
        self.serial.write(data)
        sleep(self.delay)
        # zzz191021 Affiche ce que l'on a envoyé au NodeMCU
        if args.verbose:
            print("\n\nzwrite0952: {" + data + "\n}\n")
        if check > 0:
            self.performcheck(data)
        elif not args.bar:
            sys.stdout.write(" -> send without check")

    def read(self, length):
        return self.serial.read(length)

    def close(self):
        self.serial.flush()
        self.serial.close()


class TcpSocketTransport(AbstractTransport):
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.socket = None

        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error as e:
            raise TransportError(e.strerror)

        try:
            self.socket.connect((host, port))
        except socket.error as e:
            raise TransportError(e.strerror)
        # read intro from telnet server (see telnet_srv.lua)
        self.socket.recv(50)

    def writeln(self, data, check=1):
        if len(data) > 0 and not args.bar:
            sys.stdout.write("\r\n->")
            sys.stdout.write(data.split("\r")[0])
        self.socket.sendall(data)
        if check > 0:
            self.performcheck(data)
        elif not args.bar:
            sys.stdout.write(" -> send without check")

    def read(self, length):
        return self.socket.recv(length)

    def close(self):
        self.socket.close()


def decidetransport(cliargs):
    if cliargs.ip:
        data = cliargs.ip.split(':')
        host = data[0]
        if len(data) == 2:
            port = int(data[1])
        else:
            port = 23
        return TcpSocketTransport(host, port)
    else:
        return SerialTransport(cliargs.port, cliargs.baud, cliargs.delay)


if __name__ == '__main__':
    # parse arguments or use defaults
    parser = argparse.ArgumentParser(description='ESP8266 Lua script uploader.')
    parser.add_argument('--bar',           action='store_true',    help='Show a progress bar for uploads instead of printing each line')
    parser.add_argument('--delay',         default=0.025,           help='Delay in seconds between each write, default 0.03 sec.', type=float)
    parser.add_argument('--delete',        default=None,           help='Delete a lua/lc file from device.')
    parser.add_argument('--ip',            default=None,           help='Connect via telnet server (--ip IP[:port])')
    parser.add_argument('--zrestart',      action='store_true',    help='Restart the NodeMCU.')
    parser.add_argument('-a', '--append',  action='store_true',    help='Append source file to destination file.')
    parser.add_argument('-b', '--baud',    default=115200,         help='Baudrate, default 115200')
    parser.add_argument('-c', '--compile', action='store_true',    help='Compile lua to lc after upload')
    parser.add_argument('-d', '--dofile',  action='store_true',    help='Run the Lua script after upload')
    parser.add_argument('-e', '--echo',    action='store_true',    help='Echo output of MCU until script is terminated.')
    parser.add_argument('-f', '--src',     default='main.lua',     help='Source file on computer, default main.lua')
    parser.add_argument('-i', '--id',      action='store_true',    help='Query the modules chip id.')
    parser.add_argument('-l', '--list',    action='store_true',    help='List files on device')
    parser.add_argument('-p', '--port',    default='/dev/ttyUSB0', help='Device name, default /dev/ttyUSB0')
    parser.add_argument('-r', '--restart', action='store_true',    help='Restart MCU after upload')
    parser.add_argument('-t', '--dest',    default=None,           help='Destination file on MCU, default to source file name')
    parser.add_argument('-v', '--verbose', action='store_true',    help="Show progress messages.")
    parser.add_argument('-w', '--wipe',    action='store_true',    help='Delete all lua/lc files on device.')
    args = parser.parse_args()

    transport = decidetransport(args)

    if args.bar and not tqdm_installed:
        sys.stdout.write("You must install the tqdm library to use the bar feature\n")
        sys.stdout.write("To install, at the prompt type: \"pip install tqdm\"\n")
        sys.exit(0)


    if args.list:
        # zzz191020 Amélioré la sortie du listing des fichiers
        #transport.writeln("print('\\n-----');local l = file.list();for k,v in pairs(l) do print(k..', size:'..v)end;print('-----\\n')\r", 0)
        # zzz191225 Amélioré encore la sortie du listing des fichiers (sort file)
        transport.writeln("zdir={};pfile = file.list();for k,v in pairs(pfile) do zdir[#zdir+1] = k..string.rep(' ',24-string.len(k))..' : '..v end;table.sort(zdir);print('\\n-----');for i=1, #zdir do print(zdir[i]) end;print('-----\\n');zdir=nil;pfile=nil;k=nil;v=nil;i=nil\r", 0)

        while True:
            char = transport.read(1)
            if char == '' or char == chr(62):    # '' or '>'
                break
            sys.stdout.write(char)
        sys.exit(0)

    if args.id:
        transport.writeln("=node.chipid()\r", 0)
        id=""
        while True:
            char = transport.read(1)
            if char == '' or char == chr(62):
                break
            if char.isdigit():
                id += char
        print("\n"+id)
        sys.exit(0)

    # zzz191020 Ajouté la fonction restart seule
    if args.zrestart:
        transport.writeln("node.restart()\r")
        sys.exit(0)

    if args.wipe:
        transport.writeln("local l = file.list();for k,v in pairs(l) do print(k)end\r", 0)
        file_list = []
        fn = ""
        while True:
            char = transport.read(1)
            if char == '' or char == chr(62):
                break
            if char not in ['\r', '\n']:
                fn += char
            else:
                if fn:
                    file_list.append(fn.strip())
                fn = ''
        for fn in file_list[1:]:  # first line is the list command sent to device
            if args.verbose:
                sys.stderr.write("Delete file {} from device.\r\n".format(fn))
            transport.writeln("file.remove(\"" + fn + "\")\r")
        sys.exit(0)

    if args.delete:
        transport.writeln("file.remove(\"" + args.delete + "\")\r")
        sys.exit(0)

    if args.dest is None:
        args.dest = basename(args.src)
        # zzz191020 Affiche le fichier à envoyer
        print("File: " + args.src)

    # open source file for reading
    try:
        try:
            f = open(args.src, "rt")
        except:
            import os
            base_dir = os.path.dirname(os.path.realpath(__file__))
            f = open(os.path.join(base_dir, args.src), "rt")
            os.chdir(base_dir)
    except:
        sys.stderr.write("Could not open input file \"%s\"\n" % args.src)
        sys.exit(1)

    # Verify the selected file will not exceed the size of the serial buffer.
    # The size of the buffer is 256. This script does not accept files with
    # lines longer than 230 characters to have some room for command overhead.
    num_lines = 0
    for ln in f:
        if len(ln) > 230:
            sys.stderr.write("File \"%s\" contains a line with more than 240 "
                             "characters. This exceeds the size of the serial buffer.\n"
                             % args.src)
            f.close()
            sys.exit(1)
        num_lines += 1

    # Go back to the beginning of the file after verifying it has the correct
    # line length
    f.seek(0)

    # set serial timeout
    if args.verbose:
        sys.stderr.write("Upload starting\r\n")

    # remove existing file on device
    if args.append==False:
        if args.verbose:
            sys.stderr.write("Stage 1. Deleting old file from flash memory")
        transport.writeln("file.open(\"" + args.dest + "\", \"w\")\r")
        transport.writeln("file.close()\r")
        transport.writeln("file.remove(\"" + args.dest + "\")\r")
    else:
        if args.verbose:
            sys.stderr.write("[SKIPPED] Stage 1. Deleting old file from flash memory [SKIPPED]")


    # read source file line by line and write to device
    if args.verbose:
        sys.stderr.write("\r\nStage 2. Creating file in flash memory and write first line")
    if args.append:
        transport.writeln("file.open(\"" + args.dest + "\", \"a+\")\r")
    else:
        transport.writeln("file.open(\"" + args.dest + "\", \"w+\")\r")
    line = f.readline()
    if args.verbose:
        sys.stderr.write("\r\nStage 3. Start writing data to flash memory...")
    if args.bar:
        for i in tqdm(range(0, num_lines)):
            #zzz191124 transport.writer(line.strip())
            transport.writer(line)
            line = f.readline()
    else:
        while line != '':
            #zzz191124 transport.writer(line.strip())
            transport.writer(line)
            line = f.readline()

    # close both files
    f.close()
    if args.verbose:
        sys.stderr.write("\r\nStage 4. Flush data and closing file")
    transport.writeln("file.flush()\r")
    transport.writeln("file.close()\r")

    # compile?
    if args.compile:
        if args.verbose:
            sys.stderr.write("\r\nStage 5. Compiling")
        transport.writeln("node.compile(\"" + args.dest + "\")\r")
        transport.writeln("file.remove(\"" + args.dest + "\")\r")

    # restart or dofile
    if args.restart:
        transport.writeln("node.restart()\r")

    if args.dofile:   # never exec if restart=1
        transport.writeln("dofile(\"" + args.dest + "\")\r", 0)

    if args.echo:
        if args.verbose:
            sys.stderr.write("\r\nEchoing MCU output, press Ctrl-C to exit")
        while True:
            sys.stdout.write(transport.read(1))

    # close serial port
    transport.close()

    # flush screen
    sys.stdout.flush()
    sys.stderr.flush()
    if not args.bar:
        sys.stderr.write("\r\n--->>> All done <<<---\r\n")
