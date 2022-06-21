public class Block {
  PRect rect;
  int type;
  
  public Block(int x, int y) {
    rect = new PRect(x, y, TILESIZE, TILESIZE);
  }
}
