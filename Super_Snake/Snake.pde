class Snake extends GameObjects
{
   int score;
   int mPU;//mice eaten
   int fPU;//fruit eaten
   int deathScore;   
   boolean eaten;//if powerup is eaten
   color sH;//snake head colour
   color sB;//snake body colour
   
   Snake()
   {
     //this.sP = snakeHeadCurv;
     this.sH = color(0,100,0);
     this.sB = color(0,255,0);
   }
   
  void CheckDeath()
  {  
    
     for(int i = 1;i < snakeX.size();i++)
      {
        if(snakeX.get(0) == snakeX.get(i) && snakeY.get(0) == snakeY.get(i))
        {
          gameOver = true;
        }
      }
    
      if(snakeX.get(0) >= (initWidth/snakeSize) || snakeX.get(0) < 0  || snakeY.get(0) >= (initHeight/snakeSize) || snakeY.get(0) < 0)
      {
        gameOver = true;
      }
      
      if(gameOver)
      {
          fill(255);
          textAlign(CENTER);
          textSize(30);
          sound_die.play();
          text("Game Over.",initWidth/2,initHeight/4);
          textSize(20);
          text("Score: " + score,initWidth/2,(initHeight/4) + (0.1 * initHeight));
          text("Cherry: " + snake.fPU + " Mice: " + snake.mPU,initWidth/2,(initHeight/4) + (0.2 * initHeight));
          text("Press 'r' to reset or 'm' to go to menu",initWidth/2,(initHeight/4) + (0.3 * initHeight));
          checkScore();
          
          if(higher==true)
          {
            textAlign(CENTER);
            fill(255,0,0);
            text("New High Score ! : " +snake.score,initWidth/2,initHeight/2 + (0.4*initHeight));
            fill(255);
          }
          
          if(keyPressed)
          {
            if(key == 'r' || key == 'R')
            {
              snakeReincarnate();//restarts snake
            }
            else if(key == 'm' || key == 'M')
            { 
              //menu stuff, could be exchanged for buttons, or have both
              
              snakeReincarnate();
              play = false;
              menu = true;
              Info = false;
            }
          }
      }
  }//end checkDeath
   
  void snakeReincarnate()
  {
    sound_die.rewind();
    sound_die.pause();
    //removes all snake segments
    snakeX.clear();
    snakeY.clear();
    
    //re-adds first 5 snake body parts to the arraylist, gives initial direction(right)
    snakeSetup();
    
    gameOver = false;
  }//end snakeReincarnate
  
  //checks current player score and hiscore stored in txt file
  void checkScore()
  {    
    deathScore = Integer.parseInt(hiscore[0]);
    
    if(deathScore < score)
    {
      higher = true;
      hiscore[0] = str(snake.score);
      saveStrings("data/hiscore.txt", hiscore);
    }
  }//end checkScore
  
  void PUEaten()
  {
    if(!sound_eat2.isPlaying())//stops it from spamming eating sound
    {
      sound_eat2.rewind();
      sound_eat2.play();//plays sound 'nom' or something to that effect
    }
  }//end PUEaten
   
   void update()
   {
     //body part movement
     if(frameCount%difficulty==0) 
     {
       //adds a new snake segment to the start
       snakeX.add(0,snakeX.get(0) + dir_horiz);
       snakeY.add(0,snakeY.get(0) + dir_vertic);
         
       if(eaten)
       {
         PUEaten();
         eaten = false;//having eaten outside of fucntion stops from 'hanging'
                       //this means the snake wont keep growing until the sound is done playing
                       //instead the sound can play, and the bool will be turned into false straight after
       }
       
       else if(!eaten)
       {
         //removes the last snake segment
         snakeX.remove(snakeX.size() - 1);
         snakeY.remove(snakeY.size() - 1);
       } 
     }

   }//end update
   
   void render()
   {
     //snake head
     fill(sH);
     stroke(cherry.cherryLine);
     rect(snakeX.get(0)*snakeSize,snakeY.get(0)*snakeSize,snakeSize+(snakeSize*0.07),snakeSize+(snakeSize*0.07),snakeHeadCurv);

     //snake body
     for(int i = 1;i < snakeX.size(); i++)
     {
       fill(sB);
       rect(snakeX.get(i)*snakeSize,snakeY.get(i)*snakeSize,snakeSize,snakeSize,snakeBodyCurv);
       strokeWeight(2);
     }
   }//end render   
}