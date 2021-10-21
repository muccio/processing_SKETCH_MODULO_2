import processing.sound.*;

AudioIn input;
Amplitude ampiezza;

int numero_rettangoli = 100;
float px[] = new float[numero_rettangoli];
float py[] = new float[numero_rettangoli];
float pr[] = new float[numero_rettangoli];

void setup(){
  size(800,800);
  input = new AudioIn(this,0);
  ampiezza = new Amplitude(this);
  ampiezza.input(input);
  for(int i=0;i<numero_rettangoli;i++){
    px[i] = random(width);
    py[i] = random(height);
    pr[i] = random(360);
  }
}

void draw(){
  background(0);
  fill(255,160);
  for(int i=0;i<numero_rettangoli;i++){
    pushMatrix();
    rectMode(CENTER);
    translate(px[i],py[i]);
    rotate( radians(pr[i]+ampiezza.analyze()*45) );
    rect(0,0,5,2*width);
    popMatrix();
  }
}
