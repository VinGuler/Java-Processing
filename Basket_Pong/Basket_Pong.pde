// Instances of players
Player left;
Player right;

// Players' width and height (Should be identical...)
float pW, pH;

// Instance of the ball
Ball ball;

// Players movement(UP / DOWN) speed
// Picked after some trials
int speed = 7;

void setup(){
  // Best window size for the game
  // width = (2/3) * height
  size(900, 600);
  
  // What I find to be right, can easily be subjected to screen width/height
  pW = 20;
  pH = 80;
  
  // Initializing Players and Ball, see CONSTRUCTORs in classes
  left = new Player(true, pW, pH);
  right = new Player(false, pW, pH);
  ball = new Ball(1);
}

void draw(){
  background(0);
  
  // Drawing the playground
  // Background graphics
  stroke(255);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  fill(0);
  ellipse(width/2, height/2, width/3, width/3);
  
  // Showing the score for each player above their side in the field
  fill(255);
  textSize(20);
  text(left.score, width/4, 50);
  text(right.score, width-width/4, 50);
  
  // Showing and updating both players
  // See Player class
  left.update();
  left.show();
  right.update();
  right.show();
  
  // Checking if the Ball hit either of the players
  // See Ball class
  ball.checkHit(right);
  ball.checkHit(left);
  
  // Checking the current score for display
  checkScore();
  
  // Updating and showing the ball
  // See Ball class
  ball.update();
  ball.show();
  
}

// Checking whether the Ball hit any of the sides
// Each side is a Goal
// If scoring, the Ball reappears in the center, directing the losing Player
// See Player and Ball classes for the functions in here
void checkScore(){
  // If Left Player scored
  if(ball.lScored){
    left.addScore();
    ball = new Ball(1);
  // If Right Player scored
  } else if(ball.rScored){
    right.addScore();
    ball = new Ball(-1);
  }
}

// Controlling the players:
/*
  DOWN / UP -> Right Player
  's' / 'w' -> Left Player
*/
void keyPressed(){
  int keyC = keyCode;
  switch (keyC) {
    case UP:
      right.move(-speed);
      break;
    case DOWN:
      right.move(speed);
      break;
    case 87:
      left.move(-speed);
      break;
    case 83:
      left.move(speed);
      break;
  }
}

// This is needed for a fluent movement
/*
  Since there is no 'keyHeld' function, 
  the players keep moving until the key is released 
*/
void keyReleased(){
  int keyC = keyCode;
  switch (keyC) {
    case UP:
      right.move(0);
      break;
    case DOWN:
      right.move(0);
      break;
    case 87:
      left.move(0);
      break;
    case 83:
      left.move(0);
      break;
  }
}