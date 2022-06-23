public class Koopa {
  PRect rect;
  public float velX, velY, accY, grav;
  public int frame, framePause;
  public boolean dead;
  
  public Koopa(float x, float y) {
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
      velX = 0;
    }
    if (player.rect.bottom > rect.top && player.rect.bottom < rect.top + 2 && player.rect.right > rect.left && player.rect.left < rect.right && dead) {
      player.vel.y = min(-4, player.vel.y * 1.5);
      if (player.rect.centerx > rect.centery) {
        velX = -5;
      } else {
        velX = 5;
      }
    }
  }
  
  public boolean blockRightCollision() {// have you hit the 
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right + velX > block.rect.left - 0.1 && rect.left < block.rect.centerx && rect.top < block.rect.bottom - 1) {
        if (!dead) {
          velX = 2;
        } else {
          velX = 5;
        }
        return true;
      }
    }
    return false;
  }
  
  public boolean blockLeftCollision() {
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right > block.rect.centerx && rect.left + velX < block.rect.right + 0.1 && rect.top < block.rect.bottom - 1) {
        if (!dead) {
          velX = -2;
        } else {
          velX = -5;
        }
        return true;
      }
    }
    return false;
  }
  
  public boolean playerLeftCollision() {
      if (rect.bottom > player.rect.top + 1 && rect.right > player.rect.centerx && rect.left + velX < player.rect.right + 0.1 && rect.top < player.rect.bottom - 1) {
        if (player.metal == true) {
          dead = true;
        } else {
          player.dead = true;
        }
        
    }
    return false;
  }
  public boolean playerRightCollision() {
      if (rect.bottom > player.rect.top + 1 && rect.right > player.rect.centerx && rect.right + velX < player.rect.left + 0.1 && rect.top < player.rect.bottom - 1) {
        if (player.metal == true) {
          dead = true;
        } else {
          player.dead = true;
        }
    }
    return false;
  }
  
  public void animate() {
    if (!dead) {
      if (framePause + 200 <= millis()) {
        frame += 1;
        frame %= 5;
        framePause = millis();
      }
      if (velX >= 0) {
        kImgs[1][frame].resize(32, 32);
        image(kImgs[1][frame], rect.x - cameraOffset, rect.y);
      } else {
        kImgs[0][frame].resize(32, 32);
        image(kImgs[0][frame], rect.x - cameraOffset, rect.y);
      }
    } else {
      shell.resize(32, 32);
      image(shell, rect.x - cameraOffset, rect.y);
      rect.ySize = 34;
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
    playerLeftCollision();
    playerRightCollision();
    rect.left -= velX;
    rect.top += velY;
    rect.update();
  }
}
