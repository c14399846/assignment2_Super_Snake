import java.util.*;//used for setSize function
import controlP5.*;//used for buttons
import ddf.minim.*;//used for sound
//import gifAnimation.*;//add later

/******
Game : 
  Snake 

Goal :
  The goal is to make a classic game that is class-based.
  
  It must use programming practices such as inheritance, polymorhpism, abstract classes,
  sound files, animations, while being procedural in nature ( e.g spawning of enemies or buffs).
  
Features(That I hope to implement):
  Interfaces - menu system
  
  High-score storage
    reaching a certain high score will unlock other difficulties
    
  Various difficulty settings
    Easy,Normal,Hard
      Normal has increased speed, and addition of walls(?)
      Hard has increased speed, removal of tracking lines, and addition of walls
      
  Multiple powerups
    size-increase, score-increasing, invulnerability(?)
    Reaching a certain number of powerups or score will make walls appear

How things are done:
  snake, powerups (fruit/mouse) are given their own class, with lives, speed, size(?), etc,
  which will extend a position/Pvector class - gObjects
  
  guidelines are drawn in a function x frames (120) per sec
  
  All modes (?) will let you go through oppoiste wall, Hard mode, or an Extreme mode could exclude this bit of code
  
  walls are given their own function; only activate when in Normal/Hard mode, and when score = 1000 or 15 powerups are collected
    
  Fruits can also be a moving object / timed object - based on framerate counting
  

******/


//menu system
boolean play = false;
boolean menu = true;
boolean mode = false;
boolean modeSel = false;
boolean muteVol = false;

//mode system
boolean easy = false;
boolean norm = false;
boolean hard = false;
boolean xtrm = false;

//game status
//this is for the wall system, game over if you die, other
boolean gameOver = false;
/*boolean game0 = true;//where there are no walls
boolean game1 = false;
boolean game2 = false;*/

boolean higher;//checks if new score is achieved

boolean keyedW=true;
boolean keyedA=false;
boolean keyedS=false;
boolean keyedD=false;

String difficSel = "";

int initHeight = 1200;
int initWidth = 1200;
int fps = 60;
int snakeSize = 30; //snakes  width and height
int snakeHeadCurv = 5;// curvature of snakes head
int snakeBodyCurv = 10;// curvature of snakes body
int difficulty = 0; /* *****  4 is easiest,1 is hardest ***** */
int bNum = 5;

int PUCurv = snakeBodyCurv;
int PUSize = snakeSize;

int buttonX = 75;
int buttonY = 50;

//mouse position
int PUMouseX;
int PUMouseY;

//fruit position
int PUFruitX;
int PUFruitY;

//dont move, move 'forward', move 'back'
int[] dirSnake = {0,1,-1};
//starts snake moving right
int dir_horiz;
int dir_vertic;

ArrayList<Integer> snakeX = new ArrayList<Integer>();
ArrayList<Integer> snakeY = new ArrayList<Integer>();
//ArrayList<Integer> snakeBack = new ArrayList<Integer>();
//ArrayList<loadIn> scoreKeeper = new ArrayList<loadIn>();

String[] hiscore;


//classes
ControlP5 cP5;


DropdownList dropDiff;

//Main menu buttons
controlP5.Button play_button;
controlP5.Button menu_button;
controlP5.Button mode_button;
controlP5.Button reset_button;
controlP5.Button mute_button;
controlP5.Button info_button;

//Mode buttons
controlP5.Button easy_button;
controlP5.Button norm_button;
controlP5.Button hard_button;
controlP5.Button xtrm_button;

PShape snakeParts;
Snake snake;
Mouse mouse;
Fruit cherry;

Minim minim;
AudioPlayer sound_eat;
AudioPlayer sound_eat2;
AudioPlayer sound_die;
AudioPlayer sound_squeek;



PImage img;


void setup()
{
  surface.setSize(initWidth,initHeight);
  smooth(8);
  //fullScreen();  
  
  //each blocksize of the snake or powerups will be be 60 or 30 pixels, THE PLACE WHERE IT'S INITIATED MAY BE MOVED LATER ON, INTO IT'S OWN CLASS *****
  //this is just the snakes first position
  minim = new Minim(this);
  snake = new Snake();
  mouse = new Mouse();
  cherry = new Fruit();
  
  snakeSetup();
  snakeSounds();
  
  
  //snakeParts = createShape(RECT, 0, 0, 30, 30, snake.sP, snake.sP);
  
  //high scores txt
  hiscore = loadStrings("hiscore.txt");
  
  img = loadImage("snakepixel_800.gif");
  
  cP5 = new ControlP5(this); //button class
  
  
  menu_button = cP5.addButton("Main Menu" ,1,0,0,initWidth/bNum,buttonY);
  play_button = cP5.addButton("Play" ,1,0,0,initWidth/bNum,buttonY);
  mode_button = cP5.addButton("Game Mode" ,1,initWidth/bNum,0,initWidth/bNum,buttonY);
  reset_button = cP5.addButton("Reset" ,1,initWidth/bNum * 2,0,initWidth/bNum,buttonY);
  mute_button = cP5.addButton("Mute" ,1,initWidth/bNum*3,0,initWidth/bNum,buttonY);
  info_button = cP5.addButton("Info" ,1,initWidth/bNum*4,0,initWidth/bNum,buttonY);
  
  cP5.setColorBackground(color(0,150,150));
  cP5.setColorForeground(color(0,120,120));
  cP5.setColorActive(color(0,130,130));
  
  easy_button = cP5.addButton("Easy" ,1,initWidth/bNum,buttonY,initWidth/bNum,buttonY);
  norm_button = cP5.addButton("Normal" ,1,initWidth/bNum,buttonY*2,initWidth/bNum,buttonY);
  hard_button = cP5.addButton("Hard" ,1,initWidth/bNum,buttonY*3,initWidth/bNum,buttonY);
  xtrm_button = cP5.addButton("Extreme" ,1,initWidth/bNum,buttonY*4,initWidth/bNum,buttonY);
  
}

void snakeSounds()
{
  sound_eat = minim.loadFile("nom.mp3");
  sound_eat2 = minim.loadFile("snakeEat3.mp3");
  sound_die = minim.loadFile("snakeShake3.mp3");
  sound_squeek = minim.loadFile("squeek.mp3");
}

void snakeSetup()
{
  //adds first 5 snake body parts to the arraylist, gives initial direction(right)
  for(int i =0;i<5;i++){snakeX.add(i);snakeY.add(i);}// ***** might need changes,looks cool though
  dir_horiz = dirSnake[1];
  dir_vertic = dirSnake[0];
  
  keyedD=true;
  keyedA=false;
  keyedS=false;
  keyedW=false;
  
  snake.score = 0;
  snake.mPU = 0;
  snake.fPU = 0;  
  
  /* ********* the pu positions will be changed to PUX and PUY, and will be passed into each class,
               there pux and puy will be given their own unique values - this.pux this puy, etc,
               a collisioncheck() funciton will be made to stop same spawns,
               either in draw or elsewhere
     ********* 
  */
  
  //mouse position
  PUMouseX = (int) random(0,(initWidth/snakeSize));
  PUMouseY = (int) random(0,(initHeight/snakeSize));

  //fruit position
  PUFruitX = (int) random(0,(initWidth/snakeSize));
  PUFruitY = (int) random(0,(initHeight/snakeSize));
  
  higher = false;
}



//button system for the game
void controlEvent(ControlEvent buttonPressed)
{
  if(buttonPressed.controller().getName().equals("Main Menu")){
    menu = true;
  }
  
  if(buttonPressed.controller().getName().equals("Reset")){
    hiscore[0] = str(0);
    saveStrings("data/hiscore.txt",hiscore);
    
    //textFont(Arial);
    /*
    stroke(0);
    textAlign(CENTER);
    textSize(20);
    text("Hiscore has been reset to 0",initWidth/2,initHeight/2);*/
  }
  
  if(buttonPressed.controller().getName().equals("Mute")){
    muteVol = !muteVol;
  }
  
  if(buttonPressed.controller().getName().equals("Game Mode")){
    menu = false;
    mode = true;
  }
  
  if(buttonPressed.controller().getName().equals("Play") && modeSel){
    play = true;
  }
  
  /*if(buttonPressed.controller().getName().equals("Play") && !modeSel){
    textAlign(CENTER);
    textSize(20);
    text("Choose a difficulty to play snake", initWidth/2,initHeight/2);
  }
  
  if(buttonPressed.controller().getName().equals("Info")){
    
  }*/
  
  if(buttonPressed.controller().getName().equals("Easy")){
    easy = true;
    modeSel = true;
    difficulty = 4;
    difficSel = "Easy";
    norm = false;
    hard = false;
    xtrm = false;
  }  
  
  if(buttonPressed.controller().getName().equals("Normal")){
    norm = true;
    modeSel = true;
    difficulty = 3;
    difficSel = "Normal";
    easy = false;
    hard = false;
    xtrm = false;
    
  }  
  
  if(buttonPressed.controller().getName().equals("Hard")){
    hard = true;
    modeSel = true;
    difficulty = 2;
    difficSel = "Hard";
    easy = false;
    norm = false;
    xtrm = false;
  }  
  
  if(buttonPressed.controller().getName().equals("Extreme")){
    xtrm = true;
    modeSel = true;
    difficulty = 2;
    difficSel = "Xtreme";
    easy = false;
    norm = false;
    hard = false;
  }  
}

//at start of program you are shown the menu system, game difficulty and menu return are hidden until needed
void menu()
{
  menu_button.hide();
  
  easy_button.hide();
  norm_button.hide();
  hard_button.hide();
  xtrm_button.hide();
  
  play_button.show();
  mode_button.show();
  reset_button.show();
  mute_button.show();
  info_button.show();
  

  //the game requires you to choose a difficulty to play, resets to false at end of game
  mode = false;
  easy = false;
  norm = false;
  hard = false;
  xtrm = false;
  
  menuStats();
  
}

void gameMode()
{
    /*mode_button.hide();
    play_button.hide();
    reset_button.hide();
    mute_button.hide();
    info_button.hide();*/
    
    menu_button.show();
    easy_button.show();
    norm_button.show();
    hard_button.show();
    xtrm_button.show();
}

void gamePlay()
{
  mode=false;
  hideAll();
  // will be moved later, into a switch statement or otherwise into menu system ***** 
  deather();
  
  if(!gameOver && play)
  {    
    mouse.update();
    mouse.render();
    
    snake.update();
    snake.render();
    
    cherry.update();
    cherry.render();
    
       
  }
}

void hideAll()
{
  menu_button.hide();
  mode_button.hide();
  play_button.hide();
  reset_button.hide();
  mute_button.hide();
  info_button.hide();
  
  easy_button.hide();
  norm_button.hide();
  hard_button.hide();
  xtrm_button.hide();
}


void draw()
{
  frameRate(fps);
  //need to increase speed in another way
  background(0);
  
  /***** removed just for testing purposes, will be added back in after game runs fine *****/
  if(menu == true)
  {
    //background(255);
    menu();
    //image(img,200,200);
  }
  
  if(mode == true)
  {  
    //background(255);
    gameMode();
    //image(img,200,200);
  }
  
  if(play == true)
  {
    //background(255);
    gamePlay();
  }
  
  checkSound();
  
}

void menuStats()
{
  if(!play)
  {
    fill(255);
    //textAlign(RIGHT);
    textSize(16);
    
    text("Difficulty: " +difficSel,initWidth - buttonX*3,buttonY*2);
    text("Current Highest Score: " +hiscore[0],initWidth - buttonX*3,buttonY*2.5);
  }
}

//checks for sound mute
void checkSound()
{
  if(!muteVol)
  {
    sound_die.unmute();
    sound_eat.unmute();
    sound_eat2.unmute();
  }
  
  else if(muteVol)
  {
    sound_die.mute();
    sound_eat.mute();
    sound_eat2.mute();
  }
}

void deather()
{
  snake.CheckDeath();
  mouse.CheckDeath();
  cherry.CheckDeath();
}

void keyPressed()
{
   if ((key == 'w' || key == 'W') && (keyedS != true))
   {
     dir_horiz = dirSnake[0];
     dir_vertic = dirSnake[2];
     keyedW=true;
     keyedA = false;
     keyedD = false;
   }
   
   if ((key == 's' || key == 'S') && (keyedW !=true))
   {
     dir_horiz = dirSnake[0];
     dir_vertic = dirSnake[1];
     keyedS = true;
     keyedA = false;
     keyedD = false;
   } 
   
   if ((key == 'a' || key == 'A')  && (keyedD != true))
   {
     dir_horiz = dirSnake[2];
     dir_vertic = dirSnake[0];
     keyedA = true;
     keyedW = false;
     keyedS = false;
   } 
   
   if ((key == 'd' || key == 'D') && (keyedA != true))
   {
     dir_horiz = dirSnake[1];
     dir_vertic = dirSnake[0];
     keyedD = true;
     keyedW = false;
     keyedS = false;
   }   
}