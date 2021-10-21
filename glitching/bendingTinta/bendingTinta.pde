import processing.video.*;


PImage im;
Capture webcam;

void setup(){
  size(640,480);
  im = loadImage("tokyo.bmp");
  image(im,0,0);
  webcam = new Capture(this);
  webcam.start();
}

void draw(){
  if(webcam.available()){
    webcam.read();
    im = webcam;
    mischiaSorgente();
    image(im,0,0);
  }
}

PImage generaCella(PImage immagine){
  int w = int(random(100,immagine.width));
  int h = int(random(100,immagine.height));
  int src_x = int(random(0,immagine.width-w));
  int src_y = int(random(0,immagine.height-h));
  PImage fetta = createImage(w,h,ARGB);
  fetta.copy(immagine,src_x,src_y,w,h,0,0,w,h);
  return fetta;
}

void mischiaSorgente(){
  for(int i=0;i<20;i++){
    PImage a = generaCella(im);
    int x = int(random(width-a.width));
    int y = int(random(height-a.height));
    tint(random(255),random(255),random(255),random(255));
    image(a,x,y);
  }
}

void mousePressed(){
  mischiaSorgente();
}
