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

void setup(){
  size(1024,512); // The size of the window in pixels.
  colorMode(HSB); // The colour mode that is used in the project.
  minim = new Minim(this); // Calling the minim sound library.
  ap = minim.loadFile("song.mp3");//audio from file
  ap.play(); // Used to play the sudio file assosiated. 
  ab = ap.mix;
  lerpedAverage = average;
}
float average;
float lerpedAverage = 0;

void draw(){
  background(0);
  stroke(255);
  drawScreenOne();
  }
  
  void drawScreenOne(){
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
  void drawScreenTwo(){
  }
  void drawScreenThree(){
  }
  void drawScreenFour(){
  }
  void drawScreenFive(){
  }
  void drawScreenSix(){
  }
