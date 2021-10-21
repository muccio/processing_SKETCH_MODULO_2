import processing.video.*;

Capture webcam;

PImage source,destination;

void setup(){
  size(800,600);
  source = loadImage("tokyo.jpg");//832x468
  
  webcam = new Capture(this,640,480);
  webcam.start();
  
  
}

void draw(){
  //image(source,0,0);
  /*if(webcam.available()){
    webcam.read();
    source=webcam;
    scrambleSource();
    image(source,0,0);
  }
  */
}

PImage selectRandomRect(PImage src){
  int w = int(random(100,src.width));
  int h = int(random(100,src.height));
  int src_x = int(random(0,src.width-w));
  int src_y = int(random(0,src.height-h));
  PImage res = createImage(w,h,ARGB);
  res.copy(src,src_x,src_y,w,h,0,0,w,h);
  return res;
}

void scrambleSource(){
  background(0);
  for(int i=0;i<20;i++){
    PImage texel = selectRandomRect(source);
    tint(random(255),random(255),random(255),random(255));
    image(texel,random(width-texel.width),random(0,height-texel.height));
    
  }
}

void mousePressed(){
  scrambleSource();
}
