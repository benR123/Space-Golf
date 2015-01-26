//THE MAIN CLASS
//Creating an instance of the player class
SpaceShip player;
TargetPortal portal;

//Creating  array lists for the planets to be stored in
//Each array list pertains to a specific level
ArrayList <Planets> planetsLev1 = new ArrayList<Planets>();
ArrayList <Planets> planetsLev2 = new ArrayList<Planets>();
ArrayList <Planets> planetsLev3 = new ArrayList<Planets>();

//An array list that will hold the trail that follows the ship
ArrayList <Trail> shipTrail = new ArrayList<Trail>();
//A time that sets up how often the trail shows
int trailTimer = 0;
boolean continLoop = false;

//controls the pause affect
boolean pause; 

//Bolleans to determine which level should be played
boolean isLev1 = false;
boolean isLev2 = false;
boolean isLev3 = false;
//The int for the player's score and the timer that decriments the score
int scoreCounter = 60;
int score = 1000;
//setting up the boost penalty
final int BOOST_PENALTY = 75;

//The timer to be used for the player respawn
int respawnCounter = 60;

//death number
int deaths = 0;

boolean titleScr = true;

//setting up the planet's texture
PImage planetTexture;

//Title and end screen font
PImage title;

//The boolean to determine if the hard mode should be displayed
boolean hardMode = false;


//The setup method. initializes all of the main classes stuff
void setup()
{
  //Setting the size of the screen
    size(1500, 800, P2D);
    //bringing ni the planet's texture
    planetTexture = loadImage("Planet.png");
    title = loadImage("titleFinal.png");
    
    
    //Creating the player instance and placing it in the actual position (CHANGE LATER)
    player = new SpaceShip(new PVector(100, height/2));
    portal = new TargetPortal(new PVector(1400, 200), 75);
    
    //The array list for the planets on the first level
    planetsLev1.add(new Planets(new PVector(400, 150), 18));
    planetsLev1.add(new Planets(new PVector(800, 650), 18));
    planetsLev1.add(new Planets(new PVector(1150, 150), 18));
    
    //The array list for the planets on the second level
    planetsLev2.add(new Planets(new PVector(200, 150), 10));
    planetsLev2.add(new Planets(new PVector(400, 550), 12));
    planetsLev2.add(new Planets(new PVector(750, 650), 15));
    planetsLev2.add(new Planets(new PVector(575, 250), 10));
    planetsLev2.add(new Planets(new PVector(850, 100), 12));
    planetsLev2.add(new Planets(new PVector(1150, 200), 11));
    planetsLev2.add(new Planets(new PVector(1000, 500), 10));
    planetsLev2.add(new Planets(new PVector(1300, 700), 10));
    planetsLev2.add(new Planets(new PVector(1350, 400), 10));
    
    //The array list for the third level
    planetsLev3.add(new Planets(new PVector(150, 150), 10));
    planetsLev3.add(new Planets(new PVector(250, 650), 15));
    planetsLev3.add(new Planets(new PVector(400, 200), 11));
    planetsLev3.add(new Planets(new PVector(450, 400), 8));
    planetsLev3.add(new Planets(new PVector(650, 225), 7.5));
    planetsLev3.add(new Planets(new PVector(650, 650), 8));
    planetsLev3.add(new Planets(new PVector(700, 75), 7));
    planetsLev3.add(new Planets(new PVector(975, 400), 17));
    planetsLev3.add(new Planets(new PVector(1050, 50), 10));
    planetsLev3.add(new Planets(new PVector(1200, 750), 13));
    planetsLev3.add(new Planets(new PVector(1350, 550), 10));
    planetsLev3.add(new Planets(new PVector(1300, 275), 12));
    
    
}

//methods looking for key presses to send information on rotation back to the SpaceShip class
void keyReleased()
{
  //checking for key presses.
 if(key == CODED)
 {
   if(keyCode == RIGHT)
   {
     //sets RIGHT boolean in SpaceShip
     player.right = false;
   }
   else if(keyCode == LEFT)
   {
     //sets LEFT boolean in SpaceShip
     player.left = false;
   }
   else if(keyCode == UP)
   {
     //sets LEFT boolean in SpaceShip
     player.boost = false;
     
     //Each press of the boost, the score decriments
     if(pause == false && player.gameWon == false)
     {
       if(score > 0)
       {
         score -= BOOST_PENALTY;
       }
       else
       {
         score = 0;
       }
     }    
   }
 }
}

void keyPressed()
{
  //Controls
 if(keyCode == RIGHT)
  {
    player.right = true;
  } 
  else if(keyCode == LEFT)
  { 
    player.left = true; 
  }
  else if(keyCode == UP)
  {
    //sets LEFT boolean in SpaceShip
    player.boost = true;   
  }
  else if(keyCode == SHIFT)
  {
    //The player can toggle the hardmode with the shift key
    if(hardMode == true)
    {
      hardMode = false;
    }
    else
    {
      hardMode = true;
    }
  }
  else if(keyCode == 'M')
  {
    //When the user is paused and presses M, the game will return to the main menu
    if(pause == true)
    {
      titleScr = true;
      player.gameWon = false;
      score = 1000;
      deaths = 0;
      player.restart();
    }
  }
  else if(keyCode == ENTER)
  {
    //Pressing ENTER after winning the level, the game will return to the main menu
    if(player.gameWon == true)
    {
      imageMode(CORNER);
      titleScr = true;
      player.gameWon = false;
      score = 1000;
      deaths = 0;
      player.restart();
    }
  }
  //Pickibng the level to play on
  else if(keyCode == '1')
  {
    if(titleScr == true)
    {
      titleScr = false;
      hardMode = false;
      pause = false;
      isLev1 = true;
      isLev2 = false;
      isLev3 = false;
    }
  }
  else if(keyCode == '2')
  {
    if(titleScr == true)
    {
      titleScr = false;
      hardMode = false;
      pause = false;
      isLev1 = false;
      isLev2 = true;
      isLev3 = false;
    }
  }
  else if(keyCode == '3')
  {
    if(titleScr == true)
    {
      titleScr = false;
      hardMode = false;
      pause = false;
      isLev1 = false;
      isLev2 = false;
      isLev3 = true;
    }
  }
 //looking for pause botton 
  else if(key == 'p' && player.gameWon != true) // checks if p has been pressed and if game is paused
  {
    if(pause == false)
    {      
     pause = true;
    }
    else
    {
      pause = false;
    }
  }
  //Pressing Q will exit the game
  else if(keyCode == 'Q')
  {
    if(player.gameWon == true || pause == true)
    {
      exit();
    }
  }
}

//Calling the display for all of the planets
void showLevelPlanets(ArrayList <Planets> currentLevel)
{
  //Calling the display for all of the planets
  for(Planets planBodies: currentLevel)
  {           
    if(hardMode == false)
    {
      //display of the gravity field.
      ellipseMode(CENTER);
      strokeWeight(0);
      fill(50, 255, 155, 126);
      ellipse(planBodies.planetCenter.x, planBodies.planetCenter.y, planBodies.gravField, planBodies.gravField);
    }    
    planBodies.display();
  }
  strokeWeight(2);
}

//For each planet, calculate the force of gravity to be applied to the player
void checkAllPlanetsCollis(ArrayList <Planets> currentLevel)
{
  for(Planets planBodies: currentLevel)
  {
    if(planBodies.InsideGravField(player)) //only applies the force if the player is inside the gravitational field
    {
      PVector force = planBodies.attract(player);     //Setting up the force of gravity
      player.applyForce(force);    //applying the resulting force
      
      if(player.planetCollision(planBodies))
      {
        player.alive = false;
      }
    }
  }
}

//the pause method//makes the correct settings for pause mode 
void pause()
{
    fill(0, 0, 0, 200);
    rect(0,0,width,height);
    fill(255);
    textSize(70);
    text("Paused", width/2 - 125, 90);
    textSize(50);
    text("Press M to return to the Main Menu", width/2 - 425, 180);
    text("Press P to return to the game", width/2 - 370, 265);
    text("Press Q to quit the game", width/2 - 425, 350);
}

//The update method
void draw()
{
  //title screen displays first:
  if(titleScr == true)
  {
    background(0);
    
    fill(255);
    //Loading the tital screen
    image(title, 0, 0);
  }
  
  if(titleScr == false)
  {
    //Setting the color of the background to black
    background(0);
      
    if(isLev1 == true)
    {
      showLevelPlanets(planetsLev1);
    }
    else if(isLev2 == true)
    {
      showLevelPlanets(planetsLev2);
    }
    else if(isLev3 == true)
    {
      showLevelPlanets(planetsLev3);
    }
  
    //Draw the portal
    portal.display();
  
    //here's the start of a VERY large if statement
      // checks is game is paused
     if(pause)
      {
       player.display();
       fill(255);
        textSize(25);
        text("Score: " + score, width - 150,  40);
        text("Deaths: " + deaths, width - 290, 40);
        pause();
      }
  
  else
 {
  
    //The game only plays if the player hasn't won (the win bool is false)
    if(player.gameWon == false)
    {
      //The score timer (counter) drops to 0 after 60 1/60ths of a second (the score drops after one second)
      if(scoreCounter > 0)
      {
        scoreCounter--;
      }
      //The score decriments if the counter drops to 0 and counter resets
      else
      {
        scoreCounter = 60;
        if(score > 0)
        {
          score--;
        }
        else
        {
          score = 0;
        }
      }
      //Writing out the player's score and placing it in the top right score
      fill(255);
      textSize(25);
      text("Score: " + score, width - 150,  40);
      text("Deaths: " + deaths, width - 290, 40);
      //printing the cool down time for booster
      text("BoostCooldown: " + player.boostCooldown, 50, 40);            
    
      //If the player is dead (.alive == false)
      if(player.alive == false)
      {
        //Removed (effectively restarting) the trails
        for(int i = 0; i < shipTrail.size(); i++)
        {
          shipTrail.remove(i);
        }
        //just like the score counter, when the respawn counter drops to 0 after 1 second 
        if(respawnCounter == 0)
        {
          respawnCounter = 60;
          player.restart();
          score = 1000;
          deaths++;
        }
        else
        {
          respawnCounter--;
        }  
      }  
      //The rest of the in game draw function (until game over) executes while the player is alive
      else
      {    
       if(isLev1 == true)
       {
         checkAllPlanetsCollis(planetsLev1); 
       }
       else if(isLev2 == true)
       {
         checkAllPlanetsCollis(planetsLev2); 
       }
       else if(isLev3 == true)
       {
         checkAllPlanetsCollis(planetsLev3); 
       }              
      //If the score drops to 0, the player dies
      if(score <= 0)
      {
        player.alive = false;
      } 
      
      //must update with new information from the SpaceShip class
      player.movementUpdate();
      //Calling the player's target collision method
      player.targetCollision(portal);
      
      if(player.boost == true)
      {
        //Creating the trail to follow the player
        for(int i = 0; i < 11; i++)
        {
          //Evey 25 calls, a new trail piece will be created    
          if(trailTimer > 25)
          {
            shipTrail.add(new Trail(player.center.x, player.center.y));
            trailTimer = 0;
          }
          else
          {
            trailTimer++;
          }
        }
      }

      //Calling the fade and display function for every peice in trail
      for(int i = 0; i < shipTrail.size(); i++)
      {
        shipTrail.get(i).fade();
        
        //The array peice is removed if its remove bol is true
        if(shipTrail.get(i).remove == true)
        {
          shipTrail.remove(i);
        }
        else
        {
          shipTrail.get(i).display();
        }
      }
      player.display();
    }
  }
  else
  {
    //Removed (effectively restarting) the trails
    for(int i = 0; i < shipTrail.size(); i++)
    {
      shipTrail.remove(i);
    }   
    //Calling the game won screen
    background(0);
    
    //Printing out the text and placing it in the screen
    fill(255);
    textSize(100);
    text("LEVEL COMPLETED", width/2 - 450, 230);
    textSize(75);
    text("Your Final Score is: " + score, width/2 - 435, height/2);
    text("Number of Deaths: " + deaths, width/2 - 375, height/2 + 110);
    text("Press ENTER to restart the game", 175, height/2 + 225);
    text("Press 'Q' to quit the game", width/2 - 465, height/2 + 335);
    
  }
}
}// end of the if's ELSE statement with pause
}
