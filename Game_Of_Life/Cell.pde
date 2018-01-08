class Cell{

  // Cell position(x,y) on pixels, and position(row, col) on grid
  int x;
  int y;
  int col;
  int row;
  
  // Bool for Cell state
  boolean alive;
  
  // Counter for the amount of alive neighbors
  int numOfNeighbors;
  
  // CONSTRUCTOR
  // Recieves the Cells loction on the grid (row, col)
  Cell(int c, int r){
    // Calculating location on pixels (x, y) based on the grid location(row, col)
    // and the scl (Global variable for scale)
    x = c * scl;
    y = r * scl;
 
    // Setting the row and col position of the Cell 
    col = c;
    row = r;
    
    // Cell is always dead in the beggining
    alive = false;
  }
  
  // Showing the Cell
  void show() {
    // If alive - Yellow || if !alive - Gray
    if(alive){
      fill(250, 175, 0);
    } else {
      fill(50);
    }
    // I find it nicer without the stroke
    noStroke();
    //stroke(0);
    // Drawing the Cell at position(x,y) with scl for width and height
    rect(x, y, scl, scl);
  }
  
  void update() {

    // This is the original algorithm
    // Algorithm explained at the top of the main part of the programm
    if(alive){
      if (numOfNeighbors <= 1 || numOfNeighbors >= 4){
        alive = false;
      } else {
        alive = true;
      }
    } else {
      if(numOfNeighbors == 3){
        alive = true;
      } else {
        alive = false;
      }
    }
  }
  
  // Checking the amount of LIVING Cells around this Cell
  // This is called for all the Cells each frame, before running update on all of the Cells.
  void checkNeighbors(){

    // Counter of aliveNeighbors for this function 
    int aliveN = 0;
    int index;
    
    // Advancing the counter by 1 if Cell neighbor is alive
    // Also NOT checking fot the edge Cells.
    if(col-1>=0 && col+1<cols && row-1>=0 && row+1<rows){ 
      /*
        Going through the neighbors
        (except itself, where: i & j == 0):
        (col-1, row-1), (col  ,row-1), (col+1, row-1)
        (col-1, row  ), This.....Cell, (col+1, row  )
        (col-1, row+1), (col  ,row+1), (col+1, row+1)
      */
      for(int i = -1; i <= 1; i++){
        for(int j = -1; j <= 1; j++){ 
          if(!(i == 0 && j == 0)){
            index = (col-j) + (row-i) * cols;
            if(cells.get(index).alive){
              aliveN++;
            }
          }
        }
      }
    }
    // Setting this.numOfNeighbors to the counter
    numOfNeighbors = aliveN;
  }
}