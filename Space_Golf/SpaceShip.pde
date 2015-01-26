//THE PLAYER CONTROLLED OBJECT THAT MOVES
class SpaceShip
{
  //The PShape that will form the body later
  PShape body;
  //The center to be used for positioning
  PVector center = new PVector(0, 0);
  PVector spawnPoint = new PVector(100, height/2);
  
  PVector boostVector = new PVector(0, 0); 
  PVector direction = new PVector(0, 0); 
  PVector velocity = new PVector(0, 0);
  PVector resulting = new PVector(0,0); 
  PVector acceleration = new PVector(0,0);
  
  boolean alive;
  boolean gameWon = false;
  float speed = 0;
  
  //setting up boost cool down and limiter
  float boostCooldown;
  final float BOOST_TIMER = 15;
  final float BOOST_THRUST = 10;
  final float TOP_SPEED= 6.3;
  
  //Booleans: checking for KEYRELEASED to rotate the body left and right
  boolean right = false;
  boolean left = false;
  boolean boost = false;
  
  //images
  PImage shippic;
  
  //The constructor
  SpaceShip(PVector startPosit)
  {
    alive=true;
    center = startPosit;
    
    //loading in the images/textures
    shippic = loadImage("Images/spaceship.png");
    
    PVector.fromAngle(radians(-90), direction);
    PVector.fromAngle(radians(-90), boostVector);
    
  }
  
  void movementUpdate()
  {
    //checking for booster movement/use
    if(boostCooldown < BOOST_TIMER && !boost)
    {
      boostCooldown++;
    }
    
    //updates left and right booleans from KEYRELEASED events in "Space_Golf"
    if(right)
    {
     direction.rotate(.1);
    }
    
    if(left)
    {
     direction.rotate( -.1);
    }
    
    //this statement changed to include a check for the boost coolDown
    if(boost && boostCooldown == BOOST_TIMER)
    {
      speed = BOOST_THRUST;
      boostCooldown = 0;
    }
    else
    {
      if(speed > 0)
      {
        speed--;
      }
    }
    
    //Calculating the boost vector
    boostVector = PVector.mult(direction,speed);
    
    //Calculating the resulting vector, getting the previous velocity vector and adding to it the boost vector.
    resulting= PVector.add(boostVector, velocity);
    
    //Adding to the resulting speed to the acceleration provided from the planets gravity
    resulting.add(acceleration);
    
    
    //The current velocity vector is equals to the calculated resulting vector.
    velocity = resulting;
    acceleration.mult(0);    // set the acceleration to zero for the next update
    
    //Checking for the top speed
    if(velocity.mag() > TOP_SPEED)
    {
      velocity.normalize();
      velocity = PVector.mult(velocity, TOP_SPEED);
    }
 
    center.add(velocity);
  
    bordersCollisions();
  }
  
  void restart()
  {
    center.x = 100;
    center.y = height/2;
    //center = spawnPoint;
    PVector.fromAngle(radians(-90), direction);
    PVector.fromAngle(radians(-90), boostVector);
    velocity.mult(0);
    //added for boost check
    acceleration.mult(0);
    boostCooldown = BOOST_TIMER;
    speed = 0;
    
    
    alive=true;
  }
  
  //Checking for collisions with the borders of the screen
  void bordersCollisions()
  {
    if(center.x < 0)
    {
      //center.x = 0;
      alive = false;
    }
    
    if(center.y < 0)
    {
      //center.y = 0;
      alive = false;
    }
    
    if(center.x > width)
    {
      //center.x = width;
      alive = false;
    }
    
    if(center.y > height)
    {
      //center.y = height;
      alive = false;
    }
     
  }
  
  boolean planetCollision(Planets planet)
  {
    if(PVector.sub(center,planet.planetCenter).mag() <= planet.radius /2)
    {
      return true;
    }
    else
    {
      return false;
    }        
  }
  
  //The method for handling victory collision
  void targetCollision(TargetPortal endTarget)
  {
    //Getting the distance of the target to the player
    //If the they are too close, the game is won
    if(PVector.sub(center, endTarget.position).mag() <= endTarget.radius)
    {
      gameWon = true;
    }
    else
    {
      gameWon = false;
    }
  }
  
  void applyForce (PVector force)
  {
    //PVector applied = PVector.div(force,10);
    acceleration.add(force);
  }
  
  //Display
  void display()
  {
    //Calling the createBody method, then drawing the created shape
    pushMatrix();
    translate(center.x, center.y);
    rotate(direction.heading());
    image(shippic, 0, 0); /////////////////////////////new
    shippic.resize(50,0);
    //shape(body);
    popMatrix();
  }
}
  
  
