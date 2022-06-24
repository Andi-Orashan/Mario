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
    image(flagIMG, rect.x - 16 - cameraOffset, (rect.y-345)+flagHeight);
    castle.resize(200,200);
    image(castle, rect.x + 100 -cameraOffset, rect.y-160); //fixed!
    peach.resize(40,40);
    image(peach, rect.x + 180 - cameraOffset, rect.y);
    if (player.rect.x >= rect.x) { //drops the flag if you get to it. 
      if (flagHeight <= 300) {
        flagHeight += 3;
      } else {
        won = true;
        level++;
        pReset();
        won = false;
        if (level == 4) {
          won = true;
        }
      }
    }
  }
}
