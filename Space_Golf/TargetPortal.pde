//THE CLASS FOR THE TARGET THAT THE PLAYER IS GOING TOWARDS
class TargetPortal
{
  PVector position = new PVector(0, 0);
  int radius = 0;
  float rotationCounter = 0.0f;
  PImage texture;
  
  //The constructpor
  TargetPortal(PVector posit, int rad)
  {
    position = posit;
    radius = rad;
    texture = loadImage("Vortex.png");
    resize(50,50);
  }
  
  //The display to print out the target
  void display()
  {
    rotationCounter++;
    
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotationCounter*PI/60);
    image(texture,0, 0);    
    popMatrix();
  }
}
