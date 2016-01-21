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

//menu system
boolean menu = true;
boolean mode = true;

//mode system
boolean easy = false;
boolean norm = false;
boolean hard = false;
boolean xtrm = false;

//game status
//this is for the wall system, game over if you die, other
boolean gameOver = false;
boolean game0 = true;
boolean game1 = false;
boolean game2 = false;

int initHeight = 1200;
int initWidth = 1200;
int fps = 60;

int score = 0;

ArrayList<Integer> snakeX = new ArrayList<Integer>();
ArrayList<Integer> snakeY = new ArrayList<Integer>();

//classes
ControlP5 controlP5;

//Main menu buttons
controlP5.Button menu_button;
controlP5.Button mode_button;

//Mode buttons
controlP5.Button easy_button;
controlP5.Button norm_button;
controlP5.Button hard_button;
controlP5.Button xtrm_button;

void setup()
{
  surface.setSize(initHeight,initWidth);
  controlP5 = new ControlP5(this); //button class
  
  menu();
  
}

//just setting up. positions not set yet. will do later in refinements
void menu()
{
  menu_button = controlP5.addButton("Main Menu" ,1,initWidth/2,initHeight/2,100,75);
  mode_button = controlP5.addButton("Game Mode" ,1,initWidth/2,initHeight/2,100,75);
  
  easy_button = controlP5.addButton("Easy" ,1,initWidth/2,initHeight/2,100,75);
  norm_button = controlP5.addButton("Normal" ,1,initWidth/2,initHeight/2,100,75);
  hard_button = controlP5.addButton("Hard" ,1,initWidth/2,initHeight/2,100,75);
  xtrm_button = controlP5.addButton("Extreme" ,1,initWidth/2,initHeight/2,100,75);
  
  
}


void draw()
{
  background();
  frameRate(fps);
  
}