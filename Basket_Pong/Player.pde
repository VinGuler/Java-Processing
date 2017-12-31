class Player{
  
  // Variables for Player Position and Velocity
  PVector pos;
  float vel;
  
  // Players' score
  int score;
  
  // Boolean for Players' side 
  // LEFT player = true; RIGHT player = false
  boolean left;
  
  // Players' Width and Height
  float w, h;
  
  // CONSTRUCTOR
  // Recievces whether its the RIGHT or LEFT Player, Width and Height
  Player(boolean left_, float w_, float h_){
    // Setting width and height for the Player
    w = w_;
    h = h_; 
    // Setting recieved side for the Player
    left = left_;
    // Setting Players location based on its width and left(bool)
    if(left){
      pos = new PVector(w, height/2);
    } else {
      pos = new PVector(width-(w*2), height/2);
    }   
    
    // Initializing Players velocity and score (both =0)
    vel = 0;
    score = 0;
  }
  
  // Showing the Player (GRAPHICS)
  void show(){   
    fill(255);
    noStroke();
    rect(pos.x, pos.y, w, h);
    fill(0, 200, 150);
    rect(pos.x, pos.y+10, w, h-20);
    noFill();
    stroke(0);
    strokeWeight(2);
    line(pos.x, pos.y+h/2, pos.x+w, pos.y+h/2);
  }
  
  // This is constantly called in the games loop
  // Most of the time vel = 0
  // When vel != 0, the Player moves
  void update(){
    pos.y += vel;
    pos.y = constrain(pos.y, 0, height-h);
  }
  
  // Moving the Player (Setting its velocity to a recieved one)
  void move(float v){
    vel = v;
  }
  
  // Adding score to the Player :)
  void addScore(){
    score++;
  }
}