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
  sample = minim.loadFile("data//sample.mp3");
}

void draw() {
  /*display title*/
  sample.play();
  background((int)(Math.random()*101));
}