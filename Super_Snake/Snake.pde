class Snake extends GameObjects
{
   PVector pos;
   PVector move;
   int difficulty; // MIGHT BE CHANGED TO OTHER CLASS/FUNCTION, OR DELETED ALTOGETHER
   
   Snake(int x,int y)
   {
     pos = new PVector(x,y);
     move = new PVector();//need to figure out how to do fourway movement *****
   }
   
   void update()
   {
     //need to add movement code here first
     
     
     //keypressed is initially used, as you only want one key to be pressed at a time
     //might change to other key system, depending on gameplay
     if(keyPressed)
     {
       if (key == 'w')
       {
        
       }
       if (key == 's')
       {
        
       } 
       if (key == 'a')
       {
        
       } 
       if (key == 'd')
       {
        
       } 
     }//end if keyPressed
     
   }
   
   void render()
   {
     //position taken from snakeX and snakeY will determine the snakes position, length, etc
   }
   
}