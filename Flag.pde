public class Flag {
  PRect rect;
  char type;
  PImage img;
  int flagHeight = 0;
  public boolean won = false;
  
  public Flag(int x, int y) {
    rect = new PRect(x, y, 40, 400);
    img = flagpoleIMG;
  }
  
  public void disp() {
    
    image(flagpoleIMG, rect.x - cameraOffset, rect.y-360);
    image(flagIMG, rect.x-16 - cameraOffset, (rect.y-345)+flagHeight);
    if (player.rect.x >= rect.x) {
      won = true;
    }
    if (won == true && flagHeight <= 300) {
      flagHeight += 3;
    }
  }
}
