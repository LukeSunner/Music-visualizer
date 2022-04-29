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
BeatDetect Beat;

int num = 15;
float[] posX = new float[num];
float[] posY = new float[num];
float[] size = new float[num];

void setup() {
  size(1024, 512); // The size of the window in pixels.
  colorMode(HSB); // The colour mode that is used in the project.
  rectMode(CENTER);
  minim = new Minim(this); // Calling the minim sound library.
  ai = minim.getLineIn(Minim.STEREO, 1024);
  ap = minim.loadFile("song.mp3");//audio from file
  ap.play(); // Used to play the sudio file assosiated.
  ap.loop();
  Beat = new BeatDetect();

  ab = ap.mix;
  lerpedAverage = average;
  for (int x = 0; x<posX.length; x++) {
    posX[x] = random(0, width);
    posY[x] = random(0, height);
    size[x] = random(50, 100);
  }
}

float average;
float lerpedAverage = 0;
float angle;

void draw() {
  background(random(255)*lerpedAverage, random(255)*lerpedAverage, random(255)*lerpedAverage);
  drawScreenOne();
  timer();
}
void drawScreenOne() {
  float sum = 0;
  for (int i = 0; i<ab.size(); i+=20){
  for (int j = 0; j<ab.size(); j+=20) {
    sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
    rect(i,j,lerpedAverage*100,lerpedAverage*100);
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  }
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
    sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
    noStroke();
    fill(lerpedAverage*2000, 255, 255);
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
  fill(lerpedAverage*500, 255, 255);
  rect(0, 0, lerpedAverage*1000, 180/2);
}
void drawScreenFour() {
  float sum= 0;
  int y = 0;

  while (y<=width) {
    line(y*lerpedAverage, 50, y, 450);
    line(y, 50, y*lerpedAverage, 450);
    y=y+ width/50;
  }
  for (int x=0; x<posX.length; x++) {
    fill(lerpedAverage*500, lerpedAverage*500, random(255));
    ellipse(posX[x], posY[x], size[x], size[x]);
    for (int i = 0; i<ab.size(); i++) {
      sum +=abs(ab.get(i));
      float average = sum/(float)ab.size();
      noStroke();
      fill(lerpedAverage*500, lerpedAverage*500, random(255));
      ellipse(posX[x], posY[x], size[x]*lerpedAverage, size[x]);
      fill(0);
      ellipse(posX[x], posY[x], size[x]/3, size[x]/3);
      lerpedAverage = lerp(lerpedAverage, average, 0.1f);
    }
  }
}
void drawScreenFive() {

  float sum = 0;
  int x = 0;
  int y = 0;
  int radius = 50;
  int YCoord = height/2;
  int rectHeight = 40;
  int rectWidth = 30;
   background(0);
  for(int j = 0;j<width;j+=5){
    noStroke();
    float z = map(y, 0, ab.size(), 0, 255);
      fill(z, 255, 255);
  rect(j,height/3, 20,30);
  rect(j,(height/3)*2, 20,30);
  }
  while (x < width) {
    y=0;
    while ( y < height) {
      stroke(0);
      float z = map(y, 0, ab.size(), 0, 255);
      fill(z, 255, 255);
      ellipse(x + radius/2, y + radius/2, radius, radius);
      y += radius;
    }
    x += radius;
  }
  for (int i = 0; i<width; i+= rectWidth) {
    sum +=abs(ab.get(i));
    Beat.detect(ap.mix);
    float average = sum/(float)ab.size();
    float c = map(rectHeight, 0, ab.size(), 0, 255);
    fill(c, 255, 255);
    rect(i, YCoord, 20, rectHeight);
    if (Beat.isOnset()) {
      rectHeight = 300;
      if (rectHeight <30) {
        rectHeight = 40;
      }
      lerpedAverage = lerp(lerpedAverage, average, 0.1f);
    }
  }

}
void drawScreenSix() {
   float sum = 0;
  for (int i = 0; i<ab.size(); i++) {
    sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
    //background(0);
    fill(lerpedAverage*500, lerpedAverage*500, random(255));
    circle(50*lerpedAverage*100, height/2, 50);
    circle(width-50*lerpedAverage*100, height/2, 50);
    circle(50*lerpedAverage*100, 50*lerpedAverage*100, 50);
    circle(width/2, 50*lerpedAverage*100, 50);
    circle(width/2, height-50*lerpedAverage*100, 50);
    circle(50*lerpedAverage*100, height-50*lerpedAverage*100, 50);
    circle(width-50*lerpedAverage*100, height-50*lerpedAverage*100, 50);
    circle(width-50*lerpedAverage*100, 50*lerpedAverage*100, 50);
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  }
  }

void timer() {
}
