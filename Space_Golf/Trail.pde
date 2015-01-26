//THE CLASS FOR THE TRAIL THAT FOLLOWS THE PLAYER 
class Trail
{
  //PVector for the position;
  float positX;
  float positY;
  
  //floats for the alpha and the size
  float transparency;
  float size;
  
  //bool to determin if it should be removed
  boolean remove;
  
  //Constuctor class
  Trail(float positionX, float positionY)
  {
    //Assigning values to the attributes
    positX = positionX;
    positY = positionY;
    transparency = 255;
    size = 10;
    remove = false;
  }
  
  //The method to make the trail grow and fade
  void fade()
  {
    //The trail will only grow when it is still visible
    if(remove != true)
    {
      if(transparency > 3)
      {
        transparency = transparency - 7;
        size = size + 3;
      }
      //Otherwise it will be removed
      else
      {
        remove = true;
      }
    }
  }
  
  void display()
  {
    strokeWeight(0);
    //The trail will only show while it is still not eligable for removal
    if(remove == false)
    {
      fill(255, 100, 0, transparency);
      ellipse(positX, positY, size, size);
    }
    strokeWeight(2);
  }
}
