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
      score++;
      
      //adds size to snake, but leaves some strange artifact
      snakeX.add(snakeX.size()-1, 1);
      snakeY.add(snakeY.size()-1, 1);
      
      
      PUFruitX = (int) random(0,(initWidth/PUSize));
      PUFruitY = (int) random(0,(initWidth/PUSize));
    }
  }
  
}