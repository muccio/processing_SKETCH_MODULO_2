/*
  Simple WebSocketServer example that can receive voice transcripts from Chrome
  Requires WebSockets Library: https://github.com/alexandrainst/processing_websockets
 */

import websockets.*;

WebsocketServer socket;
String testo="dummy";
void setup() {
  size(800,600);
  socket = new WebsocketServer(this, 1337, "/p5websocket"); 
}

void draw() {
  background(0);
  stroke(255);
  textMode(CENTER);
  textAlign(CENTER);
  textSize(70);
  text(testo,width/2,height/2);
}

void webSocketServerEvent(String msg){
 println(msg);
 testo=msg;
}
