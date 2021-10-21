
void setup() {
  PImage img = loadImage("prinzipal.jpg");
  size(1278, 959);  //Twice the width so that we can display the result and the original side by side
  PImage msk = createImage(img.width, img.height, RGB); //the mask should be an image the same size as the original
  background(0);
  img.loadPixels();
  msk.loadPixels();
  for (int y=0; y<img.height; y++){
    for (int x=0; x<img.width; x++){
      color c = img.pixels[y*img.width+x];
      if (red(c) + green(c) + blue(c) > 600 || blue(c) > 190) { // cloud or sky
         msk.pixels[y*img.width+x] = 0;
      }
      else {
        msk.pixels[y*img.width+x] = 255;
      } 
    }
  }
  msk.updatePixels();
  image(img, 0, 0);
  img.mask(msk);
  image(img, img.width, 0);
} // end setup()
