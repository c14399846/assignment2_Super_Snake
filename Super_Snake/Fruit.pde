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
    fill(255);stroke(255);
    rect((PUFruitX*PUSize),(PUFruitY*PUSize),PUSize/3,PUSize/3,PUCurv);
    fill(cherryCol);stroke(cherryLine);
    strokeWeight(3);
    line((PUFruitX*PUSize) + (PUSize*0.5),PUFruitY*PUSize,(PUFruitX*PUSize) + PUSize,(PUFruitY*PUSize)-(PUSize*0.5));
    strokeWeight(1);
  }
  
  void CheckDeath()
  {
    if(snakeX.get(0) == PUFruitX && snakeY.get(0) == PUFruitY)
    {
      cherry.applyTo((snake));
      
      PUFruitX = (int) random(0,(initWidth/PUSize));
      PUFruitY = (int) random(0,(initHeight/PUSize));
      
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
        PUFruitY = (int) random(0,(initHeight/PUSize));
      }
    }
  }
  
  
}