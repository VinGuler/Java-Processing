/*
A nice animation inspired by Daniel Shiffman (aka The Coding Train/Rainbow).
I was inspired after watching a tutorial on YouTube about Inverse Kinematics.

The system is controlled by dragging the mouse, otherwise moves freely.
Press 's' - Toggle visibility of the snake.
Press 'c' - Toggle visibility of the creatures (tentacles).
*/

// Snake
Snake snake;

// Array of arms (creatures)
Creature[] creatures;

// This object controls the movement of the System
Movable mvbl;

// How many creatures to create
int amnt;

// Check whether the is being dragged
// If TRUE the snake will follow the mouse
boolean useM;

// Whether to show parts of the System
boolean showSnake;
boolean showCreatures;

// Starting Values for the creatures and snake system
// Since those are the same for Both the 
PVector startingPosition;
PVector startingVelocitiy;

// Tentacles amount and len for each creature
int prts;
float ln;

void setup(){
  size(800, 800);
  
  // Calculating amount of parts as (screenDiagonal / lengthOfParts)
  ln = 10;
  prts = floor(sqrt((width*width) + (height*height)) / ln);
  
  // amount of creatures has to be divisable by 4
  amnt = 60;
  
  // Starting values for the system
  startingPosition = new PVector(width/2, height/3);
  startingVelocitiy = new PVector(4, 4);
  
  // In the begining the system won't follow the mouse
  useM = false;
  
  // Showing the whole System in the begining
  showSnake = true;
  showCreatures = true;
  
  // Creating the Movable
  mvbl = new Movable(startingPosition, startingVelocitiy);
  
  // Creating the Snake(amountOfParts, lengthOfParts)
  snake = new Snake(15, 25);
  
  // Initializing the creatures Array
  creatures = new Creature[amnt];
  
  // Calculating the amount of creatures on each side of the window
  int side = floor(amnt/4);
  
  // Creating creatures and populating the creatures Array
  for(int i=0; i<amnt; i++){
    creatures[i] = createCreature(i, side);
  }
}

void draw(){
  
  background(0);
  
  // When the mouse btn is pressed, The snake will follow the curser
  if(mousePressed){
    useM = true;
  }
  
  // Showing the creatures - following the mouse if dragged
  // If mouse not dragged following the mvbl
  if(showCreatures){
    for(Creature c : creatures){
      if(useM){
        c.show(mouseX, mouseY);
      } else {
        c.show(mvbl.pos.x, mvbl.pos.y);
      }
    }
  }
  
  // Showing the snake - following the mouse if dragged
  // If mouse not dragged following the mvbl
  if(showSnake){
    if(useM){
      snake.show(mouseX, mouseY);
    } else {
      snake.show(mvbl.pos.x, mvbl.pos.y);
    }
  }
  
  // Moving the System when it's not focused on the curser
  if(!useM){
    // Updating the mvbls' location
    mvbl.update();
    // Calculating what to do when hitting the edge
    mvbl.hitEdge();
  } else {
    // Setting mvbls' location on the mouse when its' dragged
    mvbl.setLoc(mouseX, mouseY);
  }
  // Showing the Movable (the systems movement obj when mouse is not pressed
  mvbl.show();
}

// Releasing the mouse sets the System free from the curser
void mouseReleased(){
  useM = false;
  mvbl.pos.x = mouseX;
  mvbl.pos.y = mouseY;
}

// Keys ;)
void keyPressed(){
  // Controlling the visibility of parts of the System
  if(key == 's'){
    if(showSnake){
      showSnake = false;
    } else {
      showSnake = true;
    }
  }
  if(key == 'c'){
    if(showCreatures){
      showCreatures = false;
    } else {
      showCreatures = true;
    }
  }
}

// This function creates creatures //
Creature createCreature(int i, int side){
  // Location of each creatures' basePosition (on the edges)
  PVector base;

  // Width and Height of the creature
  float w = width;
  float h = height;
  
  // This creates creatures on the BOTTOM of the screen
  // From LEFT To RIGHT
  if(i<=side){
    base = new PVector(i*(w/side), h);
    return new Creature(base, prts, ln);
  } 
  // This creates creatures on the RIGHT side of the screen
  // From TOP To BOTTOM
  else if(i>side && i<2*side){
    base = new PVector(w, (i%side)*(h/side));
    return new Creature(base, prts, ln);
  }
  // This creates creatures on the TOP of the screen
  // From LEFT To RIGHT
  else if(i>2*side && i<=3*side){  
    base = new PVector(((i%side)+1)*(w/side), 0);
    return new Creature(base, prts, ln);
  } 
  // This creates creatures on the LEFT side of the screen
  // From Top To BOTTOM
  else {   
    base = new PVector(0, (i%side)*(h/side));
    return new Creature(base, prts, ln);
  }
}