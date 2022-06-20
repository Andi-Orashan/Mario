public class Player {
  public PRect rect;
  public PVector acc, vel; 
  public float fric, grav;
  public int jumpPress;
  public boolean jump = false, forceStop = false, firstFrame = false, fall = true;;
  
  public Player() {
    rect = new PRect(50, width/2, 20, 20);
    acc = new PVector(0, 0); vel = new PVector(0, 0);
    grav = 14.4/60; jumpPress = millis();
  }
  
  public void disp() {
    rect(rect.left, rect.top, rect.xSize, rect.ySize);
  }
  
  public void jump() {
    if (jumpPress + 300 <= millis())  {// max jump length is .3 seconds
        jump = false;
        forceStop = true; // make sure player cannot continue holding to jump
      }
      vel.y -= 0.3;
      if (firstFrame) { // if first frame in jump:
        firstFrame = false;
        vel.y -= 6; // change velocity by much more to simulate true jumps
      }
  }
  
  public void gravity() {
    if (rect.bottom + vel.y < height) { // check if the player is above the ground
      vel.y += grav; // continually add increase velocity
      if (!jump) { // if not jumping, fall
        fall = true;
      }
    } else {
      vel.y = 0; // if on the ground, don't fall
      fall = false;
    }
    if (rect.bottom > height) {
      rect.top = height - rect.ySize;
    }
  }
  
  public void update() {
    if (jump && !fall) {
      jump();
    }
    gravity(); // always update gravity
    rect.left += vel.x;
    rect.top += vel.y;
    rect.update();
  }
}
