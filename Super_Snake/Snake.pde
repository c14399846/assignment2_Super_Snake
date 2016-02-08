class Snake extends GameObjects
{
   int score;
   int mPU;
   int fPU;
   boolean eaten;//if powerup is eaten
   //int sP;
   
   
   Snake()
   {
     //this.sP = snakeHeadCurv;
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
        if(!easy && !norm)//if you're playing on a difficulty above easy and normal
        {
          gameOver=true;
        }
        /*else
        {
          //code for placing snake on opposite side of grid, maybe ********
          //head will be placed on opposite, but dont know if body will too? *******
        }*/
      }
      
      if(gameOver)
      {
          fill(255);
          textAlign(CENTER);
          textSize(30);
          text("Game Over.",initWidth/2,initHeight/2);
          textSize(20);
          text("Score: " + score,initWidth/2,(initHeight/2) + (0.1 * initHeight));
          text("Cherry: " + snake.fPU + " Mice: " + snake.mPU,initWidth/2,(initHeight/2) + (0.2 * initHeight));
          text("Press 'r' to reset or 'm' to go to menu",initWidth/2,(initHeight/2) + (0.3 * initHeight));
          
          
          if(keyPressed)
          {
            if(key == 'r' || key == 'R')
            {
              snakeReincarnate();//restarts snake
            }
            /*else if(key == 'm' || key == 'M')
            { 
              //menu stuff, could be exchanged for buttons, or have both
            }*/
          }
      }
  }
   
  void snakeReincarnate()
  {
    //removes all snake segments
    snakeX.clear();
    snakeY.clear();
    
    //checkScore();
    
    //re-adds first 5 snake body parts to the arraylist, gives initial direction(right)
    snakeSetup();
    
    gameOver = false;
  }
  
  //function to check score of player, will have string of 3 length for username, and score of current player
  void checkScore()
  {
    /* ***** ADD CODE FOR SCORE CHECK ***** */
  }
   
  /*void wasdEyes(int i)
  {
     switch (wasd)
     {
       case 'w':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,5,5,0,0); fill(0); rect((snakeY.get(i)*snakeSize) + (4), snakeY.get(i)*snakeSize + (2),6,10 ); rect((snakeY.get(i)*snakeSize) + (16), snakeY.get(i)*snakeSize + (2),6,10 ); fill(sH);
         break;
       case 'W':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,5,5,0,0); fill(0); rect((snakeY.get(i)*snakeSize) + (4), snakeY.get(i)*snakeSize + (2),6,10 ); rect((snakeY.get(i)*snakeSize) + (16), snakeY.get(i)*snakeSize + (2),6,10 ); fill(sH);
         break;
          
       case 'a':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,5,0,0,5); fill(0); rect((snakeY.get(i)*snakeSize) + (2), snakeY.get(i)*snakeSize + (4),10,6 ); rect((snakeY.get(i)*snakeSize) + (2), snakeY.get(i)*snakeSize + (16),10,6 ); fill(sH);
         break;
       case 'A':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,5,0,0,5); fill(0); rect((snakeY.get(i)*snakeSize) + (2), snakeY.get(i)*snakeSize + (4),10,6 ); rect((snakeY.get(i)*snakeSize) + (2), snakeY.get(i)*snakeSize + (16),10,6 ); fill(sH);
         break;
          
       case 's':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,0,0,5,5); fill(0); rect((snakeY.get(i)*snakeSize) + (4), snakeY.get(i)*snakeSize + (snakeSize - 12),6,10 ); rect((snakeY.get(i)*snakeSize) + (16), snakeY.get(i)*snakeSize + (snakeSize -12),6,10 ); fill(sH);
         break;
       case 'S':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,0,0,5,5); fill(0); rect((snakeY.get(i)*snakeSize) + (4), snakeY.get(i)*snakeSize + (snakeSize - 12),6,10 ); rect((snakeY.get(i)*snakeSize) + (16), snakeY.get(i)*snakeSize + (snakeSize -12),6,10 ); fill(sH);
         break;
          
       case 'd':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,0,5,5,0); fill(0); rect((snakeY.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (4),10,6 ); rect((snakeY.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (16),10,6 ); fill(sH);
         break;
       case 'D':
         rect(snakeX.get(i)*snakeSize, snakeY.get(i)*snakeSize, snakeSize, snakeSize,0,5,5,0); fill(0); rect((snakeY.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (4),10,6 ); rect((snakeY.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (16),10,6 ); fill(sH);
         break;
          
       default:
         break;
     }
  }*/
  
  void PUEaten()
  {
    sound_eat.rewind();
    sound_eat.play();//plays sound 'nom' or something to that effect
    eaten = false;
  }
   
   void update()
   {
     if(keyPressed)
     {
       if (key == 'w' || key == 'W')
       {
         dir_horiz = dirSnake[0];
         dir_vertic = dirSnake[2];
       }
       if (key == 's' || key == 'S')
       {
         dir_horiz = dirSnake[0];
         dir_vertic = dirSnake[1];
       } 
       if (key == 'a' || key == 'A')
       {
         dir_horiz = dirSnake[2];
         dir_vertic = dirSnake[0];
       } 
       if (key == 'd' || key == 'D')
       {
         dir_horiz = dirSnake[1];
         dir_vertic = dirSnake[0];
       }
       //wasd=key;
     }//end if keyPressed
     
     
     //body part movement
     if(frameCount%difficulty==0) 
     {
       //adds a new snake segment to the start
       snakeX.add(0,snakeX.get(0) + dir_horiz);
       snakeY.add(0,snakeY.get(0) + dir_vertic);
         
       if(eaten)
       {
         PUEaten();
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
     fill(sH);
     //snakeParts.setFill(sH);
     
     //sP = snakeHeadCurv;
     //snake head
     rect(snakeX.get(0)*snakeSize,snakeY.get(0)*snakeSize,snakeSize+(snakeSize*0.07),snakeSize+(snakeSize*0.07),snakeHeadCurv);
       
     //snake eyes;
     //fill(0);// rect((snakeX.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (4),10,6 ); rect((snakeX.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (16),10,6 ); fill(sH);
       
     //wasdEyes(0);
     //shape(snakeParts,snakeX.get(0)*snakeSize,snakeY.get(0)*snakeSize);
    
     //sP = snakeBodyCurv;
     //snake body
     for(int i = 1;i < snakeX.size(); i++)
     {
       fill(sB);
       //snakeParts.setFill(sB);
       rect(snakeX.get(i)*snakeSize,snakeY.get(i)*snakeSize,snakeSize,snakeSize,snakeBodyCurv);
       //shape(snakeParts,snakeX.get(i)*snakeSize,snakeY.get(i)*snakeSize);
       
       strokeWeight(2);
       stroke(0);
         
       /*if(key == 'w' || key == 's' || key == 'W' || key == 'S')
       {
         line(snakeX.get(i)*snakeSize+(snakeSize*0.5),snakeY.get(i)*snakeSize+(1),snakeX.get(i)*snakeSize+(snakeSize*0.5),snakeY.get(i)*snakeSize+(snakeSize-1));
       }
       else if(key == 'a' || key == 'd' || key == 'A' || key == 'D')
       {
         line(snakeX.get(i)*snakeSize+1,snakeY.get(i)*snakeSize+(snakeSize*0.5),snakeX.get(i)*snakeSize+(snakeSize-1),snakeY.get(i)*snakeSize+(snakeSize*0.5));
       }*/
     }
   }//end render
   
   
  /* ***** REMOVE SOME FILLS ***** */
  
   
   
   
}