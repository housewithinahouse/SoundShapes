/**
 * This sketch shows how to use the Amplitude class to analyze the changing
 * "loudness" of a stream of sound. In this case an audio sample is analyzed.
 */

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;

// Declare a smooth factor to smooth out sudden changes in amplitude.
// With a smooth factor of 1, only the last measured amplitude is used for the
// visualisation, which can lead to very abrupt changes. As you decrease the
// smooth factor towards 0, the measured amplitudes are averaged across frames,
// leading to more pleasant gradual changes
float smoothingFactor = 0.5;

// Used for storing the smoothed amplitude value
float sum;

float[] amps = new float[600];
int currentAmp = 0;

public void setup() {
  size(1020, 720);

  //Load and play a soundfile and loop it
  sample = new SoundFile(this, "413377__mbari-mars__gray-whale.wav");
  sample.play();

  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
  frameRate(20);
}      

public void draw() {  
  if(currentAmp>1019){
    save("soundshape.jpg");
  }
  else if (currentAmp<=1019){
    sum += (rms.analyze() - sum) * smoothingFactor;
    currentAmp+=1;
    strokeWeight(2);
    float rms_scaled = sum * (height/2) * 2;
    line(currentAmp, height/2, currentAmp, (height/2)+(rms_scaled));
    line(currentAmp, height/2, currentAmp, (height)-(height/2+(rms_scaled)));
  }
}
