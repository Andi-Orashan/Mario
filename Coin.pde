public class Coin {
  PImage img;
  PVector pos;
  float grav = 17.4/60, velY;
  
  public Coin (float x, float y) {
    pos = new PVector();
    pos.x = x; pos.y = y;
    velY = -7;
    player.coin++;
  }
  
  public void gravity() {
    velY += grav; // continually add increase velocity
  }
  
  public void disp() {
    img = coinIMG;
    image(img, pos.x - cameraOffset, pos.y);
  }
  
  public void update() {
    gravity();
    pos.y += velY;
  }
  
}
