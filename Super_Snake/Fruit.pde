class Fruit extends GameObjects //implements Powerup
{
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
      println("f eaten");
      snake.score++;
      
      //snakeX.add(0,PUFruitX + dir_horiz);
      //snakeY.add(0,PUFruitY + dir_vertic);
      
      snakeX.add(snakeX.size()-1,PUFruitX);
      snakeY.add(snakeX.size()-1,PUFruitY);
      
      PUFruitX = (int) random(0,(initWidth/PUSize));
      PUFruitY = (int) random(0,(initWidth/PUSize));
    }
  }
  
  
  
  /*void applyTo(Snake snake)
  {
    snake.score++;
    snakeX.add(snakeX.size()-1, 1);
    snakeY.add(snakeY.size()-1, 1);
  }*/
  
  
}