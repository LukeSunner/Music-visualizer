import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim; //Minim Library
AudioBuffer ab; //Gives access to the samples
AudioPlayer ap; // Used to play audio


AudioInput ai; //Takes in audio



void setup() {
  size(1024, 512); // The size of the window in pixels.
  colorMode(HSB); // The colour mode that is used in the project.
  rectMode(CENTER);
  minim = new Minim(this); // Calling the minim sound library.
  ai = minim.getLineIn(Minim.STEREO, 1024);
  ap = minim.loadFile("song.mp3");//audio from file
  ap.play(); // Used to play the sudio file assosiated.
  ab = ap.mix;
 
  lerpedAverage = average;
}
float average;
float lerpedAverage = 0;

float angle;

void draw() {
 background(lerpedAverage*4000);
  stroke(255);
  drawScreenThree();
  timer();
}
void drawScreenOne() {
  float sum = 0;
  for (int i = 0; i<ab.size(); i++) {

    //line(i,height/2,i,(height/2)+ab.get(i)*250);
    sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
    circle(width/2, height/2, lerpedAverage*1000);
    circle(width/3, height/2, average*1000);
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  }
}
void drawScreenTwo() {
  background(0);
  float sum = 0;
  for (int i = 0; i<ab.size(); i++) {
    sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
    fill(lerpedAverage*1000, 255, 255);
    circle(width/2, height/2, lerpedAverage*3000);
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  }
  stroke(255);
  for (int i = 0; i < ab.size(); i ++) // buffer.size will be 1024
  {
    float c = map(i, 0, ab.size(), 0, 255);
    stroke(c, 255, 255);
    float sample = ab.get(i) * (height / 2);
    line(i, height / 2, i, (height / 2) + sample);
  }
}
void drawScreenThree() {
  
  
   float sum = 0;
  for (int i = 0; i<ab.size(); i++) {

    
    //line(i,height/2,i,(height/2)+ab.get(i)*250);
    sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
    noStroke();
    fill(lerpedAverage*2000,255,255);
    circle(lerpedAverage*1000, height/2, lerpedAverage*1000);
    circle(width/2, lerpedAverage*1000, lerpedAverage*1000);
    circle(width+-lerpedAverage*1000, height/2, lerpedAverage*1000);
    circle(width/2, height+-lerpedAverage*1000, lerpedAverage*1000);
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  }
  angle = angle+lerpedAverage*1000;
  float c = cos(angle);
  translate(width/2, height/2);
  rotate(c);
  fill(lerpedAverage*500, 255,255);
  rect(0,0,lerpedAverage*1000,180/2);
  

}
void drawScreenFour() {
}
void drawScreenFive() {
}
void drawScreenSix() {
}
void timer() {
}
