import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim; //Minim Library
AudioBuffer ab; //Gives access to the samples
AudioPlayer ap; // Used to play audio
AudioBuffer buffer;

AudioInput ai; //Takes in audio

float eRadius;

void setup(){
  size(1024,512); // The size of the window in pixels.
  colorMode(HSB); // The colour mode that is used in the project.
  minim = new Minim(this); // Calling the minim sound library.
  ap = minim.loadFile("song.mp3");//audio from file
  ap.play(); // Used to play the sudio file assosiated. 
  buffer = ap.left;
  ab = ap.mix;
  
  lerpedAverage = average;
}
float average;
float lerpedAverage = 0;

void draw(){
  background(0);
  stroke(255);
  drawScreenTwo();
  timer();
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
      background(0);
      float sum = 0;
         for(int i = 0; i<ab.size();i++){
  
 
 sum +=abs(ab.get(i));
    float average = sum/(float)ab.size();
    float random = random(0,ab.size());
    fill(random, random,random);
  circle(width/2,height/2,lerpedAverage*3000);
 
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  
  }
  
    
  
  stroke(255);
 for (int i = 0; i < buffer.size(); i ++) // buffer.size will be 1024
  {
    float c = map(i, 0, buffer.size(), 0, 255);
    stroke(c, 255, 255);
    float sample = buffer.get(i) * (height / 2);
    
    line(i, height / 2, i, (height / 2) + sample);
     
  }
 
  }
  void drawScreenThree(){
  }
  void drawScreenFour(){
  }
  void drawScreenFive(){
  }
  void drawScreenSix(){
  }
  void timer(){
   
    
    
    
    
  }
