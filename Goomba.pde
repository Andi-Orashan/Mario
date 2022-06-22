public class Goomba {
  PRect rect;
  public float velX, velY, accY, grav;
  public int frame, framePause;
  public boolean dead;
  
  public Goomba(float x, float y) {
    rect = new PRect(x, y, 32, 30);
    dead = false;
    grav = 17.4/60;
    velX = -2;
    frame = 0; framePause = millis();
  }
  
  public void squash() {
    if (player.rect.bottom > rect.top && player.rect.bottom < rect.top + 2 && player.rect.right > rect.left && player.rect.left < rect.right && !dead) {
      dead = true;
      player.vel.y = min(-4, player.vel.y * 1.5);
    }
  }
  
  public boolean blockRightCollision() {// have you hit the 
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right + velX > block.rect.left - 0.1 && rect.left < block.rect.centerx && rect.top < block.rect.bottom - 1) {
        velX = 2;
        return true;
      }
    }
    return false;
  }
  
  public boolean blockLeftCollision() {
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right > block.rect.centerx && rect.left + velX < block.rect.right + 0.1 && rect.top < block.rect.bottom - 1) {
        velX = -2;
        return true;
      }
    }
    return false;
  }
  
  
  public void animate() {
    if (!dead) {
      if (framePause + 200 <= millis()) {
        frame += 1;
        frame %= 4;
        framePause = millis();
      }
      gImgs[frame].resize(32, 32);
      image(gImgs[frame], rect.x - cameraOffset, rect.y);
    } else {
      gImgs[4].resize(32, 32);
      image(gImgs[4], rect.x - cameraOffset, rect.y);
      rect.ySize = 16;
    }
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
    squash();
    blockLeftCollision();
    blockRightCollision();
    if (!dead) {
      rect.left -= velX;
    }
    rect.top += velY;
    rect.update();
  }
}
