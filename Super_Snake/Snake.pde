class Snake extends GameObjects
{
   //char wasd;
  
   Snake()
   {
     
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
  
   
   void update()
   {
     
     if(keyPressed)
     {
       if (key == 'w')
       {
         dir_horiz = dirSnake[0];
         dir_vertic = dirSnake[2];
       }
       if (key == 's')
       {
         dir_horiz = dirSnake[0];
         dir_vertic = dirSnake[1];
       } 
       if (key == 'a')
       {
         dir_horiz = dirSnake[2];
         dir_vertic = dirSnake[0];
       } 
       if (key == 'd')
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
       
       //removes the last snake segment
       snakeX.remove(snakeX.size()-1);
       snakeY.remove(snakeY.size()-1);
     }   
   }
   
   
   void render()
   {
     for(int i=0;i<1;i++)
     {
       fill(sH);
       //snakeParts.setFill(sH);
       
       //snake heads
       rect(snakeX.get(i)*snakeSize,snakeY.get(i)*snakeSize,snakeSize,snakeSize,snakeHeadCurv);
       
       //snake eyes;
       //fill(0);// rect((snakeX.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (4),10,6 ); rect((snakeX.get(i)*snakeSize) + (snakeSize - 12), snakeY.get(i)*snakeSize + (16),10,6 ); fill(sH);
       
       //wasdEyes(i);
       //shape(snakeParts,snakeX.get(0)*snakeSize,snakesnakeY.get(0)*snakeSize);
     }
    
     //snake body
     for(int i = 1;i < snakeX.size(); i++)
     {
       fill(sB);
       //snakeParts.setFill(sB);
       rect(snakeX.get(i)*snakeSize,snakeY.get(i)*snakeSize,snakeSize,snakeSize,snakeBodyCurv);
       // shape(snakeParts,snakeX.get(i)*snakeSize,snakesnakeY.get(i)*snakeSize);
     }
   }
   
   
  /* ***** REMOVE SOME FILLS ***** */
  
   
   
   
}