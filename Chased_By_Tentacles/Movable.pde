class Movable{

  // Location and movement Variables
  PVector pos;
  PVector vel;
  PVector grv;
  
  // Arbitrary for aesthetics
  float distForEdge = 15;
  
  // CONSTRUCTOR
  // Recieve a starting pos and vel 
  Movable(PVector sPos, PVector sVel){
    pos = sPos;
    vel = sVel;
    grv = new PVector(0.01, 0.01);
  }
  
  // Changing the location (adding vel to pos and grv to vel)
  void update(){
    pos.add(vel);
    vel.add(grv);
  }
  
  // Showing the Movable ( Big dot on the screen for the looks )
  void show(){
    strokeWeight(25);
    stroke(10, 10, 250, 200);
    point(pos.x, pos.y);
  }
  
  // Setting the Movables location
  void setLoc(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  
  // Changing the direction of movement
  // on hitting an edge
  // When the Movable is out of the screen, its location
  // Is being put on the edge itSelf, preventing it from flying far away
  void hitEdge(){
    if(pos.x > width-distForEdge){
      pos.x = width-distForEdge;
      vel.x *= (-1);
      grv.x *= (-random(1));
    }
    if(pos.x < distForEdge){
      pos.x = distForEdge;
      vel.x *= (-1);
      grv.x *= (-random(1));
    } 
    if(pos.y > height-distForEdge){
      pos.y = height-distForEdge;
      vel.y *= (-1);
      grv.y *= (-random(1));
    }
    if(pos.y < distForEdge){
      pos.y = distForEdge;
      vel.y *= (-1);
      grv.y *= (-random(1));
    }
  }
}