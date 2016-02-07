class Mouse extends GameObjects
{
  
  void update()
  {
    d = dist(snakeX.get(0),snakeY.get(0),PUMouseX,PUMouseY);
    
    if(d <= 3)
    {
      frightened();
    }
    
  }
  
  void render()
  {
    fill(mouseCol);
    rect(PUMouseX*PUSize,PUMouseY*PUSize,PUSize,PUSize,PUCurv);
  }
  
  void CheckDeath()
  {
    if(snakeX.get(0) == PUMouseX && snakeY.get(0) == PUMouseY)
    {
      score+=2;
      PUMouseX = (int) random(0,(initWidth/snakeSize));
      PUMouseY = (int) random(0,(initWidth/snakeSize));
    }
  }
  
  
  void frightened()
  {
    //sound_squeek.play();
    println("squeek!");
    
    //code for making the mouse shake
  }
}