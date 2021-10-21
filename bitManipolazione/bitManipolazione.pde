/*PImage immagine;
 
 void setup() {
 size(800, 500);
 immagine = loadImage("ny.jpg");
 //noLoop();
 }
 
 void draw() {
 image(immagine, 0, 0);
 println("ciao");
 
 int colore_del_pixel_100_100 = get(mouseX, mouseY);
 //MODO CON CHIAMATA FUNZIONI 
 color c = color(colore_del_pixel_100_100);
 float rosso = red(c);
 float verde = green(c);
 float blue = blue(c);
 float alpha = alpha(c);
 
 //MODO BIT SHIFT
 int red_bit = (colore_del_pixel_100_100 & 0xff0000)>>16;
 int green_bit = (colore_del_pixel_100_100 & 0xff00)>>8;
 int blue_bit = (colore_del_pixel_100_100 & 0xff);
 int alpha_bit = (colore_del_pixel_100_100 & 0xff000000)>>24;
 
 
 fill(c);
 rect(0,0,100,100);
 fill(255);
 text("R:"+rosso+ " G:"+verde + " B:" +blue+ " A:"+alpha,20,150);
 text("R:"+red_bit+ " G:"+green_bit + " B:" +blue_bit+ " A:"+alpha_bit,20,200);
 }
 */
PImage immagine;
boolean filtro_attivo = true;

void setup() {
  size(800, 500);
  immagine = loadImage("ny.jpg");
}

void draw() {
  image(immagine, 0, 0);
  loadPixels();

  /*
  for (int i=0; i<width*height; i++) {
   int mioPixel = pixels[i];
   int r = (mioPixel & 0xff0000)>>16;
   int g = (mioPixel & 0xff00)>>8;
   int b = (mioPixel & 0xff);
   int media_tra_g_e_b = (g+b)/2;
   if (media_tra_g_e_b>128) {
   r = media_tra_g_e_b<<16;
   g = media_tra_g_e_b<<8;
   b = media_tra_g_e_b;
   pixels[i] = r|g|b;
   }
   }
   */
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int mioPixel = pixels[y*width+x];
      int r = (mioPixel & 0xff0000)>>16;
      int g = (mioPixel & 0xff00)>>8;
      int b = (mioPixel & 0xff);
      int media_tra_g_e_b = (g+b)/2;
      if (media_tra_g_e_b>128) {
        r = media_tra_g_e_b<<16;
        g = media_tra_g_e_b<<8;
        b = media_tra_g_e_b;
        pixels[y*width+x] = r|g|b;
      }
    }
  }

  if (filtro_attivo) {
    updatePixels();
  }
}

void mouseClicked() {
  filtro_attivo = !filtro_attivo;
}
