// ArrayList for the Circle objects,
// that create the image
ArrayList<Circle> circles;

// ArrayList of Images
ArrayList<PImage> images;
// Counter for the images List
int imageCounter = 0;
// Current used Image
PImage img;

// Starting radius for the Circles
float sRadius = 1.5;

// Rate of Growth for the Circles
float rateOfGrowth = 0.05;

// Distance Between Circles
float dbc = 1.2;

// Randomization of the Circles colors
boolean randomizeColors = false;
// Black and White and Gray Circles
boolean blackAndWhite = false;

/* 
  Total amount of Circles the computer 
  TRIES to create each frame
  This includes null Circles created in the frame
*/
int total = 100;

/* 
  Max attempts to create Circles
  This is needed to evade unlimited loop 
  when there'll be no more valid Circles to create
*/
int maxAttempts = 5000;

// Name of the image file or path to it
String filePath = "cat.png";

void setup(){
  
  // Loading the first image
  img = loadImage(filePath);
  
  /*
    Translating the image to pixels
    loading images pixels
  */
  img.loadPixels();
  
  // Setting the sketches size to be that of the Image
  surface.setSize(img.width, img.height);
  
  // Initializing/Restarting the circles ArrayList
  circles = new ArrayList<Circle>();
  
  // Background is black
  background(0);
}

void draw(){
  
  // Counter for amount of valid Circles in this loop
  int count = 0;
  
  // Counter for the amount of attempts to create Circles
  int attempts = 0;
  
  // While number of valid created Circles is < total
  while(count < total){
    // Try to create a Circle
    Circle cir = newCircle();
    // If its valid (!= null)
    if(cir != null){
      // add it to the circles ArrayList and count++
      circles.add(cir);
      count++;
    }
    // whether you add a valid Circle, or didn't add null, attempt++
    attempts++; 
    // If attempts goes bonanza, set new Image, and restart the process.
    if(attempts > maxAttempts){
      setNewImage(loadImage(filePath));
    }
  }
  
  // For all the Circles
  for(Circle current : circles){
    // Only if the current Circle is growing
    if(current.growing){
      // If it hits the edge Stop Growing
      if(current.edges()){
        current.changeGrowing(false);
      } 
      // If not hit the edges
      else {
        // Check for all the other Circles
        for(Circle other : circles){
          // If the other Circle is not the currentCircle
          if(current != other){
            current.hitOther(other);           
          }
        }
      }
    }
    // Showing and Growing the currentCircle
    current.show();
    current.grow();  
  } 
}

// Function to create new Circle
Circle newCircle(){
  
  // Creating the Circle at a random pos (x, y)
  int x = floor(random(width));
  int y = floor(random(height));
  
  // Boolean to check if the Circle is valid
  // to make sure a Circle is not created on top of another Circle
  boolean valid = true;
  
  /*
    For all the already created Circles, checks if the current pos(x, y)
    is valid, meaning not to close to an already created Circle
  */
  for (Circle circle : circles){
    // Calculating the distance between currently generated(x, y), 
    // to the pos(x,y) of the current Circle in the loop
    float d = dist(x, y, circle.x, circle.y);
    /* 
      If the distance is bigger then:
      current Circle.radius in the loop + (dbc),
      then dont create the Circle.
    */
    if ( d < circle.r + (dbc) ){
      valid = false;
      break;
    }
  }
  
  // If the Circle is valid
  if(valid){
    /* 
      Get the pixel at the location (x, y)
      x + y + img.width is a formula that gets the index of the pixles in the pixels[].
      pixels[] is a 1D Array, containing all the pixels from the canvas (grid of pixels).
    */
    int index = x + y * img.width;
    // Get the pixels color
    color clr = img.pixels[index];
    /* 
      Generating random color for the Circles.
      Used to generate paint the images randomly.
      Currently uses the brightness of a pixels to choose which pixels to paint.
      Black pixels will create Circles black Circles.
      randomizeColors is a bool for easier controll
    */
    if(randomizeColors){
      if(brightness(clr) > 100){
        clr = color(floor(random(255)), floor(random(255)), floor(random(255)));
        int red = floor(random(255));
        int green = floor(random(255));
        int blue = floor(random(255));
        clr = color(red, green, blue);
      } else {
        clr = color(0, 10);
      }
    }
    
    if(blackAndWhite){
      clr = color(brightness(clr));
    }
    // Create the new Circle, with the Color at that pixel
    return new Circle(x, y, clr);
  } 
  // If the Circle aint valid, return null
  else {
    return null;
  }
}

// Loading the Image to paint
void setNewImage(PImage file){
  // Loading the image
  img = file;
  
  /*
    Translating the image to pixels
    loading images pixels
  */
  img.loadPixels();
  
  // Initializing/Restarting the circles ArrayList
  circles = new ArrayList<Circle>();
}

// Controlling Modes
void keyPressed(){
  if(key == ' '){
    blackAndWhite = false;
    randomizeColors = false;
  }
  
  if(key == 'r'){
    if(randomizeColors){
      randomizeColors = false;
    } else {
      blackAndWhite = false;
      randomizeColors = true;
    }
  }
  if(key == 'b'){
    if(blackAndWhite){
      blackAndWhite = false;
    } else {
      randomizeColors = false;
      blackAndWhite = true;
    }
  }
}