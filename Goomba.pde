public class Goomba {
  PRect rect;
  public float velY, accY, grav;
  public int frame, framePause;
  
  public Goomba(float x, float y) {
    rect = new PRect(x, y, 32, 30);
    grav = 17.4/60;
    frame = 0; framePause = millis();
  }
  
  public void animate() {
    if (framePause + 200 <= millis()) {
      frame += 1;
      frame %= 4;
      framePause = millis();
    }
    gImgs[frame].resize(32, 32);
    image(gImgs[frame], rect.x - cameraOffset, rect.y);
  }
  
  public boolean blockTopCollision() { // have you collided with the top of the block?
    for (Block block : blockList) {
      if (rect.bottom + velY > block.rect.top && rect.right > block.rect.left + 2 && rect.left < block.rect.right - 2 && rect.top < block.rect.top - TILESIZE / 8) {
        velY = 0;
        if (rect.bottom > block.rect.top) {
          rect.top = block.rect.top - rect.ySize;
        }
        return true;
      }
    }
    return false;
  }
  
  public void gravity() {
    if (!blockTopCollision()) { // check if the player is above the ground
      velY += grav;
    }
  }
  
  public void disp() {
    animate();
  }
  
  public void update() {
    gravity();
    rect.left -= 2;
    rect.top += velY;
    rect.update();
  }
}
