import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import processing.sound.*;

particella[] pippi;
SoundFile sample;
AudioIn input;
FFT fft;
int bands = 256;
float smoothingFactor = 0.2;
float[] sum = new float[bands];
int scale = 5;
PostFX fx;
Amplitude ampiezza;

void setup(){
  size(1280,960, P3D);
  pippi = new particella[bands];
  for(int i=0;i<bands;i++){
    pippi[i] = new particella();
    pippi[i].banda_della_particella = (44100/bands)*i;
  }
  
  //sample = new SoundFile(this, "Antony.wav");
  //sample.loop();
  input = new AudioIn(this, 0);
  input.start();
  fft = new FFT(this, bands);
  fft.input(input);
  ampiezza = new Amplitude(this);
  ampiezza.input(input);
  
  fx = new PostFX(this); 
}

void draw(){
  background(0);
  fft.analyze();
  
  
  for (int i = 0; i < bands; i++) {
    sum[i] += (fft.spectrum[i] - sum[i]) * smoothingFactor;
    rect(i*width/float(bands), height, 
      width/float(bands), -sum[i]*height*scale
      );
  }
  
  for(int i=0;i<bands;i++){
    pippi[i].aggiorna();
    sum[i] += (fft.spectrum[i] - sum[i]) * smoothingFactor;
    pippi[i].dimensione = 10 + sum[i]*70*scale;
    pippi[i].trasparenza = 255 - sum[i]*255*scale;
    pippi[i].disegna();
  }
  fx.render()
    .bloom(0.2, 10, 15)
    .compose();
    
  float amp = ampiezza.analyze()*100.0;
  if(amp>6.0)mousePressed();
  //println(amp);
}

void mousePressed(){
    float cx= width/2;
    float cy= height/2;
  for(int i=0;i<bands;i++){
    float px = pippi[i].posizione.x;
    float py = pippi[i].posizione.y;
    float dx = cx-px;
    float dy = cy-py;
    float max = max(abs(dx),abs(dy));
    float mx = 5*(dx/max);
    float my = 5*(dy/max);
    pippi[i].accelerazione.x=mx;
    pippi[i].accelerazione.y=my;
  }
}
