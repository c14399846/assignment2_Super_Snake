class Mouse extends GameObjects implements Powerup
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
      mouse.applyTo(snake);
      //snakeX.add(0,PUMouseX + dir_horiz);
      //snakeY.add(0,PUMouseY + dir_vertic);
      
      PUMouseX = (int) random(0,(initWidth/PUSize));
      PUMouseY = (int) random(0,(initWidth/PUSize));
    }
  }
  
  void applyTo(Snake snake)
  {
    println("m eaten");
    snake.score += 3;
    snake.eaten = true;
  }
  
  void frightened()
  {
    //sound_squeek.play();
    //println("squeek!");
    
    //code for making the mouse shake
  }
}