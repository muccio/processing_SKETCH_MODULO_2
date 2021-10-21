

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;

// Declare a scaling factor
float scale = 5.0;

// Declare a smooth factor
float smoothFactor = 0.25;

// Used for smoothing
float sum;


  

import processing.sound.*;
AudioIn in;

void setup() {
  size(640, 360);
  background(255);
    
  // Create the Input stream
  in = new AudioIn(this, 0);
  in.amp(0.5);
  in.play();
  
  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(in);
}      
    

void draw() {
  // Set background color, noStroke and fill color
  background(0, 0, 255);
  noStroke();
  fill(255, 0, 150);

  // Smooth the rms data by smoothing factor
  sum += (rms.analyze() - sum) * smoothFactor;  

  // rms.analyze() return a value between 0 and 1. It's
  // scaled to height/2 and then multiplied by a scale factor
  float rmsScaled = sum * (height/2) * scale;

  // Draw an ellipse at a size based on the audio analysis
  ellipse(width/2, height/2, rmsScaled, rmsScaled);
}
