public class PowerUp {
  PRect rect;
  char pType;
  PImage img;
  boolean show = true;
  boolean hasSpawned1UP = false;
  
  PowerUp(float x, float y, int type) {
    rect = new PRect(x, y, TILESIZE, TILESIZE);
    switch (type) { 
      case 0: // ground
        pType = 'S'; // super
        img = powIMG[type];
        break;
      case 1: // bricks
        pType = 'M'; //metal
        img = powIMG[type];
        player.timer = millis();
        break;
      case 2: 
      if (hasSpawned1UP == false) {
        pType = 'U'; //1UP
        img = powIMG[type];
      } else {
        pType = 'C'; //COIN SSSSSSSS
        img = coinIMG;
      }
        break;
      case 3: // bricks
        pType = 'C'; //COIN SSSSSSSS
        img = coinIMG;
        break;
      case 4: // bricks
        pType = 'C'; //coin
        img = coinIMG;
        break;
      case 5: // bricks
        pType = 'C'; //coin
        img = coinIMG;
        break;
      }
  }
  public void disp() {
    //println(player.rect.centerx);
    //println(rect.centery +"     " +rect.centerx);
    if (show == true) {
      img.resize(40, 40);
      image(img, rect.left-TILESIZE/2 - cameraOffset, rect.top-TILESIZE/2);
      //collision
      if (player.rect.right > rect.left && player.rect.left < rect.right && player.rect.bottom > rect.top && player.rect.top < rect.bottom) {
        show = false;
        if (pType == 'M') {
          player.metal = true;
          player.big = true;
          score += 50;
        }
        if (pType == 'S' && !player.metal) {
          player.big = true;
          score += 50;
        }
        if (pType == 'U') {
          player.big = true;
          score += 50;
          player.lives++;
        }
        if (pType == 'C') {
          player.coin++;
          score +=100;
        }
      }
    }
    
  }
}
