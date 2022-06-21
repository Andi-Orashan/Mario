public class Flag {
  PRect rect;
  char type;
  PImage img;
  public boolean won;
  
  public Flag(int x, int y, char type) {
    rect = new PRect(x, y, 40, 400);
    this.type = type;
    switch (type) {
      case 'F':
        img = flagpoleIMG;
    }
  }
  
  public void disp() {
    image(img, rect.x, rect.y-400);
    text(str(won), 10, 10);
    if (player.rect.x >= rect.y) {
      won = true;
    }
  }
}
