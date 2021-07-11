import processing.sound.*;
SoundFile BadMusic;

int i;  //i変数

int scene = 0; //シーン用変数
int loop = 0; //ループ用変数 1=ループ

PImage [] BadApple = new PImage[2192];

PImage start_logo;

void setup() {
  size(480, 360);
  frameRate(10);
  background(0);
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Now Loading...", 240, 180);
  start_logo = loadImage("start_logo.png");
  for (i=1; i<=2192; i++) {
    BadApple[i-1] = loadImage("bad_images/"+i+".jpg");
    println(i);
  }

  i=0; //i変数リセット

  BadMusic = new SoundFile(this, "Bad Apple.mp3");
}

void draw() {
  if (scene == 0) {
    start_scence();
  } else if (scene == 1) {
    BadApple();
  }
}

void BadApple() { //再生部
  if (i<2192) {
    println(i);
    image(BadApple[i], 0, 0);
    i++;
  }
  if (i==2192) {
    if (loop == 0) {
      BadMusic.stop();
      scene = 0;
      start_scence();
    } else if (loop == 1) {
      BadMusic.stop();
      i=0;
      BadMusic.play();
    }
  }
}

void start_scence() {
  image(start_logo, 0, 0);
  if (key == CODED) {
    if (keyCode == LEFT) {
      loop = 0;
      println("loop"+loop);
    }
    if (keyCode == RIGHT) {
      loop = 1;
      println("loop"+loop);
    }
  }
  if (key == ENTER) {
    i = 0;
    scene = 1;
    BadMusic.play();
  }
}
