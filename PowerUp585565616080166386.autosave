public class PowerUp {
  PRect rect;
  char pType;
  PImage img;
  PowerUp (float x, float y, int type) {
    switch (type) { 
      case 0: // ground
        pType = 'C';
        img = blockImgs[type];
        break;
      case 1: // bricks
        pType = 'C';
        img = blockImgs[type];
        break;
      }
  }
  public void disp() {
    image(img, rect.x - cameraOffset, rect.y);
  }
}
