class Mouse extends GameObjects implements Powerup
{
  color mouseCol;
  color mouseLine;
  float d;
  int passed;
  
  Mouse()
  {
    this.mouseCol = color(100);
    this.mouseLine = color(0);
    this.passed = 0;
  }
  
  void update()
  {
    d = (int) dist(snakeX.get(0),snakeY.get(0),PUMouseX,PUMouseY);
    
    if(d <= 3)
    {
      frightened();
    }
    
    checkCollisions();
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
      
      timer();
      
      PUMouseX = (int) random(0,(initWidth/PUSize));
      PUMouseY = (int) random(0,(initWidth/PUSize));
    }
  }
  
  void applyTo(Snake snake)
  {
    println("m eaten");
    snake.score += 3;
    snake.mPU++;
    snake.eaten = true;
  }
  
  void timer()
  {
    
  }  
  
  void frightened()
  {
    /*
    need to do time based, or else it will keep repeating
    if(passed==3)
    {
      println("squeek!");
      //sound_squeek.play();
      passed = 0;
    }
    
    
    passed++;
    
    */
    
    //code for making the mouse shake
  }
  
  //checks for mouse spawning on snake body
  void checkCollisions()
  {
    for(int i = 1;i<snakeX.size();i++)
    {
      if(PUMouseX == snakeX.get(i) && PUMouseY == snakeX.get(i))
      {
        PUMouseX = (int) random(0,(initWidth/PUSize));
        PUMouseY = (int) random(0,(initWidth/PUSize));
      }
    }
  }
}