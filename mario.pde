public PImage[] blockImgs = new PImage[2];
public PImage flagpoleIMG;
public PImage flagIMG;
public ArrayList<String> map = new ArrayList<String>();
public ArrayList<Block> blockList = new ArrayList<Block>();
String line;
public int TILESIZE = 40;
BufferedReader reader;
Player player = new Player();
public Flag flagpole = new Flag(-10000000, -1000000, 'f');


void setup() {
  size(800,600);
  reader = createReader("map.txt");
  loadImages();
  loadMap();
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < 20; x++) {
      if (map.get(y).charAt(x) == 'G') {
        blockList.add(new Block(x*40, y*40, map.get(y).charAt(x)));
      } if (map.get(y).charAt(x) == 'F') {
        flagpole = (new Flag(x*40, y*40, map.get(y).charAt(x)));
      } 
    }
  }
}

void loadImages() {
  blockImgs[0] = loadImage("crackedTile.png");
  flagpoleIMG = loadImage("flagpole.png");
  flagIMG = loadImage("flag.png");
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
  background(0);
  player.update();
  for (Block block : blockList) {
    block.img.resize(TILESIZE, TILESIZE);
    block.disp();
  }
  flagpole.img.resize(40, 400);
  flagpole.disp();
  player.disp();
  
}
