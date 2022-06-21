public int TILESIZE = 40;
public boolean start = false;
public PImage[] blockImgs = new PImage[3];
PImage open;

void setup() {
  size(800,600);
  loadImages();
}

void loadImages() {
  blockImgs[0] = loadImage("crackedTile.png");
  open = loadImage("image.png");
}

Player player = new Player();

void keyPressed() {
  if (keyCode == UP && !player.forceStop && !player.jump) {
    player.jump = true;
    player.firstFrame = true;
    player.jumpPress = millis();
  }
  if (keyCode == RIGHT) {
    player.goRight = true;
  } else if (keyCode == LEFT) {
    player.goLeft = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    player.jump = false;
    player.forceStop = false;
  }
  if (keyCode == RIGHT) {
    player.goRight = false;
  } else if (keyCode == LEFT) {
    player.goLeft = false;
  }
}

void draw() {
  //println(start);
  if (!start) {
    image(open, 0, 0);
    fill(7,113,20);
    rect(280, 350,230,100);
    if (keyCode == ENTER) {
      start = true;
    }
  } else {
    background(0, 128, 255);
    player.update();
    player.disp();
    print(blockImgs[0]);
  }
}
