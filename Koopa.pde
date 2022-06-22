public class Koopa {
  public PRect rect;
  public PVector acc, vel; 
  public float fric, grav; //things moving against the players movement. 
  public int jumpPress;
  public boolean jump = false, forceStop = false, firstFrame = false, fall = true, goRight = false, goLeft = false;
  public int dir = 0, frame = 0, framePause = millis();
  public boolean big = false;
  
  public Koopa(float x, float y){
    
  }
  public boolean blockTopCollision() { // have you collided with the top of the block?
    for (Block block : blockList) {
      if (rect.bottom + vel.y > block.rect.top && rect.right > block.rect.left + 2 && rect.left < block.rect.right - 2 && rect.top < block.rect.top - TILESIZE / 8) {
        fall = false;
        vel.y = 0;
        if (rect.bottom > block.rect.top) {
          rect.top = block.rect.top - rect.ySize;
        }
        return true;
      }
    }
    return false;
  }
  
  public boolean blockRightCollision() {// have you hit the 
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right + vel.x > block.rect.left - 0.1 && rect.left < block.rect.centerx && rect.top < block.rect.bottom - 1) {
        vel.x *= -1;
        return true;
      }
    }
    return false;
  }
  
  public boolean blockLeftCollision() {
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right > block.rect.centerx && rect.left + vel.x < block.rect.right + 0.1 && rect.top < block.rect.bottom - 1) {
        vel.x *= -1;
        return true;
      }
    }
    return false;
  }
  
  public boolean blockBottomCollision() {
    for (Block block : blockList) {
      if (rect.bottom > block.rect.centery && rect.right > block.rect.left + 1 && rect.left < block.rect.right - 1 && rect.top + vel.y < block.rect.bottom) {
        vel.y = 1;
        //rect.top = block.rect.bottom;
        return true;
      }
    }
    return false;
  }
  
  
  
  
  public void update() { // if the player is jumping and not falling, they can run the jump sequence. 
    
    
    
    //wraps everything into one function. 
    blockBottomCollision();
    blockTopCollision();
    
    //does more movement. 
    if (rect.left - cameraOffset + vel.x > 0) {
      rect.left += vel.x;
    }
    if (!blockTopCollision()) {
      rect.top += vel.y;
    }
    //one last function!
    rect.update();
  }
}
