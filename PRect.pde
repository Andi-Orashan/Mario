public class PRect {  //does collision! does movement. Only andrew understands it. 
  public float x, y, left, right, bottom, top, centerx, centery, xSize, ySize;
  public float[] topleft = new float[2]; public float[] bottomright = new float[2]; public float[] center = new float[2];
  
  //The hitbox!
  public PRect(float left, float top, float xSize, float ySize) {
    x = left; this.left = left; y = top; this.top = top;
    right = left + xSize; bottom = top + ySize;
    centerx = left + xSize / 2; centery = top + ySize / 2;
    center[0] = centerx; center[1] = centery;
    topleft[0] = left; topleft[1] = top;
    bottomright[0] = right; bottomright[1] = bottom;
    this.xSize = xSize; this.ySize = ySize;
  }
  //The movement!
  public void update() { // make sure to call this function every frame
    right = left + xSize; bottom = top + ySize; x = left; y = top;
    centerx = left + xSize / 2; centery = top + ySize / 2;
    center[0] = centerx; center[1] = centery;
    topleft[0] = left; topleft[1] = top;
    bottomright[0] = right; bottomright[1] = bottom;
  }
}
