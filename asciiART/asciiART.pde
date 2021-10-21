PFont mono;
PImage mona;
int[] values;
int fontSize= 8;

void setup(){
  size(800,600);
  mono = loadFont("CourierNewPSMT-48.vlw");
  mona = loadImage( "monna.jpg");
  mona.resize(800,600);
  textSize(fontSize);
  values = new int[800*600];
}

void draw(){
  background(0);
  fill(255);  
  mona.filter(THRESHOLD,0.6);
  mona.loadPixels();
  for(int x=0;x<width;x+=fontSize){
    for(int y=0;y<height;y+=fontSize){
      if(brightness(mona.pixels[x+y*width])==255){
        text(".",x,y);
      }
      else{
        text("X",x,y);
      }
    }
  }
}
