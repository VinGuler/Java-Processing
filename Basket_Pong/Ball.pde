class Ball{
  // Balls' position, velocity and gravity
  PVector pos;
  PVector vel;
  PVector grv;
  // Gravity can be a float, but I'd like to keep it as a vector
  // incase I have a new idea, and it also makes more sense to me
  
  // Booleans to check whether RightPlayerScored or LeftPlayerScored
  boolean rScored;
  boolean lScored;
  
  // Balls' radius
  float r;
  
  /*
    This is used to change the gravity
    and make it stronger (down) every time a Player hits the ball.
    Makes the game more interesting
  */
  float grvChange = 0.02;
  
  // CONSTRUCTOR
  // Recieve the direction of the movement of the Ball
  // -1 goes left / +1 goes right
  Ball(int dir){   
    /*
      Setting balls': 
      position = (width/2, height/2)
      velocity = (x=5*direction, y=5)
      gravity = (x=0, y=0.2)
    */
    pos = new PVector(width/2, height/2);
    vel = new PVector(5 * dir, 5);
    grv = new PVector(0, 0.2);
    
    // Setting balls' Radius
    r = 15;
    
    // No player has yet scored when the ball is created
    // Basically initializing this variables
    rScored = false;
    lScored = false;
  }
  
  // Showing the Ball
  // GRAPHICS
  void show(){
    stroke(255);
    strokeWeight(2);
    fill(200, 100, 0);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  // Updating the location of the Ball
  /*
    Adding velocity to the postion for movement
    Adding gravity to velocity for acceleration (towards bottom)
    Checking whether the edges(TOP|BOTTOM)
    Checking if a Player scored edges(LEFT|RIGHT)
  */
  void update(){
    pos.add(vel); 
    vel.add(grv);
    edges();
    score();
  }
  
  // A Simple edge hit check (TOP|BOTTOM)
  void edges(){
    if(pos.y > height-r){  
      // Setting pos.y like this avoids getting stuck
      pos.y = height - r;
      vel.y *= (-1);
    }
    if(pos.y < r){
      // Setting pos.y like this avoids getting stuck
      pos.y = r;
      vel.y *= (-1);
    }
  }
  
  // A Simple edge hit check (LEFT|RIGHT)
  // These are the Goals
  /*
    This called in the main loop,
    to check if a Player scored, and if so who?
    This is needed to distinguish between the players
  */
  void score(){
    if(pos.x+r > width){
      lScored = true;
    } else if(pos.x-r < 0){
      rScored = true;
    }
  }
  
  /*
    Changing the gravity of the ball if it hits a Player.
    This makes the game more interesting, fun, and challenging.
    Notice I change grvChange direction (+,-), otherwise the gravity would go nuts.
  */
  
  // Checking if the Ball hit a recieved Player p
  void checkHit(Player p){
    // This Checks for the LEFT Player
    if(p.left){
      if(pos.x-r == p.pos.x+p.w){
        if((pos.y-r > p.pos.y-r || pos.y+r > p.pos.y-r) && pos.y-r < p.pos.y+p.h+10){
          changeDir();
        }
      }
      // This checks for an edge case, where the Ball hits Players' Corner
      if(pos.x-r == p.pos.x){
        if(pos.y+r > p.pos.y && pos.y-r < p.pos.y+p.h){
          vel.y *= (-1);
          grv.y -= 0.01;
        }
      }
    // This Checks for the RIGHT Player
    } else {
      if(pos.x+r == p.pos.x){
        if((pos.y-r > p.pos.y-r || pos.y+r > p.pos.y-r) && pos.y-r < p.pos.y+p.h+10){
          changeDir();  
        }
      }
      // This checks for an edge case, where the Ball hits Players' Corner
      if(pos.x+r == p.pos.x+p.w){
        if(pos.y+r > p.pos.y && pos.y-r < p.pos.y+p.h){
          vel.y *= (-1);
          grv.y -= 0.01;
        }
      }
    }
  }

  // Changes the Direction of the ball
  void changeDir(){
    vel.x *= (-1);
    grv.y += grvChange;
    if(grv.y < -0.2 ){
      grvChange *= (-1);
    } else if(grv.y > 0.2){
      grvChange *= (-1);
    }
  }
}