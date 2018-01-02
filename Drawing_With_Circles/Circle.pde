class Circle{
  
  // Position of the Circle (x, y)
  float x;
  float y;
  
  // Circles radius and RateOfGrowth
  float r;
  float rGrowth;
  
  // Circles color
  color clr;
  
  // Bool determines whether the Circle is growing or not
  boolean growing = true;
  
  /* 
    Values for the color of the Circle
    Used to generate randomly colored pics (without a given Image)
  */
  int red,green,blue;
  
  // CONSTRUCTOR
  // Recieves pos(x, y) and color
  Circle(float x_, float y_, color c){
    // Setting Position
    x = x_;
    y = y_;
    
    // Setting Circles radius an RateOfGrowth
    r = sRadius;
    rGrowth = rateOfGrowth;
    
    // Setting the Circles Color
    clr = c;
  }
  
  // Showing the Circle
  void show(){
    fill(clr);
    noStroke();
    ellipse(x, y, r*2, r*2);
  }
  
  // Growing the Circle (if growing==true)
  void grow(){
    if(growing){
      r += rGrowth;
    }
  }
  
  // Changing the growing bool based on a recieved state
  void changeGrowing(boolean state){
    growing = state;
  }
  
  /* 
    Checking if this Circle is close as much as DistanceBetweenCircles(dbc)
    to the other Circle
    If it has, it stops growing
  */
  void hitOther(Circle other){
    float d = dist(x, y, other.x, other.y);
    if( d < r + dbc + other.r ){
      changeGrowing(false);
    }
  }
  
  // Checking if the Circle grown to touch the edges of the screen
  // Returns true if it does, and false if otherwise.
  boolean edges(){
    return (x+r>width || x-r<0 || y+r>height || y-r<0);
  }
}