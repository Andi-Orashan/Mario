public class Koopa {
  // declare necessary variables
  PRect rect;
  public float velX, velY, accY, grav;
  public int frame, framePause, waitCooldown = millis();
  public boolean dead, wait = false;
  
  public Koopa(float x, float y) {
    rect = new PRect(x, y, 32, 30); // define hitbox
    dead = false;
    grav = 17.4/60; // define a gravity constant
    velX = 2;
    if (floor(random(2)) == 0) { // make movement direction random
      velX *= -1;
    }
    frame = 0; framePause = millis(); // animation variables
  }
  
  public void squash() {// check if player stomped on this object
    if (player.rect.bottom > rect.top && player.rect.bottom < rect.top + 6 && player.rect.right > rect.left - 3 && player.rect.left < rect.right + 3 && !dead && !player.dead) {
      dead = true; // make sure all functions which run when the goomba is alive will no longer run
      coinList.add(new Coin(rect.x, rect.y)); // spawn a coin
      player.vel.y = min(-4, player.vel.y * 1.5); // make the player hop a little bit
      velX = 0; // stop moving horizontally
      wait = true; // make sure the shell can't start moving immediately
      waitCooldown = millis();
      score+=150;  // add 150 score to the game
    }
    if (player.rect.bottom > rect.top && player.rect.bottom < rect.top + 20 && player.rect.right > rect.left && player.rect.left < rect.right && dead && !wait) {
      // ^ check if the playaer stomped on this object AND if it is a shell
      player.vel.y = min(-4, player.vel.y * 1.5); // make the player hop
      if (player.rect.centerx > rect.centery) {
        velX = -5; // if the player is to the right of the shell, move left
      } else {
        velX = 5; // if the player is to the left of the shell, move right
      }
    }
  } 
  public void shellLeftCollision() { // check if the left side collided with the player
    for (Koopa koopa: koopaList) {
      if ((rect.bottom > koopa.rect.top + 1 && rect.right > koopa.rect.centerx && rect.left + velX < koopa.rect.right + 0.1 && rect.top < koopa.rect.bottom - 1 && dead == false)) {
        if (koopa.dead == true && koopa.velX != 0) {  // check if the koopa is a shell and moving
          dead = true;
          velX = 0; // stop moving
          coinList.add(new Coin(rect.x, rect.y)); // spawn a coin
          wait = true; // let the player cause movement
          waitCooldown = millis(); // let the player cause movement
          score+= 200; // add 200 to score
        }
      }
    }
  }
  public void shellRightCollision() { // do the same thing as left function, except for the right
    for (Koopa koopa: koopaList) {
      if (rect.bottom > koopa.rect.top + 1 && rect.right > koopa.rect.centerx && rect.right + velX < koopa.rect.left + 0.1 && rect.top < koopa.rect.bottom - 1 && dead == false) {
        if (koopa.dead == true && koopa.velX != 0) {
          dead = true;
          velX = 0;
          coinList.add(new Coin(rect.x, rect.y));
          wait = true;
          waitCooldown = millis();
          score+= 200;
        }
      }
    }
  }
  public boolean blockRightCollision() {// have you hit a block on your right side
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right + velX > block.rect.left - 0.1 && rect.left < block.rect.centerx && rect.top < block.rect.bottom - 1) {
        if (!dead) {
          velX = 2;
        } else {
          velX = 5;
        } // swap direction
        return true;
      }
    }
    return false;
  }
  
  public boolean blockLeftCollision() { // have you hit a block on your left side
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right > block.rect.centerx && rect.left + velX < block.rect.right + 0.1 && rect.top < block.rect.bottom - 1) {
        if (!dead) {
          velX = -2;
        } else {
          velX = -5;
        } // swap direction
        return true;
      }
    }
    return false;
  }
  
  public boolean playerLeftCollision() { // check if the left side collided with the player
      if (rect.bottom > player.rect.top + 30 && rect.right > player.rect.centerx && rect.left + velX < player.rect.right + 0.1 && rect.top + 25 < player.rect.bottom - 1) {
        if (player.metal == true) {
          coinList.add(new Coin(rect.x, rect.y)); // spawn a coin
          dead = true; // if player has metal powerup, die
        } else {
          player.dead = true; // otherwise, kill the player
          player.inv = true; // initialize invincible frames
        }
        
    }
    return false;
  }
  public boolean playerRightCollision() { // do the same thing, except for the right side
      if (rect.bottom > player.rect.top + 30 && rect.right > player.rect.centerx && rect.right + velX < player.rect.left + 0.1 && rect.top + 25 < player.rect.bottom - 1) {
        if (player.metal == true) {
          coinList.add(new Coin(rect.x, rect.y)); // spawn a coin
          dead = true;
        } else {
          player.dead = true;
          player.inv = true;
        }
    }
    return false;
  }
  
  public boolean blockTopCollision() { // have you collided with the top of the block?
    for (Block block : blockList) {
      if (rect.bottom + velY > block.rect.top && rect.right > block.rect.left + 2 && rect.left < block.rect.right - 2 && rect.top < block.rect.top - TILESIZE / 8) {
        velY = 0;
        if (rect.bottom > block.rect.top) {
          rect.top = block.rect.top - rect.ySize; // move koopa to top of block
        }
        return true;
      }
    }
    return false;
  }
  
  public void animate() { // animate 5 images based on movement direction and alive-ness
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
  
  public void gravity() {
    if (!blockTopCollision()) { // check if the player is above the ground
      velY += grav; // update player velocity
    }
  }
  
  public void disp() {
    animate();
  }
  
  public void update() {
    gravity();
    squash();
    if (wait && waitCooldown + 300 <= millis()) {
      wait = false;
    }
    blockLeftCollision(); // checck collisions
    blockRightCollision();
    playerLeftCollision();
    playerRightCollision();
    shellLeftCollision();
    shellRightCollision();
    rect.left -= velX; // update hitbox
    rect.top += velY;
    rect.update();
  }
}
