//your code here
import ddf.minim.*;
Minim minim;
AudioPlayer ymusic,rmusic,fireworkSound;

Particle[] fireworks = new Particle[200];
Star[] stars = new Star[500];
Glitter[] glitter = new Glitter[500];

int numOddballs;
int ylimit;
boolean firstLoop;
float time;

void setup()
{
  minim = new Minim(this);
  ymusic = minim.loadFile("data//Moseni_hydrangea.mp3");
  rmusic = minim.loadFile("data//BGM032.mp3");
  fireworkSound = minim.loadFile("data//fireworks.mp3");

  size(500,500);
  colorMode(HSB,360,100,100,100);

  numOddballs = 1;

  newFireworks();
  
  for(int i = 0; i < stars.length-1; i++){
    stars[i] = new Star();
    //float rndTime = (float)(Math.random()*300)+0;
    //stars[i].x += Math.cos(stars[i].angle)*rndTime;
    //stars[i].y += Math.sin(stars[i].angle)*rndTime*2/3;
  }
  for(int i = stars.length-1; i < stars.length; i++){
    stars[i] = new Moon();
  }
  
  for(int i = 0; i < glitter.length-200; i++){
    glitter[i] = new Glitter();
  }
  for(int i = glitter.length-200; i < glitter.length; i++){
    glitter[i] = new SkyGlitter();
  }
}

void draw()
{
  //your code here
  noStroke();
  
  for(int i = glitter.length-200; i < glitter.length; i++){
    glitter[i].show();
  }
  
  for(int i = 0; i < stars.length; i++){
    stars[i].move();
    stars[i].show();
  }

  fill(0,0,0,5);
  rect(0,0,500,400);
  for(int i = 1; i <= 10; i++){
    fill(240,5*i+20,30-i,20);
    rect(0,500-10*i,500,10);
  }

  
  if(fireworks[0].y > ylimit){
    for(int i = 0; i < numOddballs; i++){
      fireworks[i].move();
      fireworks[i].show();
    }
    if(fireworkSound.position()>5500){
      fireworkSound.pause();
    }
  }
  else{
    int onScreen = 0;
    for(int i = numOddballs; i < fireworks.length; i++){
      if(firstLoop){
        fireworks[i].x = fireworks[0].x;
      }
      fireworks[i].alpha-=0.5;
      fireworks[i].move();
      fireworks[i].show();
      if(((fireworks[i].x>0||fireworks[i].x<500)&&(fireworks[i].y>0||fireworks[i].y<500))&&(fireworks[i].alpha>-15)){
        onScreen += 1;
      }
    }
    time += 0.5;
    firstLoop = false;
    if(onScreen == 0){
      newFireworks();
    }
    else{
      for(int i = 0; i < glitter.length-200; i++){
        glitter[i].alpha = (100-time)*Math.random();
        glitter[i].show();
      }
      if(fireworkSound.position()<5600){
        fireworkSound.play();
        fireworkSound.cue(5600);
      }
    }
  }
}

void mousePressed(){
  rmusic.loop();
}

void newFireworks(){
  time = 0;
  ylimit = (int)(Math.random()*100)+100;
  firstLoop = true;

  fireworkSound.play();
  fireworkSound.cue(2500+(int)(ylimit-99)*12);
  
  double commonX = (double)((Math.random()-0.5)*300)+250;
  double commonAngle = (double)(Math.random()-0.5)*PI/4;
  
  for(int i = 0; i < numOddballs; i++){
    fireworks[i] = new OddballParticle();
    fireworks[i].x += commonX;
    fireworks[i].angle += commonAngle;
  }
  for(int i = numOddballs; i < fireworks.length; i++){
    fireworks[i] = new Particle();
    fireworks[i].y = ylimit;
  }
}

class Particle
{
  //your code here
  double x,y,speed,angle,rotation,radius,alpha;
  int hue,saturation,brightness,size;
  
  Particle(){
    x = 0;
    y = 0;
    speed = (double)(Math.random()*1)+0.1;
    angle = (double)(Math.random()*2*PI);
    rotation = (double)(Math.random()*360);
    radius = (double)(Math.random()*1);
    hue = (int)(Math.random()*360);
    saturation = (int)(Math.random()*50)+50;
    brightness = (int)(Math.random()*50)+50;
    alpha = 100;
    size = 5;
  }
  
  void move(){
    x += speed*Math.cos(angle);
    y += speed*Math.sin(angle);
    rotation += 10*speed;
  }
  
  void show(){
    fill(hue,saturation,brightness,(int)alpha);
    pushMatrix();
    translate((float)x,(float)y);
    rotate((float)rotation*PI/180);
    rect((float)radius-(size/2),-(size/2),size,size);
    popMatrix();
  }
}

class OddballParticle extends Particle
{
  OddballParticle(){
    x = 0;
    y = 400;
    speed = (double)(Math.random()*0)+2;
    angle = (double)(Math.random()*0)+3*PI/2;
    rotation = (double)(Math.random()*360);
    radius = (double)(Math.random()*5);
    hue = (int)(Math.random()*0)+0;
    saturation = (int)(Math.random()*0)+0;
    brightness = (int)(Math.random()*30)+70;
    alpha = 100;
    size = 8;
  }
}

class Star extends Particle{
  Star(){
    x = (double)(Math.random()*0)+250;
    y = (double)(Math.random()*0)+200;
    speed = (double)(Math.random()*5)+0.1;
    angle = (double)(Math.random()*0)+0;
    rotation = (double)(Math.random()*360);
    radius = (double)(Math.random()*100);
    hue = (int)(Math.random()*0)+0;
    saturation = (int)(Math.random()*0)+0;
    brightness = (int)(Math.random()*0)+100;
    alpha = 100;
    size = 1;
  }
  void move(){
    rotation += speed;
  }
  void show(){
    fill(hue,saturation,brightness,(int)alpha);
    pushMatrix();
    translate((float)x,(float)y);
    shearX(1);
    rotate((float)rotation*PI/180);
    ellipse((float)radius-(size/2),-(size/2),size,size);
    popMatrix();
  }
}

class Moon extends Star
{
  Moon(){
    x = (double)(Math.random()*0)+250;
    y = (double)(Math.random()*0)+500;
    speed = (double)(Math.random()*0.005)+0;
    angle = (double)(Math.random()*0)+0;
    rotation = (double)(Math.random()*30)+240;
    radius = (double)(Math.random()*0)+450;
    hue = (int)(Math.random()*0)+0;
    saturation = (int)(Math.random()*0)+0;
    brightness = (int)(Math.random()*0)+100;
    alpha = 100;
    size = 100;
  }
  void show(){
    fill(hue,saturation,brightness,(int)alpha);
    pushMatrix();
    translate((float)x,(float)y);
    rotate((float)rotation*PI/180);
    ellipse((float)radius-(size/2),-(size/2),size,size);
    popMatrix();
  }
}

class Glitter extends Particle
{
  Glitter(){
    x = (double)(Math.random()*500)+0;
    y = (double)(Math.random()*100)+400;
    speed = (double)(Math.random()*0)+0;
    angle = (double)(Math.random()*0)+0;
    rotation = (double)(Math.random()*360);
    radius = (double)(Math.random()*0);
    hue = (int)(Math.random()*360)+0;
    saturation = (int)(Math.random()*0)+100;
    brightness = (int)(Math.random()*0)+100;
    alpha = 0;
    size = 1;
  }
}

class SkyGlitter extends Glitter
{
  SkyGlitter(){
    x = (double)(Math.random()*500)+0;
    y = (double)(Math.random()*400)+0;
    speed = (double)(Math.random()*0)+0;
    angle = (double)(Math.random()*0)+0;
    rotation = (double)(Math.random()*360);
    radius = (double)(Math.random()*0);
    hue = (int)(Math.random()*0)+0;
    saturation = (int)(Math.random()*0)+0;
    brightness = (int)(Math.random()*0)+100;
    alpha = 100;
    size = 2;
  }
}
