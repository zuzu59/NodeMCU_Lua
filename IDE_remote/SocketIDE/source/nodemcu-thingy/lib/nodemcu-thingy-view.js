'use babel';

var util=require( './util')


const ID_CONSOLE = 'ID_CONSOLE'
const ID_BTN_RESTART = 'ID_BTN_RESTART'
const ID_BTN_CONNECT = 'ID_BTN_CONNECT'
const ID_BTN_LIST = 'ID_BTN_LIST'
const ID_CMD_LINE = 'ID_CMD_LINE'
const ID_BADGE_CONNECTION_STATUS = 'ID_BADGE_CONNECTION_STATUS'
const ID_UL_FILE_LIST_ROOT = 'ID_UL_FILE_LIST_ROOT'

function createButton(label, id) {
  var button = document.createElement('button');
  button.classList.add('inline-block-tight');
  button.classList.add('btn');
  var txt= document.createTextNode(label);
  button.appendChild(txt)
  button.id= id
  button.onclick=eventHandler
  return button
}

var handlers=[];

function eventHandler(event) {
  var id=event.target.id
  console.log(id+" pressed...")
  func=handlers[id];
  func(event);
}

export default class NodemcuThingyView {


  constructor(serializedState) {
    // Create root element
    this.element = document.createElement('div');
    this.element.classList.add('nodemcu-thingy');
    // Create message element

    const message = document.createElement('div');
    message.classList.add('message');
    message.style.height="100%"
    var div = document.createElement('div');
    div.classList.add("block")

    message.appendChild(div);

    div.appendChild(createButton("Connect",ID_BTN_CONNECT));
    div.appendChild(createButton("Restart",ID_BTN_RESTART));
    div.appendChild(createButton("List Files",ID_BTN_LIST));
    div.style.height="100%";

    var span = document.createElement('span');
    span.classList.add("badge");
    span.classList.add("badge-error");
    var txt= document.createTextNode("Disconnected");
    span.id=ID_BADGE_CONNECTION_STATUS;
    span.appendChild(txt)
    div.appendChild(span);

    var centerDiv = document.createElement('div');
    centerDiv.classList.add("block")
    centerDiv.style.height="80%";
    centerDiv.style.width="100%";
    div.appendChild(centerDiv);
    var consoleDiv = document.createElement('div');
    consoleDiv.classList.add('inline-block');
    consoleDiv.style.height="100%";
    consoleDiv.style.width="75%";
    centerDiv.appendChild(consoleDiv);


    textarea=document.createElement('textarea');
    textarea.classList.add('input-textarea');
    textarea.style.height="100%";
    textarea.style.width="100%";
    textarea.readOnly = true
    textarea.id=ID_CONSOLE
    //this is needed for cursor movement etc.
    textarea.classList.add('native-key-bindings')
    consoleDiv.appendChild(textarea);

    var input =document.createElement('input');
    input.classList.add('input-text');
    input.classList.add('native-key-bindings');
    input.type='text'
    input.id=ID_CMD_LINE
    input.onkeypress=eventHandler
    consoleDiv.appendChild(input);

    var fileDiv = document.createElement('div');
    fileDiv.classList.add('inline-block');
    fileDiv.style.height="100%"
    centerDiv.appendChild(fileDiv);

    this.createFileListView(fileDiv);



    this.element.appendChild(message);


/*
    // Wonder if we use that one day for automatic upload
    const disposable = atom.project.onDidChangeFiles(events => {
      for (const event of events) {
        if (event.path.indexOf("/.atom")==-1) {
          // "created", "modified", "deleted", or "renamed"
          console.log(`Event action: ${event.action}`)
          // absolute path to the filesystem entry that was touched
          console.log(`Event path: ${event.path}`)

          if (event.type === 'renamed') {
            console.log(`.. renamed from: ${event.oldPath}`)
          }
        }
      }
    });
*/
  }

  createFileListView(parent) {
    var ulRoot = document.createElement('ul');
    ulRoot.classList.add("list-tree")
    parent.appendChild(ulRoot);

    var li = document.createElement('li');
    li.classList.add("list-nested-item");
    ulRoot.appendChild(li);

    var liDiv= document.createElement('div');
    liDiv.classList.add("list-item");
    li.appendChild(liDiv);

    var liSpan = document.createElement("span");
    liSpan.classList.add("icon");
    liSpan.classList.add("icon-file-directory") ;
    liSpan.innerText="NodeMCU";
    liDiv.appendChild(liSpan);

    var fileListRoot = document.createElement("ul");
    fileListRoot.classList.add("list-tree");
    fileListRoot.id=ID_UL_FILE_LIST_ROOT;
    liDiv.appendChild(fileListRoot);
}
  registerConnectButtonHandler(func){
    handlers[ID_BTN_CONNECT]=func;
  }

  registerRestartButtonHandler(func){
    handlers[ID_BTN_RESTART]=func;
  }

  registerListButtonHandler(func){
    handlers[ID_BTN_LIST]=func;
  }

 registerCmdLineHandler(func){
   handlers[ID_CMD_LINE]=func;
 }

  // Returns an object that can be retrieved when package is activated
  serialize() {}

  // Tear down any state and detach
  destroy() {
    this.element.remove();
  }

  getElement() {
    return this.element;
  }

  writeToConsole(text){
    textarea=document.getElementById(ID_CONSOLE)
    textarea.value+=text;
    textarea.scrollTop = textarea.scrollHeight;
  }

  getCmdLineValue() {
    input=document.getElementById(ID_CMD_LINE)
    return input.value
  }

  setCmdLineValue(value) {
    input=document.getElementById(ID_CMD_LINE)
    input.value=value
  }
  setConnected(connected) {
    var span=document.getElementById(ID_BADGE_CONNECTION_STATUS)
    if (span!=null){
      var showsConnected=span.classList.contains("badge-success");
      if (connected && !showsConnected){
        span.classList.add("badge-success");
        span.classList.remove("badge-error");
        span.innerHTML='Connected'
      }
      else if (!connected && showsConnected) {
        span.classList.remove("badge-success");
        span.classList.add("badge-error");
        span.innerHTML='Disconnected'
      }
    }
  }
  setFileList(list) {
    var root=document.getElementById(ID_UL_FILE_LIST_ROOT)
    while (root.firstChild) {
      root.removeChild(root.firstChild);
    }
    for (var i = 0; i < list.length; i++) {
      var li = document.createElement('li');
      li.classList.add("list-item");
      root.appendChild(li);

      var span = document.createElement('span');
      span.classList.add("icon");
      var iconType="text"
      var filename=list[i].substring(0,list[i].indexOf(" ("));
      if (util.isWriteprotected(filename)) {
        iconType="zip"
        span.classList.add('text-subtle');
      }
      else{
         if (filename.endsWith(".lua")) {
           iconType="code"
         }
         else
         if (filename.endsWith(".lc")) {
           iconType="binary"
         }
      }
      span.classList.add("mcu-download");
      span.classList.add("icon-file-"+iconType);

      span.innerText=list[i];
      li.appendChild(span);
    }

  }


  getTitle() {
    // Used by Atom for tab text
    return 'NodeMCU Thingy';
  }

  getURI() {
    // Used by Atom to identify the view when toggling.
    return 'atom://nodemcu-thingy';
  }

  getDefaultLocation() {
    // This location will be used if the user hasn't overridden it by dragging the item elsewhere.
    // Valid values are "left", "right", "bottom", and "center" (the default).
    return 'right';
  }

  getAllowedLocations() {
    // The locations into which the item can be moved.
    return ['left', 'right', 'bottom'];
  }
}
