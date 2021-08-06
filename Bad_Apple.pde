import processing.sound.*;
SoundFile BadMusic;

int i;  //i変数

int screen = 0; //スクリーン用変数
int loop = 0; //ループ用変数 1=ループ
String [] loop_mes ={"Disable", "Enable"}; //ループ設定メッセージ用

boolean debug = true; //debug用 true = DebugMode

PImage [] BadApple = new PImage[2192]; //BadApple　連番画像分

PImage start_logo;
PImage github;
PImage youtube;

boolean github_Button = false;
boolean youtube_Button = false;

void setup() {
  size(480, 360); //元動画の解像度が360pのため
  frameRate(10); //一秒あたり10枚で出力したため
  background(0);
  fill(255);
  textSize(45);
  textAlign(CENTER);
  text("Now Loading...", 240, 180); //ロードメッセージ
  if (debug == true) { //デバッグメッセージ
    text("Debug Mode", 240, 270);
  }
  start_logo = loadImage("start_logo.png"); //スタート画面画像読込
  github = loadImage("github.png"); //Github画像読込
  youtube = loadImage("youtube.png"); //YouTube画像読込
  for (i=1; i<=2192; i++) {
    BadApple[i-1] = loadImage("bad_images/"+i+".jpg"); //BadApple連番画像読込
    if (debug == true) {
      println("読み込み中の画像番号 : "+i);
    }
  }

  i=0; //i変数リセット

  BadMusic = new SoundFile(this, "Bad Apple.mp3"); //mp3読込
}

void draw() {
  if (screen == 0) {
    start_screen();
    check_Button();
  } else if (screen == 1) {
    BadApple();
  }
}

void BadApple() { //再生部
  if (i!=0 && i<2192) {
    if (debug == true) {
      println("現在の画像番号 : "+ (i-1));
    }
    image(BadApple[i-1], 0, 0);
    i++;
  }
  if (i==2192) {
    if (loop == 0) { //ループ再生無効
      BadMusic.stop();
      i=0;
      screen = 0;

      if (debug == true) { //デバッグメッセージ
        println("ループ再生無効");
        println("i変数が"+i+"に変更されました");
        println("screen変数が"+screen+"に変更されました");
      }
    } else if (loop == 1) { //ループ再生有効
      BadMusic.stop();
      i=1;
      if (debug == true) { //デバッグメッセージ
        println("ループ再生有効");
        println("i変数が"+i+"に変更されました");
      }
      BadMusic.play();
    }
  }
}

void start_screen() {
  i = 0;
  screen = 0;
  image(start_logo, 0, 0);
  image(github, 360, 110);
  image(youtube, 360, 215);
  textSize(30);
  fill(255);
  text("Bad Apple by Processing", 190, 40);
  textSize(25);
  text("Loop Setting", 85, 110);
  switch(loop) {
  case 0:
    text(loop_mes[0], 85, 145);
    break;
  case 1:
    text(loop_mes[1], 85, 145);
    break;
  }
  textSize(14);
  text("Cursor key to change", 75, 165);
  textSize(25);
  text("Backspace to finish playing", 185, 330);

  if (debug == true) {
    textSize(30);
    fill(0);
    text("Debug", 235, 185);
  }
}

void keyPressed() {
  if (screen == 0) {
    if (key == ENTER) {  //再生判定部
      i = 1;
      screen = 1;
      BadMusic.play();
      if (debug == true) { //デバッグメッセージ     
        println("i変数が"+i+"に変更されました");
        println("screen変数が"+screen+"に変更されました");
      }
    }
    if (key == CODED) {    //キー入力判定部
      switch(keyCode) {
      case LEFT:
        loop = 0;
        if (debug == true) {
          println("loop変数が"+loop+"に変更されました");
        }
        break;
      case RIGHT:
        loop = 1;
        if (debug == true) {
          println("loop変数が"+loop+"に変更されました");
        }       
        break;
      }
    }
  }
  if (screen == 1) {  //中断判定部
    if (key == BACKSPACE) {
      i = 0;
      screen = 0;
      loop = 0;
      BadMusic.stop();
      if (debug == true) { //デバッグメッセージ     
        println("i変数が"+i+"に変更されました");
        println("screen変数が"+screen+"に変更されました");
      }
    }
  }
}

void check_Button() { //マウス座標判定部
  if (mouseX > 360 && mouseX < 445 && mouseY > 115 && mouseY < 195) {
    github_Button = true;
  } else {
    github_Button = false;
  }
  if (mouseX > 355 && mouseX < 450 && mouseY > 215 && mouseY < 280) {
    youtube_Button = true;
  } else {
    youtube_Button = false;
  }
}

void mousePressed() {
  if (screen == 0) {
    if (github_Button) {
      link("https://github.com/nitgc-null/Bad-Apple-by-Processing-NITGC");
      if (debug == true) {
        println("Githubリンクがクリックされました");
      }
    }
    if (youtube_Button) {
      link("https://www.youtube.com/watch?v=FtutLA63Cp8");
      if (debug == true) {
        println("Youtubeリンクがクリックされました");
      }
    }
  }
}
