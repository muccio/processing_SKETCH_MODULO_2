

void setup() {
  PImage img = loadImage("colony.tif");
  PImage msk = loadImage("mask.tif");
  background(0);
  size(300, 280);
  img.mask(msk);
  image(img, 0, 0);
} // end setup()
