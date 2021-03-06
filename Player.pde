public class Player {
  
  public PRect rect;
  public PVector acc, vel; 
  public float fric, grav; //things moving against the players movement. 
  public int jumpPress, lives=3;
  public boolean jump = false, forceStop = false, firstFrame = false, fall = true, goRight = false, goLeft = false;
  public int dir = 0, frame = 0, framePause = millis(), iFrames;
  public boolean metal = false;
  public boolean dead = false, dieEnd = false;
  public boolean big = false;
  public boolean inv = false, reset = false, deadJump = false;
  public int coin = 0;
  int timer = 0;
  
  public Player() {
    rect = new PRect(10, width/2, 24, 24);
    acc = new PVector(0, 0); vel = new PVector(0, 0);
    grav = 17.4/60; jumpPress = millis(); fric = 0.2;
  }
  
  public void disp() {
    //println(dead);
    //rect(rect.left - cameraOffset, rect.top, rect.xSize, rect.ySize); //removed code.
    //determines which sprites to use.
    if (timer + 10000 <= millis()) {
      metal = false;
    }
    
    if (coin >= 25) { // 25 coins is one life
      coin -= 25;
      lives++;
    }
    if (dead == true && big == true && inv == false) { // you get hit in big mode, you 
      dead = false;
      big = false;
    }
    
    if (!dead || big) {
      if (!big && !metal) {
        if (!jump && !fall) { // use small sprites
          rect.ySize = 30;
          rect.xSize = 24;
        }
        if (vel.x > 0.1 && (!jump && !fall)) {
          pImgs[0][frame].resize(36, 36); //facing right walk
          dir = 0;
          image(pImgs[0][frame], rect.left - 6 - cameraOffset, rect.top);
          if (framePause + 50 <= millis()) {
            frame += 1;
            frame %= 4;
            framePause = millis();
          }
        } else if (vel.x < -0.1 && (!jump && !fall)) { //facing left walk
          pImgs[1][frame].resize(36, 36);
          image(pImgs[1][frame], rect.left - 6 - cameraOffset, rect.top);
          dir = 1;
          if (framePause + 50 <= millis()) {
            frame += 1;
            frame %= 4;
            framePause = millis();
          }
        } else if (!jump && !fall) {// no movement catch all
          if (dir == 0) {
            pImgs[0][1].resize(36, 36);
            image(pImgs[0][1], rect.left - 6 - cameraOffset, rect.top);
          } else if (dir == 1) {
            pImgs[0][1].resize(36, 36);
            image(pImgs[1][1], rect.left - 6 - cameraOffset, rect.top);
          }
        }
        if (jump || fall) { //Are you jumping or falling to the right
          if (vel.x >= 0) {
            pImgs[2][1].resize(36, 36);
            image(pImgs[2][1], rect.left - 6 - cameraOffset, rect.top);          
          } else { // to the left
            pImgs[2][0].resize(36, 36);
            image(pImgs[2][0], rect.left - 6 - cameraOffset, rect.top);
          }
        }
      }
      
      if (big) { // same as above code but tall
        if (!jump && !fall) {
          rect.ySize = 58;
          rect.xSize = 24;
        }
        if (vel.x > 0.1 && (!jump && !fall)) {
          tBImgs[0][frame].resize(36, 72); //facing right walk
          dir = 0;
          image(tBImgs[0][frame], rect.left - 6 - cameraOffset, rect.top);
          if (framePause + 50 <= millis()) {
            frame += 1;
            frame %= 4;
            framePause = millis();
          }
        } else if (vel.x < -0.1 && (!jump && !fall)) { //facing left walk
          tBImgs[1][frame].resize(36, 72);
          image(tBImgs[1][frame], rect.left - 6 - cameraOffset, rect.top);
          dir = 1;
          if (framePause + 50 <= millis()) {
            frame += 1;
            frame %= 4;
            framePause = millis();
          }
        } else if (!jump && !fall) {// no movement catch all
          if (dir == 0) {
            tBImgs[0][1].resize(36, 72);
            image(tBImgs[0][1], rect.left - 6 - cameraOffset, rect.top);
          } else if (dir == 1) {
            tBImgs[0][1].resize(36, 72);
            image(tBImgs[1][1], rect.left - 6 - cameraOffset, rect.top);
          }
        }
        if (jump || fall) { //Are you jumping or falling to the right
          rect.xSize = 24;
          rect.ySize = 48;
          if (vel.x >= 0) {
            tBImgs[2][0].resize(72, 72);
            image(tBImgs[2][0], rect.left - 24 - cameraOffset, rect.top - 16); 
          } else {
            tBImgs[2][1].resize(72, 72);
            image(tBImgs[2][1], rect.left - 24 - cameraOffset, rect.top - 16);
          }
        }
      }
      
      if (metal) { // same as above code but metal
        if (!jump && !fall) {
          rect.ySize = 58;
          rect.xSize = 24;
        }
        if (vel.x > 0.1 && (!jump && !fall)) {
          mImgs[0][frame].resize(36, 72); //facing right walk
          dir = 0;
          image(mImgs[0][frame], rect.left - 6 - cameraOffset, rect.top);
          if (framePause + 50 <= millis()) {
            frame += 1;
            frame %= 4;
            framePause = millis();
          }
        } else if (vel.x < -0.1 && (!jump && !fall)) { //facing left walk
          mImgs[1][frame].resize(36, 72);
          image(mImgs[1][frame], rect.left - 6 - cameraOffset, rect.top);
          dir = 1;
          if (framePause + 50 <= millis()) {
            frame += 1;
            frame %= 4;
            framePause = millis();
          }
        } else if (!jump && !fall) {// no movement catch all
          if (dir == 0) {
            mImgs[0][1].resize(36, 72);
            image(mImgs[0][1], rect.left - 6 - cameraOffset, rect.top);
          } else if (dir == 1) {
            mImgs[0][1].resize(36, 72);
            image(mImgs[1][1], rect.left - 6 - cameraOffset, rect.top);
          }
        }
        if (jump || fall) { //Are you jumping or falling to the right
          rect.xSize = 24;
          rect.ySize = 48;
          if (vel.x >= 0) {
            mImgs[2][0].resize(72, 72);
            image(mImgs[2][0], rect.left - 24 - cameraOffset, rect.top - 16); 
          } else {
            mImgs[2][1].resize(72, 72);
            image(mImgs[2][1], rect.left - 24 - cameraOffset, rect.top - 16);
          }
        }
      }
    } else {
      pImgs[2][2].resize(36, 36);
      image(pImgs[2][2], rect.left - 6 - cameraOffset, rect.top);
    }
  }
  
  public void jump() {
    if (!blockTopCollision()) {  //all the jump stuff
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
  
  public boolean blockTopCollision() { // have you collided with the top of the block?
    for (Block block : blockList) {
      if (rect.bottom + vel.y > block.rect.top && rect.right > block.rect.left + 2 && rect.left < block.rect.right - 2 && rect.top < block.rect.top - TILESIZE / 8 && block.draw) {
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
  
  public boolean blockRightCollision() {// have you hit the right side of the block
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right + vel.x > block.rect.left - 0.1 && rect.left < block.rect.centerx && rect.top < block.rect.bottom - 1 && block.draw) {
        vel.x = 0;
        return true;
      }
    }
    return false;
  }
  
  public boolean blockLeftCollision() { // left side collision
    for (Block block : blockList) {
      if (rect.bottom > block.rect.top + 1 && rect.right > block.rect.centerx && rect.left + vel.x < block.rect.right + 0.1 && rect.top < block.rect.bottom - 1 && block.draw) {
        vel.x = 0;
        return true;
      }
    }
    return false;
  }
  
  public boolean blockBottomCollision() { // bottom collision
    for (Block block : blockList) {
      if (rect.bottom > block.rect.centery && rect.right > block.rect.left + 1 && rect.left < block.rect.right - 1 && rect.top + vel.y < block.rect.bottom && block.draw) {
        vel.y = 1;
        //rect.top = block.rect.bottom; (debug)
        if (block.full == true) {
          powerList.add(new PowerUp(block.rect.centerx, block.rect.centery-TILESIZE, floor(random(6))));
          block.full = false;
        }
        if (block.type == 'B' && (big || metal)) {
          block.draw = false;
          block.frameDelay = millis() - 100;
        }
        return true;
      }
    }
    return false;
  }
  
  public void move() { //changes the x/y velocities and checks collision. 
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
    if (flagpole.won) {
      lives = 10; // if the player won, keep the player from dying
    }
    if (jump && !fall && !deadJump) { // if the player is jumping and not falling, they can run the jump sequence
      jump();
    }
    
    if (dead && !big) { // if the player died, run death animation
      if (!deadJump) {
        deadJump = true;
        vel.x = 0;
        vel.y = -6;
      }
      vel.y += grav;
      rect.top += vel.y;
      if (rect.bottom > height + 100) {
        dieEnd = true;
      }
    }
    
    if (dieEnd && !big && !flagpole.won) { // after death animation, reset and remove a life
      lives -= 1;
      dead = false;
      dieEnd = false;
      pReset();
    }
    
    if (inv && iFrames + 500 <= millis()) { // reset invincibility cooldown
      inv = false;
    }
    
    if (rect.right - cameraOffset >= width * .75) { //If you are near the edge, scroll cam. 
      cameraOffset += (rect.right - cameraOffset) - (width * .75);
    }
    //wraps everything into one function. 
    if (!deadJump) {
      move();
      blockBottomCollision();
      blockTopCollision();
      gravity(); // always update gravity
    }
   
    
    //does more movement. 
    if (rect.left - cameraOffset + vel.x > 0) {
      rect.left += vel.x;
    }
    if (!deadJump) {
      if (!blockTopCollision()) {
        rect.top += vel.y;
      }
    }
    //one last function!
    rect.update();
  }
}
