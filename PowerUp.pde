public class PowerUp {
  PRect rect;
  char pType;
  PImage img;
  boolean show = true;
  
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
        break;
      }
  }
  public void disp() {
    //println(player.rect.centerx);
    //println(rect.centery +"     " +rect.centerx);
    if (show == true) {
      image(img, rect.left-TILESIZE/2 - cameraOffset, rect.top-TILESIZE/2);
      //collision
      if ((rect.bottom+TILESIZE/2 > player.rect.centery && rect.top-TILESIZE/2 < player.rect.centery) && (rect.centerx-TILESIZE/2 < player.rect.centerx && rect.centerx+TILESIZE/2 > player.rect.centerx)) {
        show = false;
        if (pType == 'M') {
          player.metal = true;
        }
        
      }
    }
    
  }
}
