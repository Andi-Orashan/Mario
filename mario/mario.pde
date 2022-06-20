void setup() {
  size(800,600);
}
Player player = new Player();

void keyPressed() {
  if (keyCode == UP && !player.forceStop && !player.jump) {
    player.jump = true;
    player.firstFrame = true;
    player.jumpPress = millis();
  }
}

void keyReleased() {
  if (keyCode == UP) {
    player.jump = false;
    player.forceStop = false;
  }
}

void draw() {
  background(0);
  player.update();
  player.disp();
}
