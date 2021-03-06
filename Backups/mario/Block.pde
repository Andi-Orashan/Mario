public class Block {
  PRect rect;
  char type;
  PImage img;
  
  public Block(int x, int y, char type) {
    rect = new PRect(x, y, TILESIZE, TILESIZE);
    this.type = type;
    switch (type) {
      case 'G':
        img = blockImgs[0];
        break;
      case 'B':
        img = blockImgs[2];
        break;
      case 'M':
        img = blockImgs[4];
        break;
      case 'E':
        img = blockImgs[3];
        break;
      case 'D':
        img = blockImgs[1];
        break;
    }
  }
  
  public void disp() {
    image(img, rect.x, rect.y);
  }
}
