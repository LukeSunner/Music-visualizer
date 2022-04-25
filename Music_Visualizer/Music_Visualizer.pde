import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioBuffer ab;
AudioPlayer ap;
AudioInput ai;

void setup(){
  size(1024,500);
  colorMode(HSB);
  minim = new Minim(this);
  //ai = minim.getLineIn(Minim.MONO,1024,44100,16);// audio from microphone
  ap = minim.loadFile("song.mp3");//audio from file
  ap.play();
  ab = ap.mix;
  lerpedAverage = average;
}
float average;
float lerpedAverage = 0;
void draw(){
  background(0);
  stroke(255);
  float sum = 0;

  for(int i = 0; i<ab.size();i++){
  
 //line(i,height/2,i,(height/2)+ab.get(i)*250);
 sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
  circle(width/2,height/2,lerpedAverage*1000);
    circle(width/3,height/2,average*1000);
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  
  }
}
