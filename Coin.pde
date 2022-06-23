public class Coin {
  PImage img;
  PVector pos;
  float grav = 17.4/60, velY;
  
  public Coin (int x, int y) {
    pos = new PVector();
    pos.x = x; pos.y = y;
    velY = 4;
  }
  
  public void gravity() {
    velY += grav; // continually add increase velocity
  }
  
  public void disp() {
    img = coinIMG;
    image(img, pos.x, pos.y);
  }
  
  public void update() {
    pos.y += velY;
  }
  
}
