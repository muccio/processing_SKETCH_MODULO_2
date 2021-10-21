import oscP5.*;
import netP5.*;
  
OscP5 server;
int w = 10;
int h = 10;

PImage myImage;

PImage tex;
PShader deform;

void setup() {
  size(800,800,P2D);
  frameRate(25);
  server = new OscP5(this,12000);
  
  
  myImage = loadImage("es1.jpg");
  
  textureWrap(REPEAT);
  tex = loadImage("tex1.jpg");
 
  deform = loadShader("deform.glsl");
  deform.set("resolution", float(width), float(height));
}


void draw() {
  background(0);  
  fill(255);
  /*rectMode(CENTER);
  rect(width/2,height/2,w,h);
  
  image(myImage, 0,0);
  filter(THRESHOLD, (w/400.0f));
  */
  
  deform.set("time", millis() / 1000.0);
  deform.set("mouse", float(w), float(h));
  shader(deform);
  image(tex, 0, 0, width, height);
 
  
}

void oscEvent(OscMessage theOscMessage) {
  //print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if(theOscMessage.checkAddrPattern("/damax")==true) {
    if(theOscMessage.checkTypetag("i")) {
      int intero = theOscMessage.get(0).intValue();  
      println(" valore: "+intero);
      w = intero;
      h = intero;
      return;
    }  
  } 
  
  if(theOscMessage.checkAddrPattern("/oscControl/slider1")==true) {
    if(theOscMessage.checkTypetag("f")) {
      float valore = theOscMessage.get(0).floatValue();  
      println(" valore: "+valore);
      w = int(valore*400.0);
      h = int(valore*400.0);
      return;
    }  
  } 
}
