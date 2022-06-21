
public int TILESIZE = 40;
public PImage[] blockImgs = new PImage[3];

void setup() {
  size(800,600);
  loadImages();
}

void loadImages() {
  blockImgs[0] = loadImage("crackedTile.png");
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
  background(0);
  player.update();
  player.disp();
  print(blockImgs[0]);
}