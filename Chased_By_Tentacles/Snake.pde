class Snake{
  
  // Number of segments
  int parts;
  // Segments' length
  float len;
  
  // The Snake is an array of segments
  Segment[] snake;
   
  // CONSTRUCTOR
  // Recieving numberOfParts and eachPartsLength
  Snake(int parts_, float len_){
    // Setting length and amount of parts
    len = len_;
    parts = parts_;
    // Initializing Segmant list - the snake
    snake = new Segment[parts];
    
    // Setting The Head of the Snake (middle of screen)
    snake[0] = new Segment(width/2, height/2, len);
    
    // Filling the Segments list - the snakes' body
    for(int i=0; i<parts-1; i++){
      snake[i+1] = new Segment(snake[i], i);
    }    
  }
  
  // Showing the Snake
  void show(float x, float y){
    
    for(int i=parts-1; i>=0; i--){
      // Controlling the head
      if(i==0){
        snake[0].follow(x, y);
        snake[0].update();
      // The body follows
      } else {
        snake[i].follow(snake[i-1].pointA.x, snake[i-1].pointA.y);
        snake[i].update();
      }
      // Showing all the snake
      snake[i].show();  
    }
  }
}