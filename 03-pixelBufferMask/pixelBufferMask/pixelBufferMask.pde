

void setup() {
  PImage img = loadImage("prinzipal.jpg");
  size(639, 959); 
  background(100, 130, 50);    // green
  for (int i=0; i<3000; i++) {
    rect(random(width), random(height), 5+random(20), 5+random(20));
    // circle variation
    //float r = 5+random(20);
    //noStroke();
    //ellipse(random(width), random(height), r, r);
  } 
  loadPixels();
  img.mask(pixels);
  image(img, 0, 0);
} // end setup()
