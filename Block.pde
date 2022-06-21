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
    }
  }
  
  public void disp() {
    image(img, rect.x, rect.y);
  }
}
