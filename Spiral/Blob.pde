class Blob{
  
  // Location
  float x;
  float y;
  
  // Distance and angle of distance from middle point
  float rSpin;
  float angle;
  
  // Blobs Radius, Color and stroke bool
  float r;
  color clr;
  boolean strk;
  
  // Constructor
  Blob(float radius, float a, boolean s){
    r = radius;
    strk = s;
    relocate(a);
  }
  
  // Showing the Blob
  void show(){
    
    // Polar to Cartesian Coordinates
    x += rSpin*cos(angle);
    y += rSpin*sin(angle);
    
    // Graphics
    fill(clr);
    if(strk){
      stroke(255, 25);
    } else {
      noStroke();
    }
    ellipse(x, y, r*2, r*2);
  }
  
  // Updating the Blobs location, based on an input rate
  void update(float rate){
    angle += rate;
    rSpin += rate;
  }
  
  // Relocating The Blob to Origin (width/2, height/2)
  // Also Restarting all the values
  // Also recieve (as input) the starting angle for the Blob
  void relocate(float a){
    // Center of screen
    x = width/2;
    y = height/2;
    
    // Setting the Polar Values to 0 OR a given angle for angle
    rSpin = 0;
    angle = a;
    
    // Changing the Blobs Color
    // -- Change HardCoded int Values for special colors ;) -- //
    int red = floor(a*100) % 80;
    int green = floor(a*100) % 240;
    int blue = floor(a*100) % 160;
    clr = color(red, green, blue, 25);
    //clr = color(0, 5);
  }
  
  // Check for the end of the run of this Blob
  boolean edge(){
    if(y > 1.25*height){
      return true;
    }
    return false;
  }
  
  // Setting the Blobs stroke visible/invisible
  void paintStroke(){
    if(strk){
      strk = false;
    } else {
      strk = true;
    }
  }
}