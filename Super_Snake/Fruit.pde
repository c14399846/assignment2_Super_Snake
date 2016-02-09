class Fruit extends GameObjects implements Powerup
{
  
  color cherryCol;
  color cherryLine;
  
  Fruit()
  {
    this.cherryCol = color(200,0,0);
    this.cherryLine = color(0,175,0);
  }
  
  void update()
  {
    
  }
  
  void render()
  {
    fill(cherryCol);
    stroke(cherryLine);
    rect(PUFruitX*PUSize,PUFruitY*PUSize,PUSize,PUSize,PUCurv);
    strokeWeight(3);
    //line();
    //line();
    strokeWeight(1);
  }
  
  void CheckDeath()
  {
    if(snakeX.get(0) == PUFruitX && snakeY.get(0) == PUFruitY)
    {
      cherry.applyTo((snake));
      //snakeX.add(0,PUFruitX + dir_horiz);
      //snakeY.add(0,PUFruitY + dir_vertic);

      
      PUFruitX = (int) random(0,(initWidth/PUSize));
      PUFruitY = (int) random(0,(initWidth/PUSize));
      
      cherry.checkCollisions();
    }
  }
  
  void applyTo(Snake snake)
  {
    snake.score ++;
    snake.fPU ++;
    snake.eaten = true;
  }
  
  //checks for fruit spawning on snake body
  void checkCollisions()
  {
    for(int i = 0;i<snakeX.size();i++)
    {
      if(PUFruitX == snakeX.get(i) && PUFruitY == snakeX.get(i))
      {
        PUFruitX = (int) random(0,(initWidth/PUSize));
        PUFruitY = (int) random(0,(initWidth/PUSize));
      }
    }
  }
  
  
}