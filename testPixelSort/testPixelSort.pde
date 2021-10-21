import processing.video.*;

Capture webcam;

int[] pixel_column,pixel_row;

void setup(){
  size(640,480);
  webcam = new Capture(this,width,height);
  webcam.start();
  
  //webcam = new Movie(this,"home.mov");
  //webcam.loop();
}

void draw(){
  if(webcam.available()){
    webcam.read();
    //image(webcam,0,0);
    sortImage(webcam);
    tint(255,180);
    image(webcam,0,0);
  }  
}

void sortImage(PImage im){
  im.loadPixels();
  //orizzontale
  for(int y=0;y<im.height;y++){
    pixel_row = new int[im.width];
    arrayCopy(im.pixels, y*im.width, pixel_row, 0, im.width);
    pixel_row = sort(pixel_row);
    arrayCopy(pixel_row, 0,im.pixels, y*im.width, im.width);
  }
  //verticale
  for(int x=0;x<im.width;x++){
    
    pixel_column = new int[im.height];
    for(int y=0;y<im.height;y++){
      pixel_column[y] = im.pixels[x+y*width];
    }
    
    pixel_column = sort(pixel_column);
    for(int y=0;y<im.height;y++){
       im.pixels[x+y*width] = pixel_column[y];
    }
  }
  im.updatePixels();
  image(im,0,0);
}
