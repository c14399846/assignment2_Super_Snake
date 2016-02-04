class Snake extends GameObjects
{
   Snake()
   {

   }
   
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

     }//end if keyPressed
     
     
     //body part movement
     if(frameCount%6==0) 
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
     fill(sH);
     // rect(pos.x,pos.y,snakeSize,snakeSize);
     //snake head
     rect(snakeX.get(0)*snakeSize,snakeY.get(0)*snakeSize,snakeSize,snakeSize,snakeHeadCurv);
     
     
     //snake body
     for(int i = 1;i < snakeX.size(); i++)
     {
       fill(sB);
       rect(snakeX.get(i)*snakeSize,snakeY.get(i)*snakeSize,snakeSize,snakeSize,snakeBodyCurv);
     }
     //position taken from snakeX and snakeY will determine the snakes position, length, etc
   }
   
}