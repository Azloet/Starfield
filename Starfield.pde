import ddf.minim.*;

Minim minim;
AudioPlayer music;

public void setup()
{
  size(550, 500);
  smooth();
  background(255);

  /*initialize sounds*/
  minim = new Minim(this);
  music = minim.loadFile("data//sample.mp3");
}

void draw() {
  /*display title*/
  music.play();
  background((int)(Math.random()*101));
}