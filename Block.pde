public class Block {
  PRect rect;
  char type;
  PImage img;
  int frame, frameDelay;
  boolean full, draw;
  // which block is this? and lets grab its sprites. Hitboxes are somewhereelse.   
  public Block(int x, int y, char type) {
    frame = 0; frameDelay = 0;
    rect = new PRect(x, y, TILESIZE, TILESIZE);
    this.type = type;
    draw = true;
    switch (type) { 
      case 'G': // ground
        img = blockImgs[0];
        break;
      case 'B': // bricks
        img = blockImgs[2];
        break;
      case 'M': // yellow block
        img = blockImgs[4];
        full = true;
        break;
      case 'E': // empty block
        img = blockImgs[3];
        full = false;
        break;
      case 'D': // other block 
        img = blockImgs[1];
        break;
    }
  }
  //displays the picture. 
  public void disp() {
    if (draw) {
      image(img, rect.x - cameraOffset, rect.y);
      if (full == false && type == 'M') {
        img = blockImgs[3];
      }
    } else {
      if (frameDelay + 200 <= millis()) {
        frame += 1;
        frame = min(frame, 6);
      }
      breakImgs[frame].resize(40, 40);
      image(breakImgs[frame], rect.x - cameraOffset, rect.y);
    }
  }
}
