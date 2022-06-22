public class Block {
  PRect rect;
  char type;
  PImage img;
  boolean full;
  // which block is this? and lets grab its sprites. Hitboxes are somewhereelse.   
  public Block(int x, int y, char type) {
    rect = new PRect(x, y, TILESIZE, TILESIZE);
    this.type = type;
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
    image(img, rect.x - cameraOffset, rect.y);
  }
}
