import processing.video.*;

/*
prendere un video in input
e ordinare i pixel del video
in ordine crescente sulle righe

pixels -> [0123456789...01234....]
*/

Capture webcam;
Movie film;
int[] riga_di_pixel,colonna_di_pixel;

void setup(){
  size(960,540);
  webcam = new Capture(this);
  webcam.start();
  
  film = new Movie(this,"home.mov");
  film.loop();
  film.play();
}

void draw(){
  if(film.available()){
    film.read();
    ordinaPixel(film);
    //tint(255,180);
    //image(film,0,0);
  }
}

void ordinaPixel(PImage im){
  im.loadPixels();
  
  
  
  //VERTICALE
  for(int x=0;x<im.width;x++){
    colonna_di_pixel = new int[im.height];
    for(int y=0;y<im.height;y++){
      colonna_di_pixel[y] = im.pixels[x+y*im.width];
    }
    colonna_di_pixel = sort(colonna_di_pixel);
    for(int y=0;y<im.height;y++){
      im.pixels[x+y*im.width] = colonna_di_pixel[y];
    }
  }
  
  //ORIZZONTALE
  for(int y=0;y<im.height;y++){
    riga_di_pixel = new int[im.width];
    //copio dall'array dell'immagine i pixel nell'array di appoggio
    arrayCopy(im.pixels,y*im.width,riga_di_pixel,0,im.width);
    //ordino l'array di appoggio
    riga_di_pixel = sort(riga_di_pixel);
    //copia dall'array riga di appoggio nell'array dell'immagine
    arrayCopy(riga_di_pixel,0,im.pixels,y*im.width,im.width);
  }
  im.updatePixels();
  image(im,0,0);
}
