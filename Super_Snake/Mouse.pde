class Mouse extends GameObjects //implements Powerup
{
  
  void update()
  {
    d = (int) dist(snakeX.get(0),snakeY.get(0),PUMouseX,PUMouseY);
    
    if(d <= 3)
    {
      frightened();
    }
  }
  
  void render()
  {
    fill(mouseCol);
    stroke(mouseLine);
    rect(PUMouseX*PUSize,PUMouseY*PUSize,PUSize,PUSize,PUCurv);
  }
  
  void CheckDeath()
  {
    if(snakeX.get(0) == PUMouseX && snakeY.get(0) == PUMouseY)
    {
      println("m eaten");
      snake.score+=3;
      
      //snakeX.add(0,PUMouseX + dir_horiz);
      //snakeY.add(0,PUMouseY + dir_vertic);
      snakeX.add(snakeX.size()-1,PUMouseX);
      snakeY.add(snakeX.size()-1,PUMouseY);
      
      PUMouseX = (int) random(0,(initWidth/PUSize));
      PUMouseY = (int) random(0,(initWidth/PUSize));
    }
  }
  
  
  void frightened()
  {
    //sound_squeek.play();
    //println("squeek!");
    
    //code for making the mouse shake
  }
}