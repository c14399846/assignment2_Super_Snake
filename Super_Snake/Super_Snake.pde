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

import java.util.*;//used for setSize function
import controlP5.*;//used for buttons
import processing.sound.*;//used for playing and loading in soundfiles

/* ******add files later *****
SoundFile sound_eat;
Soundfile sound_die;
Soundfile sound_newGame;
*/

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



int initHeight = 600;/* ***** CHANGE TO 1200 FOR DEMO ***** */
int initWidth = 600;
int fps = 60;
int snakeSize = 30; //snakes  width and height
int snakeHeadCurv = 5;// curvature of snakes head
int snakeBodyCurv = 10;// curvature of snakes body
int difficulty = 3; /* ***** CHANGE TO 0 AFTER BUTTONS ARE RE-ENABLED, 3 is easiest,1 is hardest ***** */


int score = 0;

//dont move, move 'forward', move 'back'
int[] dirSnake = {0,1,-1};
//starts snake moving right
int dir_horiz = dirSnake[1];
int dir_vertic = dirSnake[0];

//char wasd='d';
color sH = color(0,125,0);
color sB = color(0,255,0);

ArrayList<Integer> snakeX = new ArrayList<Integer>();
ArrayList<Integer> snakeY = new ArrayList<Integer>();
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


void setup()
{
  surface.setSize(initWidth,initHeight);
  smooth(8);
  //fullScreen();
  
  snakeParts = createShape(RECT, 0, 0, 30, 30);  
  //each blocksize of the snake or powerups will be be 60 or 30 pixels, THE PLACE WHERE IT'S INITIATED MAY BE MOVED LATER ON, INTO IT'S OWN CLASS *****
  //this is just the snakes first position
  
  
  //adds first 5 snake body parts to the arraylist
  for(int i =0;i<5;i++){snakeX.add(6);snakeY.add(6);}
  
  snake = new Snake();
  gameObjects.add(snake);
  
  
  /*
  ***** will be added back in later, after game runs fine on its own*****
  controlP5 = new ControlP5(this); //button class
  
  menu_button = controlP5.addButton("Main Menu" ,1,initWidth/2,initHeight/2,100,75);
  play_button = controlP5.addButton("Play" ,1,initWidth/2,initHeight/2 - 75,100,75);
  mode_button = controlP5.addButton("Game Mode" ,1,initWidth/2,initHeight/2 - 150,100,75);
  
  easy_button = controlP5.addButton("Easy" ,1,initWidth/2,initHeight/2 - 75,100,75);
  norm_button = controlP5.addButton("Normal" ,1,initWidth/2,initHeight/2 - 150,100,75);
  hard_button = controlP5.addButton("Hard" ,1,initWidth/2,initHeight/2 - 225,100,75);
  xtrm_button = controlP5.addButton("Extreme" ,1,initWidth/2,initHeight/2 - 300,100,75);
  */
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
  
  if(buttonPressed.controller().getName().equals("Easy")){
    easy = true;
  }  
  
  if(buttonPressed.controller().getName().equals("Normal")){
    norm = true;
  }  
  
  if(buttonPressed.controller().getName().equals("Hard")){
    hard = true;
  }  
  
  if(buttonPressed.controller().getName().equals("Extreme")){
    xtrm = true;
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


void draw()
{
  frameRate(fps);
  //need to increase speed in another way
  background(0);
  /*
  ***** removed just for testing purposes, will be added back in after game runs fine *****
  if(menu == true){
    background(0);
    menu(); 
  }
  
  if(mode == true){  
    background(0);
    gameMode();
  }
  */
  
  // will be moved later, into a switch statement or otherwise into menu system *****
  if(!gameOver)
  {
    snake.update();
    snake.render();
  }
  snake.CheckDeath();
}