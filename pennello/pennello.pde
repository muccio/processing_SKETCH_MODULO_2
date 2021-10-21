PImage immagine,copia;
boolean filtro_attivo = true;

void setup() {
  size(1280, 800);
  immagine = loadImage("pattern.png");
  copia = loadImage("pattern.png");
  image(immagine, 0, 0);
  loadPixels();
}

void draw() {
  
}
void mouseDragged(){
  for (int y=mouseY-10; y<mouseY+10; y++) {
    for (int x=mouseX-10; x<mouseX+10; x++) {
      int xx= constrain(x,0,width-1);
      int yy= constrain(y,0,height-1);
      
      pixels[yy*width+xx] = copia.pixels[yy*width+xx]^0x0000FF;
      
    }
  }
  immagine.copy(copia,0,0,width,height,0,0,width,height);
  updatePixels();
  
}
