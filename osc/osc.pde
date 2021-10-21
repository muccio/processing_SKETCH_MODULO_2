import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
int y = 0;

void setup() {
  size(400,400);
  frameRate(25);
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


void draw() {
  background(0);  
  fill(255);
  rectMode(CENTER);
  rect(width/2,y,50,50);
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(123); /* add an int to the osc message */
  myMessage.add(12.34); /* add a float to the osc message */
  myMessage.add("some text"); /* add a string to the osc message */
  myMessage.add(new byte[] {0x00, 0x01, 0x10, 0x20}); /* add a byte blob to the osc message */
  myMessage.add(new int[] {1,2,3,4}); /* add an int array to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if(theOscMessage.checkTypetag("ifs")) {
    /* parse theOscMessage and extract the values from the osc message arguments. */
    int firstValue = theOscMessage.get(0).intValue();  
    float secondValue = theOscMessage.get(1).floatValue();
    String thirdValue = theOscMessage.get(2).stringValue();
    print("### received an osc message /test with typetag ifs.");
    println(" values: "+firstValue+", "+secondValue+", "+thirdValue);
    return;
  }  
  if(theOscMessage.checkTypetag("f")) {
    float firstValue = theOscMessage.get(0).floatValue();  
    y = (int)(height*firstValue);
    
    println("VALUE y: "+y);
    
  }
}