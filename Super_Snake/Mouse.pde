class Mouse extends GameObjects implements Powerup
{
  color mouseCol;
  color mouseLine;
  color mouseNose;
  float d;
  int passed;//if snake is nearby mouse
  
  Mouse()
  {
    this.mouseCol = color(100);
    this.mouseLine = color(0);
    this.mouseNose = color(255,192,203);
    this.passed = 0;
  }
  
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
    stroke(255);
    rect((PUMouseX*PUSize) - (PUSize/4) ,(PUMouseY*PUSize) -(PUSize/4),PUSize/3,PUSize/3,PUCurv);
    rect((PUMouseX*PUSize)+(PUSize*0.9) ,(PUMouseY*PUSize) -(PUSize/4),PUSize/3,PUSize/3,PUCurv);
    fill(mouseNose);
    stroke(mouseNose);
    rect((PUMouseX*PUSize) + (PUSize/3) , (PUMouseY*PUSize) + (PUSize/3) , PUSize/3, PUSize/3,PUCurv);
  }
  
  void CheckDeath()
  {
    if(snakeX.get(0) == PUMouseX && snakeY.get(0) == PUMouseY)
    {
      mouse.applyTo(snake);
      
      PUMouseX = (int) random(0,(initWidth/PUSize));
      PUMouseY = (int) random(0,(initWidth/PUSize));
      
      mouse.checkCollisions();
    }
  }
  
  void applyTo(Snake snake)
  {
    snake.score += 3;
    snake.mPU++;
    snake.eaten = true;
  }

  
  void frightened()
  {
    //will play sound if in range 3 times in a row, with a second interval per check
    if(passed==3)
    {
      sound_squeek.rewind();
      println("squeek!");
      sound_squeek.play();
      passed = 0;
    }
    
    if(frameCount % 60 == 0)
    {
      passed++; 
    }
  }
  
  //checks for mouse spawning on snake body
  void checkCollisions()
  {
    for(int i = 0;i<snakeX.size();i++)
    {
      if(PUMouseX == snakeX.get(i) && PUMouseY == snakeX.get(i))
      {
        PUMouseX = (int) random(0,(initWidth/PUSize));
        PUMouseY = (int) random(0,(initWidth/PUSize));
      }
    }
  }
}//end class