public int cameraOffset = 0; // moves every block to the left to make scrolling.
public int tempLives; // make resets do what we want
public PImage[] blockImgs = new PImage[5]; // all of the blocks you can walk on or collide with have images in this list. 
public ArrayList<String> map = new ArrayList<String>(); // matrix pulled from map.txt file. Shows where all the blocks are. 
public ArrayList<Block> blockList = new ArrayList<Block>(); // A list of all the tiles in the game. This is to make offset work. also to make storage easier.
public ArrayList<Goomba> goombaList = new ArrayList<Goomba>();
public ArrayList<Koopa> koopaList = new ArrayList<Koopa>();
public ArrayList<PowerUp> powerList = new ArrayList<PowerUp>();
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
public PImage castle;
public PImage coinIMG;
Flag flagpole;
public PImage[][] pImgs = new PImage[3][4]; //player sprites. All of them. 
public PImage[][] tBImgs = new PImage[3][4]; // tall sprites
public PImage[][] mImgs = new PImage[3][4]; // metal sprites
public PImage[] gImgs = new PImage[5];
public PImage[][] kImgs = new PImage[2][5];
public PImage[] powIMG = new PImage[2];
public boolean start = false; //Whether or not to show start image
PFont font; // text font
public int score = 0;

void createMap() {
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < 202; x++) { // places tiles
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

void loadImages() { //self explanatory. 
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
  goombaIMG = loadImage("goomba.png");
  koopaIMG = loadImage("koopa.png");
  shell = loadImage("koopaShell.png");
  castle = loadImage("castle.png");
  powIMG[0] = loadImage("MShroom.png");
  powIMG[1] = loadImage("metalMushroom.png");
  win = loadImage("winScreen.png");
  lose = loadImage("gameOverSprite.png");
  for (PImage item : powIMG) {
      item.resize(40,40);
    }
}

void resetLists() {
  for (Goomba goomba : goombaList) {
    goomba = null;
  }
  for (int i = 0; i < goombaList.size(); i++) {
    goombaList.remove(goombaList.get(i));
  }
  
  for (Koopa koopa : koopaList) {
    koopa = null;
  }
  for (int i = 0; i < koopaList.size(); i++) {
    koopaList.remove(koopaList.get(i));
  }
  
  for (Block block : blockList) {
    block = null;
  }
  for (int i = 0; i < blockList.size(); i++) {
    blockList.remove(blockList.get(i));
  }
}

void loadMap() {//moves the map file to a place where we could code it. 
  for (int i = 0; i < 15; i++) {
    try {
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
void keyPressed() { 
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

void reset() {
  start = false;
  resetLists();
  createMap();
  tempLives = player.lives;
  player = new Player();
  player.lives = tempLives;
  cameraOffset = 0;
}

void keyReleased() {
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

public void UI() {
  fill(0);
  text(score, 200, 10);
  text(player.lives, 250, 10);
  fill(255);
}

void draw() {
  if (start == false) { //draws the title screen. 
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
    textSize(20);
    text("Use arrow keys to move",width/2,150);
    fill(111);
    rect(175,175,450,110);
    fill(198,6,6);
    textSize(18);
    text("Enemies",width/3.5, 190);
    image(goombaIMG, 200,210);
    image(koopaIMG, 230,230);
    shell.resize(20, 20);
    image(shell, 200,250);
    fill(38,142,31);
    text("Bob with PowerUps",380,190);
    if (keyCode == ENTER) {
      start = true;
      player.reset = false;
    }
  } else { //Draws the player, draws the map, drawsenemies. 
    background(0, 140, 255);
    //bg.resize(800, 600);
    image(bg, 0 - cameraOffset / 4, 0);
    fill(255);
    player.update();
    for (Goomba goomba : goombaList) {
      goomba.update();
    }
    for (Koopa koopa : koopaList) {
      koopa.update();
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
    if (player.lives <= 0) {
      image(lose, 0, 0);
    } else if (flagpole.won == true){
      image(win, 0, 0);
    }
  }
  if(keyCode == BACKSPACE){
    reset();
  }
}
