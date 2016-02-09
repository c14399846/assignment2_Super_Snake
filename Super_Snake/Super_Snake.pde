import java.util.*;//used for setSize function
import controlP5.*;//used for buttons
//import processing.sound.*;//used for playing and loading in soundfiles
import ddf.minim.*;

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

//mode system
boolean easy = false;
boolean norm = false;
boolean hard = false;
boolean xtrm = false;

//game status
//this is for the wall system, game over if you die, other
boolean gameOver = false;
boolean game0 = true;//where there are no walls
boolean game1 = false;
boolean game2 = false;

boolean moved;




int initHeight = 600;/* ***** CHANGE TO 1200 FOR DEMO ***** */
int initWidth = 600;
int fps = 60;
int snakeSize = 30; //snakes  width and height
int snakeHeadCurv = 5;// curvature of snakes head
int snakeBodyCurv = 10;// curvature of snakes body
int difficulty = 3; /* ***** CHANGE TO 0 AFTER BUTTONS ARE RE-ENABLED, 3 is easiest,1 is hardest ***** */

//powerup up position and size
//int PUX;//powerup x
//int PUY;//powerup y
int PUCurv = snakeBodyCurv;
int PUSize = snakeSize;


/* ***** WILL BE CHANGED LATER ***** */

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
ArrayList<Integer> snakeBack = new ArrayList<Integer>();
ArrayList<GameObjects> gameObjects = new ArrayList<GameObjects>();



//classes
ControlP5 controlP5;

//Main menu buttons
controlP5.Button play_button;
controlP5.Button menu_button;
controlP5.Button mode_button;

//Mode buttons
controlP5.Button easy_button;
controlP5.Button norm_button;
controlP5.Button hard_button;
controlP5.Button xtrm_button;

Snake snake;
PShape snakeParts;

Mouse mouse;

Fruit cherry;

Minim minim;
AudioPlayer sound_eat;

void setup()
{
  surface.setSize(initWidth,initHeight);
  smooth(8);
  //fullScreen();  
  
  //each blocksize of the snake or powerups will be be 60 or 30 pixels, THE PLACE WHERE IT'S INITIATED MAY BE MOVED LATER ON, INTO IT'S OWN CLASS *****
  //this is just the snakes first position
  
  snake = new Snake();
  mouse = new Mouse();
  cherry = new Fruit();
  
  snakeSetup();
  
  //snakeSounds();
  minim = new Minim(this);
  
  
  sound_eat = minim.loadFile("nom.mp3");
  //snakeParts = createShape(RECT, 0, 0, 30, 30, snake.sP, snake.sP);
  
  
  
  /***** will be added back in later, after game runs fine on its own*****/
  
  controlP5 = new ControlP5(this); //button class
  
  menu_button = controlP5.addButton("Main Menu" ,1,initWidth/2,initHeight/2,100,75);
  play_button = controlP5.addButton("Play" ,1,initWidth/2,initHeight/2 - 75,100,75);
  mode_button = controlP5.addButton("Game Mode" ,1,initWidth/2,initHeight/2 - 150,100,75);
  
  easy_button = controlP5.addButton("Easy" ,1,initWidth/2,initHeight/2 - 75,100,75);
  norm_button = controlP5.addButton("Normal" ,1,initWidth/2,initHeight/2 - 150,100,75);
  hard_button = controlP5.addButton("Hard" ,1,initWidth/2,initHeight/2 - 225,100,75);
  xtrm_button = controlP5.addButton("Extreme" ,1,initWidth/2,initHeight/2 - 300,100,75);
  
}

void snakeSounds()
{
  //sound_eat = new Minim(this,"nom.mp3");
  /*sound_die = new SoundFile(this,"");
  sound_newGame = new SoundFile(this,"");
  sound_squeek = new SoundFile(this,"");
*/
}

void snakeSetup()
{
  //adds first 5 snake body parts to the arraylist, gives initial direction(right)
  for(int i =0;i<5;i++){snakeX.add(i);snakeY.add(i);}// ***** might need changes,looks cool though
  dir_horiz = dirSnake[1];
  dir_vertic = dirSnake[0];
  
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
}



//button system for the game
void controlEvent(ControlEvent buttonPressed)
{
  if(buttonPressed.controller().getName().equals("Main Menu")){
    menu = true;
  }
  
  if(buttonPressed.controller().getName().equals("Game Mode")){
    menu = false;
    mode = true;
  }
  
  if(buttonPressed.controller().getName().equals("Play")){
    play = true;
  }
  
  if(buttonPressed.controller().getName().equals("Easy")){
    easy = !easy;
    norm = false;
    hard = false;
    xtrm = false;
  }  
  
  if(buttonPressed.controller().getName().equals("Normal")){
    norm = !norm;
    easy = false;
    hard = false;
    xtrm = false;
    
  }  
  
  if(buttonPressed.controller().getName().equals("Hard")){
    hard = !hard;
    easy = false;
    norm = false;
    xtrm = false;
  }  
  
  if(buttonPressed.controller().getName().equals("Extreme")){
    xtrm = !xtrm;
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

  //the game requires you to choose a difficulty to play, resets to false at end of game
  mode = false;
  easy = false;
  norm = false;
  hard = false;
  xtrm = false;
  
}

void gameMode()
{
    mode_button.hide();
    play_button.hide();
    
    menu_button.show();
    easy_button.show();
    norm_button.show();
    hard_button.show();
    xtrm_button.show();
}

void gamePlay()
{
  mode_button.hide();
  play_button.hide();
  // will be moved later, into a switch statement or otherwise into menu system ***** 
  deather();
  
  if(!gameOver && play)
  {
    mouse.update();
    mouse.render();
    
    cherry.update();
    cherry.render();
    
    snake.update();
    snake.render();    
  }
}


void draw()
{
  frameRate(fps);
  //need to increase speed in another way
  background(255);
  
  /***** removed just for testing purposes, will be added back in after game runs fine *****/
  if(menu == true)
  {
    background(255);
    menu(); 
  }
  
  if(mode == true)
  {  
    background(255);
    gameMode();
  }
  
  if(play == true)
  {
    background(255);
    gamePlay();
  }
  
  
}

void deather()
{
  snake.CheckDeath();
  mouse.CheckDeath();
  cherry.CheckDeath();
}

/*void hider()
{
  if(!(snakeX.get(1)*snakeSize == snakeSize && snakeY.get(1)*snakeSize == snakeSize))
  {
    fill(0);
    stroke(0);
    rect(snakeSize,snakeSize,snakeSize,snakeSize);
  }
}*/