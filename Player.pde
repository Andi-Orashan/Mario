public class Player {
  public PRect rect;
  public PVector acc, vel; 
  public float fric, grav;
  public int jumpPress;
  public boolean jump = false, forceStop = false, firstFrame = false, fall = true, goRight = false, goLeft = false;
  public int dir = 0, frame = 0, framePause = millis();
  public boolean big = false;
  
  public Player() {
    rect = new PRect(50, width/2, 16, 26);
    acc = new PVector(0, 0); vel = new PVector(0, 0);
    grav = 17.4/60; jumpPress = millis(); fric = 0.2;
  }
  
  public void disp() {
    // rect(rect.left - cameraOffset, rect.top, rect.xSize, rect.ySize);
    if (vel.x > 0.1 && (!jump && !fall)) {
      pImgs[0][frame].resize(24, 32);
      dir = 0;
      image(pImgs[0][frame], rect.left - 4 - cameraOffset, rect.top);
      if (framePause + 50 <= millis()) {
        frame += 1;
        frame %= 4;
        framePause = millis();
      }
    } else if (vel.x < -0.1 && (!jump && !fall)) {
      pImgs[1][frame].resize(24, 32);
      image(pImgs[1][frame], rect.left - 4 - cameraOffset, rect.top);
      dir = 1;
      if (framePause + 50 <= millis()) {
        frame += 1;
        frame %= 4;
        framePause = millis();
      }
    } else if (!jump && !fall) {
      if (dir == 0) {
        image(pImgs[0][1], rect.left - 4 - cameraOffset, rect.top);
      } else if (dir == 1) {
        image(pImgs[1][1], rect.left - 4 - cameraOffset, rect.top);
      }
    }
    if (jump || fall) {
      if (vel.x >= 0) {
        image(pImgs[2][1], rect.left - 4 - cameraOffset, rect.top);
      } else {
        image(pImgs[2][0], rect.left - 4 - cameraOffset, rect.top);
      }
    }
  }
  
  public void jump() {
    if (!blockTopCollision()) {
      if (jumpPress + 300 <= millis())  {// max jump length is .3 seconds
          jump = false;
          forceStop = true; // make sure player cannot continue holding to jump
        }
        if (!blockBottomCollision()) {
          vel.y -= 0.3;
        }
        if (firstFrame) { // if first frame in jump:
          firstFrame = false;
          vel.y -= 6; // change velocity by much more to simulate true jumps
        }
    }
  }
  
  public boolean blockTopCollision() {
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
  
  public boolean blockRightCollision() {
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right + vel.x > block.rect.left - 0.1 && rect.left < block.rect.centerx && rect.top < block.rect.bottom - 1) {
        vel.x = 0;
        return true;
      }
    }
    return false;
  }
  
  public boolean blockLeftCollision() {
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right > block.rect.centerx && rect.left + vel.x < block.rect.right + 0.1 && rect.top < block.rect.bottom - 1) {
        vel.x = 0;
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
  
  public void move() {
    if (goRight && !blockRightCollision()) {
      acc.x = 0.3;
    } else if (goLeft && !blockLeftCollision()) {
      acc.x = -0.3;
    } else {
      acc.x = 0;
      if (vel.x > fric - .1) {
        vel.x -= fric;
      } else if (vel.x < -fric + .1) {
        vel.x += fric;
      }
    }
    vel.x += acc.x;
    vel.x = max(min(vel.x, 6), -6); // keeps velocity between 6 and -6
  }
  
  public void gravity() {
    if (!blockTopCollision()) { // check if the player is above the ground
      vel.y += grav; // continually add increase velocity
      if (!jump) { // if not jumping, fall
        fall = true;
      }
    }
  }
  
  public void update() {
    if (jump && !fall) {
      jump();
    }
    
    if (rect.right - cameraOffset >= width - TILESIZE * 1.5) {
      cameraOffset += (rect.right - cameraOffset) - (width - TILESIZE * 1.5);
    }
    
    move();
    blockBottomCollision();
    blockTopCollision();
    gravity(); // always update gravity
    
    if (rect.left - cameraOffset + vel.x > 0) {
      rect.left += vel.x;
    }
    if (!blockTopCollision()) {
      rect.top += vel.y;
    }
    
    rect.update();
  }
}
