class Snake extends GameObjects
{
   PVector pos;
   PVector moveX;
   PVector moveY;
   int difficulty; // MIGHT BE CHANGED TO OTHER CLASS/FUNCTION, OR DELETED ALTOGETHER
   
  Snake()
  {
      //this(initWidth/2,initHeight/2); 
  }
   
   Snake(int x,int y)
   {
     pos = new PVector(snakeX.get(0),snakeY.get(0));
     moveX = new PVector();//need to figure out how to do fourway movement *****
     moveY = new PVector();
   }
   
   void update()
   {
     //need to add movement code here first
     
     rect(pos.x,pos.y,snakeSize,snakeSize);
     //keypressed is initially used, as you only want one key to be pressed at a time
     //might change to other key system, depending on gameplay
     
     /*can do bool system for this
     
     while(!keyPress)
     {
       check for keypresses
     }
     
     otherwise dont allow for keypress
     
     or
     
     if(!keyPress)
     {
      if key = w
      {
       do code
       keyPress = true;
       exit if or switch,etc
       
       theta = pi or theta = 1, theta = 0.5 *********,
       give theta its own value depending on the key that is pressed, have the movement be executed in a function or
       inside of the swithc or whatever statements is used
      }
      etc 
      etc
     }
     */
     
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