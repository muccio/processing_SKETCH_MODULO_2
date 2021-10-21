import processing.sound.*;

AudioIn input;
Amplitude ampiezza;

void setup(){
  size(800,800);
  input = new AudioIn(this,0);
  ampiezza = new Amplitude(this);
  ampiezza.input(input);
}

void draw(){
  background(0);
  
  stroke(255);
  noFill();

  for(int i=1;i<30;i++){
    pushMatrix();
    translate(width/2,height/2);
    float dimensione = 0.5+ampiezza.analyze();
    scale(dimensione,dimensione);
    rotate(radians(180+i*ampiezza.analyze()*400/100.0));
    rectMode(CENTER);
    rect(0,0,200,200);
    popMatrix();
  }
  
}
