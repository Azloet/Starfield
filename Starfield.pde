import ddf.minim.*;

Minim minim;
AudioPlayer sample;

public void setup()
{
  size(550, 500);
  smooth();
  background(255);

  /*initialize sounds*/
  minim = new Minim(this);
<<<<<<< HEAD
  sample = minim.loadFile("data//sample.mp3");
=======
  music = minim.loadFile("data/sample.mp3");
>>>>>>> eb1520db05cdb3935597852b6c9c4305f3a82078
}

void draw() {
  /*display title*/
  sample.play();
  background((int)(Math.random()*101));
}