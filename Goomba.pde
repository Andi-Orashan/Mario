public class Goomba {
  PRect rect;
  
  public Goomba(float x, float y) {
    rect = new PRect(x, y, 32, 32);
  }
  
  public void disp() {
    goombaIMG.resize(32, 32);
    image(goombaIMG, rect.x - cameraOffset, rect.y);
  }
  
  public void update() {
    rect.left -= 2;
    rect.update();
  }
}
