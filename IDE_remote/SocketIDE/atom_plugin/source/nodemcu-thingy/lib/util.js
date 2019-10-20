'use babel';
  function isWriteprotected(filename) {
    var protectedFiles=["init.lua","websocket.lc", "main.lc"];
    for (var i = 0; i < protectedFiles.length; i++) {
          if (protectedFiles[i] === filename) {
              return true;
          }
      }
  }

module.exports.isWriteprotected = isWriteprotected;
