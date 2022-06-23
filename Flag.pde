public class Flag {
  PRect rect;
  char type;
  PImage img;
  int flagHeight = 0;
  public boolean won = false;
  
  public Flag(int x, int y) { //daws the flag and hitbox/ 
    rect = new PRect(x, y, 40, 400);
    img = flagpoleIMG;
  }
  
  public void disp() { 
    image(flagpoleIMG, rect.x - cameraOffset, rect.y-360);
    image(flagIMG, rect.x-16 - cameraOffset, (rect.y-345)+flagHeight);
    castle.resize(200,200);
    image(castle, rect.x + 100 -cameraOffset, rect.y-160); //fixed!
    if (player.rect.x >= rect.x) { //drops the flag if you get to it. 
      won = true;
    }
    if (won == true && flagHeight <= 300) {
      flagHeight += 3;
    }
  }
}
