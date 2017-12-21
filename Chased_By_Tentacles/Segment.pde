class Segment{
  
  // Starting(A) and Ending(B) Positions of the Segment (LINE)
  PVector pointA;
  PVector pointB;
  
  // Angke of the Segment from its base
  float angle = radians(0);
  
  // Length of the Segment
  float len;
  
  // Here for the snake
  // each lvl the line is thiner, make the snake nicer
  int lvl;
  
  // Color of the Segment - For Snake
  int red, green, blue;
  
  // Each Segment is connected to a parent Segment
  // In the begining there is no parent
  Segment parent = null;
  
  // CONSTRUCTOR 1
  // Recieving x, y for pointA
  // and the length of the Segment
  // First Segment with no parent
  Segment(float x, float y, float len_){
    // Setting pointA
    pointA = new PVector(x,y);
    // Calculating pointB
    pointB = calcB(pointA);
    
    // Setting length
    len = len_;
    
    // Randomizing the Color - For Snake
    red = floor(random(255));
    green = floor(random(255));
    blue = floor(random(255));
  }
  
  // CONSTRUCTOR 2
  // Recieving a Parent Segment
  // and the level of the Segment, to control its length
  // First Segment with no parent
  Segment(Segment p, int lvl_){
    // Assigning the recieved parent
    parent = p;
    // Setting this childs pointA to be parents pointB
    // Connecting child to parent, creating chain
    pointA = parent.pointB.copy();
    // Setting childs length and angle to be parents length and angle
    len = parent.len;
    angle = parent.angle;
    
    // Calculating new length based on level (For Snake)
    lvl = floor((int)len-lvl_);
    pointB = calcB(pointA);
    
    // Randomizing Colors
    red = floor(random(255));
    green = floor(random(255));
    blue = floor(random(255));
  }
  
  // Setting the base of the creature in a recieved pos
  void setBase(PVector pos){
    pointA = pos.copy();
    pointB = calcB(pointA);
  }
  
  // Calculating the pointB value
  // based on a recieved pointA
  PVector calcB(PVector pa){
    float dx = len * cos(angle);
    float dy = len * sin(angle);
    return new PVector(pa.x+dx, pa.y+dy);
  }
  
  // IMPORTANT
  // This makes the Segment try follow a target (i.e the mouse)
  void follow(float tx, float ty){
    // The target to follow
    PVector target = new PVector(tx, ty);
    // The distance (in a vector sense : magnitide & angle) of the target from pointA
    // Target - piontA
    PVector dir = PVector.sub(target, pointA);
    // Angle of the dir vector
    angle = dir.heading();
    
    // Setting the dir Magnitude based on Segments length
    dir.setMag(10);
    // This sets the dir vector to be negative
    // This causes the Segment to follow the target, instead of "running away" from it
    dir.mult(-1);
    
    // Setting pointA in the Direction of the target
    pointA = PVector.add(target, dir);
  }
  
  // Showing the Segment as a line
  void show(){
    // If Snake (Most of the time Segments longer then 25)
    if(len > 10){
      strokeWeight(lvl);
      stroke((lvl*10)%255, 10, 10, 200);
    }
    // If Creature (Most of the time Segments shorter then 25)
    else {
      strokeWeight(4);
      stroke(0, 250, 0, 50);
    }
    line(pointA.x, pointA.y, pointB.x, pointB.y);
    
  }
  
  // Recalculating pointB each Frame
  // this is only for the Snake
  void update(){
    pointB = calcB(pointA);
  }
}