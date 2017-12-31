// Rate of Change for both the angle and the distance from from the middle
float rate = 1f;
float aOffset = 0.01f;

// Blobs Radius 
float rad = 10f;

// Starting Angle
float a = 0f;

// The Blobs stroke visibility
boolean strk;

// The Blobs
int amount;
ArrayList<Blob> blobs;

// This is for changing the rate automatically 
float change = 0f;

// Whether to paint background over the blobs or not
boolean bg;

// Setup Func :)
void setup(){
  
  // Size and background color
  size(1000, 800);
  background(255);
  
  /* Amount of blobs
  Has to be Generalized for height, 
  otherwise the spiral will have gaps
  */
  amount = floor(height/100)*70;
  
  // Stroke visibility begins FALSE
  strk = false;
  
  // Not drawing background on top of blobs
  bg = false;
  
  // Initiallizing the Blob Array and adding first Blob
  blobs = new ArrayList<Blob>();
}

// Draw Func :)
void draw(){
  // This creates (or disables) the smearing effect
  if(bg){
    color clr = color(255, 255, 255, 50);
    background(clr);
  }
  
  // Adding new Blobs while the total amount of them is < amount 
  if(blobs.size() < amount){
    a += aOffset;
    blobs.add(new Blob(rad, a, strk));
  }

  // Text stuff, for viewing Amount of Blobs and rate of change
  String forText = String.format("%.2f", rate);
  String txtRate = "Rate: " + forText;
  String txtAmount = "Amount: " + amount;
  textAlign(CENTER);
  textSize(32);
  stroke(0);
  fill(0);
  text(txtRate , width/2, 100);
  text(txtAmount , width/2, 150);
  
  // Updating and showing all the blobs
  for(Blob b : blobs){
    b.update(rate);
    b.show();
    
    // If the Blob has reached the edge of its' existence
    if(b.edge()){
      // Offseting the begging angle
      a += aOffset;
      
      // Setting the blobs pos back to start (width/2, height/2)
      b.relocate(a);
    }
  }
  
  // For automatic change when enabled
  if(change != 0){
    if(frameCount % 5 == 0){
      rate += change;
    }
  }
  
  // Circle in the middle, for the beauty of it ;)
  fill(255, 200);
  noStroke();
  ellipse(width/2, height/2, 40, 40);
}

// Restarting all the values and clearing the canvas
void restart(float ra){
  // Clearing the canvas is optional with this background
  //background(255);
  blobs.clear();
  rate = floor(ra);
  a = 0f;
  change = 0f;
}


void keyPressed(){
  
  // Controlling the Rate
  if(keyCode == UP){
    rate += 1f;
    restart(rate);
  }
  if(keyCode == DOWN){
    rate -= 1f;
    restart(rate);
  }
  
  // Controlling the Amount
  if(keyCode == LEFT){
    amount -= 10;
  }
  if(keyCode == RIGHT){
    amount += 10;
  }
  
  // Setting the smear effect ON / OFF
  if(key == 'b'){
    if(bg){
      bg = false;
    } else {
      bg = true;
    }
  }
  
  // Restaring the whole thing
  if(key == 'r'){
    restart(1f);  
  }
  
  // Setting the rate to a value
  // WITHOUT restarting the animation
  switch(key){
    case '0':
      rate = 0;
      break;
    case '1':
      rate = 1f;
      break;
    case '2':
      rate = 2f;
      break;
    case '3':
      rate = 3f;
      break;
    case '4':
      rate = 4f;
      break;
    case '5':
      rate = 5f;
      break;
  }
  
  // Controlling the stroke visibility
  if(key == ' '){
    for(Blob b : blobs){
      b.paintStroke();
    }
    if(strk){
      strk = false;
    } else {
      strk = true;
    }
  }
  
  // Controlling the change Variable
  if(key == 'c'){
    change *= (-1);
  }
  if(key == 's'){
    if(change != 0){
      change = 0f;
    } else {
      change = 0.0005f;
    }
  }
}