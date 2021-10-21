import processing.sound.*;

AudioIn input;
Amplitude ampiezza;

void setup(){
  size(800,800);
  input = new AudioIn(this,0);
  ampiezza = new Amplitude(this);
  ampiezza.input(input);
  
}
float velocita_angolare = 0.05;
float angolo=0.0;
void draw(){
  background(0);
  translate(400,400);
  velocita_angolare = 0.05 + ampiezza.analyze();

  angolo += velocita_angolare;
  rotate(angolo);
  rectMode(CENTER);
  rect(0,0,100,10);
  rect(0,0,10,100);
  
  
}
