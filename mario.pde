public int cameraOffset = 0;
public PImage[] blockImgs = new PImage[5];
public ArrayList<String> map = new ArrayList<String>();
public ArrayList<Block> blockList = new ArrayList<Block>();
String line;
public int TILESIZE = 40;
BufferedReader reader;
Player player = new Player();
public PImage open;
public PImage bg;
public PImage flagpoleIMG;
public PImage flagIMG;
public PImage goomba;
public PImage koopa;
public PImage shell;
public PImage[][] pImgs = new PImage[3][4];
public boolean start = false;
PFont font;

public Flag flagpole = new Flag(80, 80);

void setup() {
  font = loadFont("LucidaSans-Typewriter-25.vlw");
  textAlign(CENTER, CENTER);
  size(800,600);
  reader = createReader("map.txt");
  loadImages();
  loadMap();
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < 40; x++) {
      if (map.get(y).charAt(x) != ' ' && map.get(y).charAt(x) != 'F') {
        blockList.add(new Block(x*40, y*40, map.get(y).charAt(x)));
      }
      if (map.get(y).charAt(x) == 'F') {
        flagpole = (new Flag(x*40, y*40));
        flagpole.img.resize(40, 400);
        flagIMG.resize(40,40);
      }
    }
  }
}

void loadImages() {
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
  flagpoleIMG = loadImage("flagpole.png");
  flagIMG = loadImage("flag.png");
  goomba = loadImage("Final Gomba.png");
  koopa = loadImage("koopa.png");
  shell = loadImage("koopaShell.png");
}

void loadMap() {
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

void draw() {
  if (!start) {
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
    fill(0);
    textSize(18);
    text("Enemies",width/3.5, 190);
    image(goomba, 200,210);
    image(koopa, 250,230);
    image(shell,200, 250);
    if (keyCode == ENTER) {
      start = true;
    }
  } else {
    background(0, 140, 255);
    //bg.resize(800, 600);
    image(bg, 0 - cameraOffset / 3, 0);
    fill(255);
    player.update();
    for (Block block : blockList) {
      block.img.resize(TILESIZE, TILESIZE);
      block.disp();
    }
    flagpole.disp();
    player.disp();
  }
}
