public int cameraOffset = 0; // moves every block to the left to make scrolling.
public int tempLives; // make resets do what we want
public PImage[] blockImgs = new PImage[5]; // all of the blocks you can walk on or collide with have images in this list. 
public ArrayList<String> map = new ArrayList<String>(); // matrix pulled from map.txt file. Shows where all the blocks are. 
public ArrayList<Block> blockList = new ArrayList<Block>(); // A list of all the tiles in the game. This is to make offset work. also to make storage easier.
public ArrayList<Goomba> goombaList = new ArrayList<Goomba>(); // goomba list
public ArrayList<Koopa> koopaList = new ArrayList<Koopa>(); // koopa list
public ArrayList<PowerUp> powerList = new ArrayList<PowerUp>(); // powerup list
public ArrayList<Coin> coinList = new ArrayList<Coin>(); // coin list
public int tempCoins; // store coins
String line; // buffer variable to read text file. 
public int TILESIZE = 40; //for scaling purposes
BufferedReader reader; //class that reads map.txt
Player player = new Player(); //creates the player. 
public PImage open; //The title screen picture
public PImage bg; //background image
public PImage lose; //lost image
public PImage win; //win image
public PImage flagpoleIMG; //flagpole picture
public PImage flagIMG; //flag image
public PImage goombaIMG; //goomba picture
public PImage koopaIMG; //koopa picture
public PImage shell; //shell picture
public PImage castle; // castle picture
public PImage coinIMG; // coin picture
public PImage pUI; // player image for UI
public PImage coinUI; // coin image for UI
Flag flagpole; // initialize flag object
public PImage[][] pImgs = new PImage[3][4]; // player sprites 
public PImage[][] tBImgs = new PImage[3][4]; // tall sprites
public PImage[][] mImgs = new PImage[3][4]; // metal sprites
public PImage[] gImgs = new PImage[5]; // goomba images
public PImage[][] kImgs = new PImage[2][5]; // koopa images
public PImage[] powIMG = new PImage[3]; // powerup images
public PImage[] frontPowIMG = new PImage[3]; // beginning screen powerup images
public boolean start = false; //Whether or not to show start image
PFont font; // text font
public int score = 0;

void createMap() { // instantiate objects from map.txt file
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < 246; x++) { // places tiles
      if (map.get(y).charAt(x) != ' ' && map.get(y).charAt(x) != 'F' && map.get(y).charAt(x) != 'g' && map.get(y).charAt(x) != 'k') {
        blockList.add(new Block(x*40, y*40, map.get(y).charAt(x)));
      }
      if (map.get(y).charAt(x) == 'F') {
        flagpole = (new Flag(x*40, y*40));
        flagpole.img.resize(40, 400);
        flagIMG.resize(40,40);
      }
      if (map.get(y).charAt(x) == 'g') {
        goombaList.add(new Goomba(x*40, y*40));
      }
      if (map.get(y).charAt(x) == 'k') {
        koopaList.add(new Koopa(x*40, y*40));
      }
    }
  }
}

void setup() {
  //creates the text
  font = loadFont("LucidaSans-Typewriter-25.vlw");
  textAlign(CENTER, CENTER);
  size(800,600);
  //loads maps and pictures. 
  reader = createReader("map.txt");
  loadImages();
  loadMap();
  createMap();
}

void loadImages() { // self-explanatory
  open = loadImage("image.png");
  bg = loadImage("background.png");
  blockImgs[0] = loadImage("crackedTile.png");
  blockImgs[1] = loadImage("bigTile.png");
  blockImgs[2] = loadImage("brickTile.png");
  blockImgs[3] = loadImage("emptyMysteryTile.png");
  blockImgs[4] = loadImage("mysteryTile.png");
  pImgs[0][0] = loadImage("shortBob-anime.png");
  pImgs[0][1] = loadImage("shortBob-anime1.png");
  pImgs[0][2] = loadImage("shortBob-anime2.png");
  pImgs[0][3] = loadImage("shortBob-anime3.png");
  pImgs[1][0] = loadImage("shortBob-flipped-anime1.png");
  pImgs[1][1] = loadImage("shortBob-flipped-anime2.png");
  pImgs[1][2] = loadImage("shortBob-flipped-anime3.png");
  pImgs[1][3] = loadImage("shortBob-flipped-anime4.png");
  pImgs[2][0] = loadImage("Rjump.png");
  pImgs[2][1] = loadImage("Ljump.png");
  pImgs[2][2] = loadImage("bobDie.png");
  tBImgs[0][0] = loadImage("tallBob-anime-1.png");
  tBImgs[0][1] = loadImage("tallBob-anime-2.png");
  tBImgs[0][2] = loadImage("tallBob-anime-3.png");
  tBImgs[0][3] = loadImage("tallBob-anime-4.png");
  tBImgs[1][0] = loadImage("tallBob-flip-anime-1.png");
  tBImgs[1][1] = loadImage("tallBob-flip-anime-2.png");
  tBImgs[1][2] = loadImage("tallBob-flip-anime-3.png");
  tBImgs[1][3] = loadImage("tallBob-flip-anime-4.png");
  tBImgs[2][0] = loadImage("tallBob-rJump.png");
  tBImgs[2][1] = loadImage("tallBob-lJump.png");
  mImgs[1][0] = loadImage("metal-flip-anime-1.png");
  mImgs[1][1] = loadImage("metal-flip-anime-2.png");
  mImgs[1][2] = loadImage("metal-flip-anime-3.png");
  mImgs[1][3] = loadImage("metal-flip-anime-4.png");
  mImgs[0][0] = loadImage("metal-anime-1.png");
  mImgs[0][1] = loadImage("metal-anime-2.png");
  mImgs[0][2] = loadImage("metal-anime-3.png");
  mImgs[0][3] = loadImage("metal-anime-4.png");
  mImgs[2][0] = loadImage("metal-rJump.png");
  mImgs[2][1] = loadImage("metal-lJump.png");
  gImgs[0] = loadImage("goomba-anime1.png");
  gImgs[1] = loadImage("goomba-anime2.png");
  gImgs[2] = loadImage("goomba-anime3.png");
  gImgs[3] = loadImage("goomba-anime4.png");
  gImgs[4] = loadImage("goomba-SS.png");
  kImgs[1][0] = loadImage("koopa anime 1.png");
  kImgs[1][1] = loadImage("koopa anime 2.png");
  kImgs[1][2] = loadImage("koopa anime 3.png");
  kImgs[1][3] = loadImage("koopa anime 4.png");
  kImgs[1][4] = loadImage("koopa anime 5.png");
  kImgs[0][0] = loadImage("koopa-flip-anime-1.png");
  kImgs[0][1] = loadImage("koopa-flip-anime-2.png");
  kImgs[0][2] = loadImage("koopa-flip-anime-3.png");
  kImgs[0][3] = loadImage("koopa-flip-anime-4.png");
  kImgs[0][4] = loadImage("koopa-flip-anime-5.png");
  flagpoleIMG = loadImage("flagpole.png");
  flagIMG = loadImage("flag.png");
  coinIMG = loadImage("coin.png");
  pUI = loadImage("shortBob-anime1.png");
  coinUI = loadImage("coin.png");
  goombaIMG = loadImage("goomba.png");
  koopaIMG = loadImage("koopa.png");
  shell = loadImage("koopaShell.png");
  castle = loadImage("castle.png");
  powIMG[0] = loadImage("MShroom.png");
  powIMG[1] = loadImage("metalMushroom.png");
  powIMG[2] = loadImage("1UP.png");
  frontPowIMG[0] = loadImage("MShroom.png");
  frontPowIMG[1] = loadImage("metalMushroom.png");
  frontPowIMG[2] = loadImage("1UP.png");
  win = loadImage("winScreen.png");
  lose = loadImage("gameOverSprite.png");
  coinIMG = loadImage("coin.png");
}

void resetLists() { // also self-explanatory
  goombaList.clear();
  koopaList.clear();
  blockList.clear();
  powerList.clear();
}

void loadMap() { // takes the text from the file and stores it in a matrix
  for (int i = 0; i < 15; i++) {
    try { // code taken from Processing documentation
      line = reader.readLine();
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line == null) {
      exit();
    } else {
      map.add(line);
    }
  }
}

//INPUTS!
void keyPressed() { // check if arrow keys are pressed
  if (keyCode == UP && !player.forceStop && !player.jump) {
    player.jump = true;
    player.firstFrame = true;
    player.jumpPress = millis();
  }
  if (keyCode == RIGHT) {
    player.goRight = true;
  } else if (keyCode == LEFT) {
    player.goLeft = true;
  }
}

public void reset() { // reset all variables; essentially a restart without hitting the run button
  start = false;
  resetLists();
  createMap();
  tempLives = player.lives;
  player = new Player();
  player.lives = 3;
  score = 0;
  player.coin = 0;
  cameraOffset = 0;
}

public void pReset() { // reset most variables, this is on death
  start = false;
  resetLists();
  createMap();
  tempLives = player.lives;
  tempCoins = player.coin;
  player = new Player();
  player.lives = tempLives;
  player.coin = tempCoins;
  player.reset = true;
  cameraOffset = 0;
}

void keyReleased() { // check if arrow keys have been released
  if (keyCode == UP) {
    player.jump = false;
    player.forceStop = false;
  }
  if (keyCode == RIGHT) {
    player.goRight = false;
  } else if (keyCode == LEFT) {
    player.goLeft = false;
  }
}

public void UI() { // text and images for user interface
  fill(0);
  text(score, 190, 15);
  pUI.resize(20, 20);
  image(pUI, 222, 7);
  text(player.lives, 250, 15);
  coinUI.resize(20, 20);
  image(coinUI, 272, 5);
  text(player.coin, 300, 15);
  fill(255);
}

void draw() {
  if (start == false) { // draws the title screen; text and images
    textFont(font, 40);
    image(open, 0, 0);
    fill(7,113,20);
    rect(280, 325,230,50);
    fill(0,0,0);
    textSize(18);
    text("Press Enter to Play", 395, 350);
    textSize(35);
    fill(255);
    text("Bob The Electrician", width/2,120);
    fill(255);
    rect(100,300,600,200);
    textSize(20);
    fill(255);
    text("Use arrow keys to move",width/2,150);
    fill(111);
    rect(175,175,450,110);
    fill(0);
    textSize(18);
    text("Enemies",width/3.5 - 5, 190);
    image(goombaIMG, 200,210);
    image(koopaIMG, 230,230);
    shell.resize(20, 20);
    image(shell, 200,250);
    text("Bob with PowerUps",380,190);
    line(270,175,270,285);
    frontPowIMG[1].resize(20,20);
    image(frontPowIMG[1], 289,210);
    mImgs[0][2].resize(20,40);
    image(mImgs[0][2],320, 205);
    textSize(16);
    text("Metal Mushroom and Metal Bob",489,220);
    frontPowIMG[0].resize(20,20);
    image(frontPowIMG[0], 289, 250);
    tBImgs[0][0].resize(20,40);
    image(tBImgs[0][0],320,245);
    textSize(16);
    text("Mushroom and Tall Bob", 455, 260);
    if (keyCode == ENTER || player.reset) {
      start = true;
      player.reset = false;
      cameraOffset = 0; 
    }
  } else { // Draws the player, draws the map, draws enemies
    background(0, 140, 255);
    image(bg, 0 - cameraOffset / 4, 0); // drwa background image
    fill(255);
    // update all sprites
    player.update();
    for (Coin coin : coinList) {
      coin.update();
    }
    for (Goomba goomba : goombaList) {
      goomba.update();
    }
    for (Koopa koopa : koopaList) {
      koopa.update();
    }
    // draw all sprites
    for (Coin coin : coinList) {
      coin.disp();
    }
    for (Block block : blockList) {
      block.img.resize(TILESIZE, TILESIZE);
      block.disp();
    }
    for (Goomba goomba : goombaList) {
      goomba.disp();
    }
    for (Koopa koopa : koopaList) {
      koopa.disp();
    }
    for (PowerUp power : powerList) {
      power.disp();
    }
    flagpole.disp();
    player.disp();
    UI();
    
    if (player.rect.y > height + 200) { // if the player falls below the map, kill them
      player.dead = true;
    }
    if (player.lives <= 0) { // show losing end screen
      image(lose, 0, 0);
    } else if (flagpole.won == true) { // show winning end screen
      image(win, 0, 0);
    }
  }
  if (keyCode == BACKSPACE) { // if backspace was pressed, restart
    reset();
  }
}
