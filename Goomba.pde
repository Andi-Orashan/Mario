public class Goomba {
  // declare necessary variables
  PRect rect;
  public float velX, velY, accY, grav;
  public int frame, framePause;
  public boolean dead;
  
  public Goomba(float x, float y) {
    rect = new PRect(x, y, 32, 30); // define hitbox
    dead = false;
    grav = 17.4/60; // define a gravity constant
    velX = 2;
    if (floor(random(2)) == 0) { // make movement direction random
      velX *= -1;
    }
    frame = 0; framePause = millis(); // animation variables
  }
  
  public void squash() { // check if player stomped on this object
    if (player.rect.bottom > rect.top && player.rect.bottom < rect.top + 6 && player.rect.right > rect.left && player.rect.left < rect.right && !dead && !player.dead) {
      dead = true; // make sure all functions which run when the goomba is alive will no longer run
      coinList.add(new Coin(rect.x, rect.y)); // spawn a coin
      player.vel.y = min(-4, player.vel.y * 1.5); // make the player hop a little bit
      score+=100; // add 100 score to the game
    }
  }
  
  public boolean blockRightCollision() {// check if the right side collided with a block
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right + velX > block.rect.left - 0.1 && rect.left < block.rect.centerx && rect.top < block.rect.bottom - 1 && block.draw) {
        velX = 2; // swap direction
        return true;
      }
    }
    return false;
  }

  public boolean blockLeftCollision() {// check if the left side collided with a block
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right > block.rect.centerx && rect.left + velX < block.rect.right + 0.1 && rect.top < block.rect.bottom - 1 && block.draw) {
        velX = -2; // swap direction
        return true;
      }   
    }
    return false;
  }
  public boolean playerLeftCollision() { // check if the left side collided with the player
      if ((rect.bottom > player.rect.top + 30 && rect.right > player.rect.centerx && rect.left + velX < player.rect.right + 0.1 && rect.top < player.rect.bottom - 1 && dead == false)) {
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
  public boolean playerRightCollision() { // do the same as left function except for the right side
      if (rect.bottom > player.rect.top + 30 && rect.right > player.rect.centerx && rect.right + velX < player.rect.left + 0.1 && rect.top < player.rect.bottom - 1 && dead == false) {
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
  
  public void shellLeftCollision() { // check if the left side collided with a moving shell
    for (Koopa koopa: koopaList) {
      if ((rect.bottom > koopa.rect.top + 1 && rect.right > koopa.rect.centerx && rect.left + velX < koopa.rect.right + 0.1 && rect.top < koopa.rect.bottom - 1 && dead == false)) {
        if (koopa.dead == true && koopa.velX != 0) { // check if the koopa is a shell and moving
          dead = true; // die
          coinList.add(new Coin(rect.x, rect.y)); // spawn a coin
          score+=150; // add score
        }
      }
    }
  }
  public void shellRightCollision() { // do the same as left function except for the right side
    for (Koopa koopa: koopaList) {
      if (rect.bottom > koopa.rect.top + 1 && rect.right > koopa.rect.centerx && rect.right + velX < koopa.rect.left + 0.1 && rect.top < koopa.rect.bottom - 1 && dead == false) {
        if (koopa.dead == true && koopa.velX != 0) {
          dead = true;
          coinList.add(new Coin(rect.x, rect.y));
          score+=150;
        }
      }
    }
  }
  public void animate() { // loop through 4 animation sprites
    if (!dead) { // don't animate if dead
      if (framePause + 200 <= millis()) { // run every 200 ms
        frame += 1; // add 1 to frame
        frame %= 4; // keep frame between 0 and 3
        framePause = millis(); // reset animation cooldown
      }
      gImgs[frame].resize(32, 32); // resize image to correct size
      image(gImgs[frame], rect.x - cameraOffset, rect.y); // display the image
    } else {
      gImgs[4].resize(32, 32); // resize image to correct size
      image(gImgs[4], rect.x - cameraOffset, rect.y); // display death image
      rect.ySize = 16; // resize hitbox
    }
  }
  
  public boolean blockTopCollision() { // have you collided with the top of the block?
    for (Block block : blockList) {
      if (rect.bottom + velY > block.rect.top && rect.right > block.rect.left + 2 && rect.left < block.rect.right - 2 && rect.top < block.rect.top - TILESIZE / 8 && block.draw) {
        velY = 0; // set y velocity to 0
        if (rect.bottom > block.rect.top) {
          rect.top = block.rect.top - rect.ySize; // move object to top of collided block
        }
        return true;
      }
    }
    return false;
  }
  
  public void gravity() {
    if (!blockTopCollision()) { // check if the player is above the ground
      velY += grav; // add to velocity to move sprite down
    }
  }
  
  public void disp() {
    animate(); // animate
  }
  
  public void update() {
    gravity(); // update gravity
    squash(); // check if the player jumped on the object
    blockLeftCollision(); // check collisions
    blockRightCollision();
    playerLeftCollision();
    playerRightCollision();
    shellLeftCollision();
    shellRightCollision();
    if (!dead) {
      rect.left -= velX; // move horizontally
    }
    rect.top += velY; // move vertically
    rect.update(); // update the hitbox
  }
}
