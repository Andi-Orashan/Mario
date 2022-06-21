public PImage[] blockImgs = new PImage[2];
public PImage flagpoleIMG;
public PImage flagIMG;
public ArrayList<String> map = new ArrayList<String>();
public ArrayList<Block> blockList = new ArrayList<Block>();
String line;
public int TILESIZE = 40;
BufferedReader reader;
Player player = new Player();
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
public Flag flagpole = new Flag(-10000000, -1000000, 'f');

=======
public PImage open;
public boolean start = false;
>>>>>>> 24f59950e24655afa18e187a2229f0d8a5b34cee
=======
public PImage open;
public boolean start = false;
>>>>>>> f86cc055b77d6cdc82f861360bf4f2dbfebf4114
=======
public PImage open;
public boolean start = false;
>>>>>>> f86cc055b77d6cdc82f861360bf4f2dbfebf4114
=======
public PImage open;
public boolean start = false;
>>>>>>> f86cc055b77d6cdc82f861360bf4f2dbfebf4114

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
  open = loadImage("image.png");
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
  if (!start) {
    image(open, 0, 0);
    fill(7,113,20);
    rect(280, 350,230,100);
    if (keyCode == ENTER) {
      start = true;
    }
  } else {
    background(0, 140, 255);
    fill(255);
    player.update();
    for (Block block : blockList) {
      block.img.resize(TILESIZE, TILESIZE);
      block.disp();
    }
    player.disp();
  }
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  flagpole.img.resize(40, 400);
  flagpole.disp();
  player.disp();
  
=======
>>>>>>> 24f59950e24655afa18e187a2229f0d8a5b34cee
=======
>>>>>>> f86cc055b77d6cdc82f861360bf4f2dbfebf4114
=======
>>>>>>> f86cc055b77d6cdc82f861360bf4f2dbfebf4114
=======
>>>>>>> f86cc055b77d6cdc82f861360bf4f2dbfebf4114
}
