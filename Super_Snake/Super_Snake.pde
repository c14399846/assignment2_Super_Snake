/*
C14399846
*/

//libraries
import java.util.*;//used for setSize function
import controlP5.*;//used for buttons
import ddf.minim.*;//used for sound

//menu system
boolean play = false;
boolean menu = true;
boolean mode = false;
boolean modeSel = false;
boolean muteVol = false;
boolean fScreen = false;

//mode system
boolean easy = false;
boolean norm = false;
boolean hard = false;
boolean xtrm = false;

//game status
//this is for the wall system, game over if you die, other
boolean gameOver = false;
boolean Info = false;

boolean higher;//checks if new score is achieved

boolean keyedW=true;
boolean keyedA=false;
boolean keyedS=false;
boolean keyedD=false;

String difficSel = "";//difficulty selected by user

int initHeight = 1200;
int initWidth = 1200;

int fps = 60;
int snakeSize = 30; // snakes width and height
int snakeHeadCurv = 6;// curvature of snakes head
int snakeBodyCurv = 10;// curvature of snakes body

int difficulty = 0; /* 4 is easiest,1 is hardest, used in framecount */

int imgBorder = 200;// border for images
int bNum = 6;// number of buttons

int PUCurv ;// same as snake curv
int PUSize ;// same as snake curv

//menu button sizes
int buttonX = 75;
int buttonY = 50;

//mouse position
int PUMouseX;
int PUMouseY;

//fruit position
int PUFruitX;
int PUFruitY;

//'dont move', move 'forward', move 'back'
int[] dirSnake = {0,1,-1};
int dir_horiz;
int dir_vertic;

ArrayList<Integer> snakeX = new ArrayList<Integer>();// x position
ArrayList<Integer> snakeY = new ArrayList<Integer>();// y position

String[] hiscore;//local score storage


//classes
ControlP5 cP5;


//Main menu buttons
controlP5.Button play_button;
controlP5.Button menu_button;
controlP5.Button mode_button;
controlP5.Button reset_button;
controlP5.Button mute_button;
controlP5.Button info_button;
controlP5.Button fScreen_button;

//Gamemode / Difficulty buttons
controlP5.Button easy_button;
controlP5.Button norm_button;
controlP5.Button hard_button;
controlP5.Button xtrm_button;

//game objects
Snake snake;
Mouse mouse;
Fruit cherry;

//audiofiles
Minim minim;
AudioPlayer sound_eat;
AudioPlayer sound_eat2;
AudioPlayer sound_die;
AudioPlayer sound_squeek;

//info and intro images
PImage img;
PImage imgInfo;


void setup()
{
  //surface.setSize(initWidth,initHeight);
  smooth(8);
  
  //for fullscreen testing
  fullScreen();
  initWidth = width;
  initHeight = height;
  snakeSize=60;
  
  
  PUCurv = snakeBodyCurv;// same as snake curv
  PUSize = snakeSize;
  
  
  
  
  //surface.setResizeable(true);
  
  minim = new Minim(this);
  snake = new Snake();
  mouse = new Mouse();
  cherry = new Fruit();
  
  snakeSetup();// sets up snake direction, spawns of powerups, sets scores to 0
  snakeSounds();
  
  //high scores txt
  hiscore = loadStrings("hiscore.txt");
  
  img = loadImage("data/gifs/menu_1000.gif");
  imgInfo = loadImage("data/gifs/info.PNG");
  
  img.resize(initWidth-imgBorder,initHeight-imgBorder);
  imgInfo.resize(initWidth-imgBorder,initHeight-imgBorder);
  
  cP5 = new ControlP5(this); //button class
  cP5.setColorBackground(color(0,150,150));
  cP5.setColorForeground(color(0,120,120));
  cP5.setColorActive(color(0,130,130));
  
  /* ****************ADD IN LATER */
  //for(int i =0;i<bNum;i++)
  //{
    menu_button = cP5.addButton("Main Menu" ,1,0,0,initWidth/bNum,buttonY);
    play_button = cP5.addButton("Play" ,1,0,0,initWidth/bNum,buttonY);
    mode_button = cP5.addButton("Game Mode" ,1,initWidth/bNum,0,initWidth/bNum,buttonY);
    reset_button = cP5.addButton("Reset" ,1,initWidth/bNum * 2,0,initWidth/bNum,buttonY);
    mute_button = cP5.addButton("Mute" ,1,initWidth/bNum*3,0,initWidth/bNum,buttonY);
    info_button = cP5.addButton("Info" ,1,initWidth/bNum*4,0,initWidth/bNum,buttonY);
    fScreen_button = cP5.addButton("Full screen" ,1,initWidth/bNum*5,0,initWidth/bNum,buttonY);
    
    easy_button = cP5.addButton("Easy" ,1,initWidth/bNum,buttonY,initWidth/bNum,buttonY);
    norm_button = cP5.addButton("Normal" ,1,initWidth/bNum,buttonY*2,initWidth/bNum,buttonY);
    hard_button = cP5.addButton("Hard" ,1,initWidth/bNum,buttonY*3,initWidth/bNum,buttonY);
    xtrm_button = cP5.addButton("Extreme" ,1,initWidth/bNum,buttonY*4,initWidth/bNum,buttonY);
 // }
  
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
  for(int i =0;i<5;i++){snakeX.add(i);snakeY.add(i);}
  dir_horiz = dirSnake[1];
  dir_vertic = dirSnake[0];
  
  keyedD=true;
  keyedA=false;
  keyedS=false;
  keyedW=false;
  
  //player score, amount of mice and cherries eaten
  snake.score = 0;
  snake.mPU = 0;
  snake.fPU = 0;  

  
  //mouse position
  PUMouseX = (int) random(0,(initWidth/PUSize));
  PUMouseY = (int) random(0,(initHeight/PUSize));

  //fruit position
  PUFruitX = (int) random(0,(initWidth/PUSize));
  PUFruitY = (int) random(0,(initHeight/PUSize));
  
  higher = false;//high score check
}



//button system for the game
void controlEvent(ControlEvent buttonPressed)
{
  if(buttonPressed.controller().getName().equals("Full sceen")){
    fScreen = !fScreen;
  }
  
  if(buttonPressed.controller().getName().equals("Main Menu")){
    menu = true;
    Info = false;
  }
  
  if(buttonPressed.controller().getName().equals("Reset")){
    hiscore[0] = str(0);
    saveStrings("data/hiscore.txt",hiscore);
  }
  
  if(buttonPressed.controller().getName().equals("Mute")){
    muteVol = !muteVol;
  }
  
  if(buttonPressed.controller().getName().equals("Game Mode")){
    menu = false;
    mode = true;
    Info = false;
  }
  
  if(buttonPressed.controller().getName().equals("Play") && modeSel){
    play = true;
    Info = false;
    menu = false;
  }
  
  if(buttonPressed.controller().getName().equals("Info")){
    Info = !Info;  
  }
  
  if(buttonPressed.controller().getName().equals("Easy")){
    easy = true;
    modeSel = true;
    difficulty = 4;
    difficSel = "Easy";
    norm = false;
    hard = false;
    xtrm = false;
    menu = true;
  }  
  
  if(buttonPressed.controller().getName().equals("Normal")){
    norm = true;
    modeSel = true;
    difficulty = 3;
    difficSel = "Normal";
    easy = false;
    hard = false;
    xtrm = false;
    menu = true;
  }  
  
  if(buttonPressed.controller().getName().equals("Hard")){
    hard = true;
    modeSel = true;
    difficulty = 2;
    difficSel = "Hard";
    easy = false;
    norm = false;
    xtrm = false;
    menu = true;
  }  
  
  if(buttonPressed.controller().getName().equals("Extreme")){
    xtrm = true;
    modeSel = true;
    difficulty = 2;
    difficSel = "Xtreme";
    easy = false;
    norm = false;
    hard = false;
    menu = true;
  }  
}

//info about the game, how to play, how you die, etc
void Info()
{
  image(imgInfo,10,imgBorder);
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

//shows difficulty buttons
void gameMode()
{    
    menu_button.show();
    easy_button.show();
    norm_button.show();
    hard_button.show();
    xtrm_button.show();
}

void gamePlay()
{
  mode=false;
  hideAll();//hides menu ui
  
  checkSound();//checks for sound mute
  
  deather();//checks for deth of object
  
  if(!gameOver && play)
  {
    snake.update();
    snake.render();
    
    mouse.update();
    mouse.render();
    
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
  fScreen_button.hide();
  
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
    if(Info == false)
    {
      image(img,imgBorder,imgBorder);
    }
    
    else if(Info == true)
    {
      Info();
    }
  }
  
  
  if(mode == true)
  {  
    gameMode();
    image(img,imgBorder,imgBorder);
  }
  
  //if user selects play, run game
  if(play == true)
  {
    gamePlay();
  }
  
 
}

//shows slected difficulty and player high score
void menuStats()
{
  if(!play)
  {
    fill(255);
    textSize(16);
    
    text("Difficulty: " +difficSel,initWidth - buttonX*3,buttonY*2);
    text("Current Highest Score: " +hiscore[0],initWidth - buttonX*3,buttonY*2.5);
  }
}


//mutes and unmutes sounds if button is pressed in menu
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

//checks if snake is touhing edge or itself,
//will show gameover screen and let user go back to menu
//also checks if mouse or cherry have been eaten, then respawns them
void deather()
{
  snake.CheckDeath();
  mouse.CheckDeath();
  cherry.CheckDeath();
}

//snake movement
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