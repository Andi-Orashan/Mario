public class Flag {
  PRect rect;
  char type;
  PImage img;
  int flagHeight = 0;
  public boolean won = false;
  
  public Flag(int x, int y, char type) {
    rect = new PRect(x, y, 40, 400);
    img = flagpoleIMG;
  }
  
  public void disp() {
    
    image(flagpoleIMG, rect.x, rect.y-360);
    image(flagIMG, rect.x-16, (rect.y-345)+flagHeight);
    if (player.rect.x >= rect.x) {
      won = true;
      print(won);
      print(flagHeight);
    }
    if (won == true && flagHeight <= 300) {
      flagHeight++;
    }
  }
}
