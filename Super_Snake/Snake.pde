class Snake extends GameObjects
{
   PVector pos;
   PVector move;
   int difficulty; // MIGHT BE CHANGED TO OTHER CLASS/FUNCTION, OR DELETED ALTOGETHER
   
   Snake(int x,int y)
   {
     pos = new PVector(x,y);
     move = new PVector();//need to figure out how to do fourway movement *****
   }
   
}