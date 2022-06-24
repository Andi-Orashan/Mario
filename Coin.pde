public class Coin {
  PImage img;
  PVector pos;
  float grav = 17.4/60, velY;
  
  public Coin (float x, float y) {
    pos = new PVector();
    pos.x = x; pos.y = y; /// use a 2D vector for position
    velY = -7;
    player.coin++; // add one coin to the coin count
  }
  
  public void gravity() {
    velY += grav; // continually increase velocity
  }
  
  public void disp() {
    img = coinIMG;
    image(img, pos.x - cameraOffset, pos.y); // account for scrolling
  }
  
  public void update() {
    gravity(); // use gravity
    pos.y += velY; // update y position
  }
  
}
