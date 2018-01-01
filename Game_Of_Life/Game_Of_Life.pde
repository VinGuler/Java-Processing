/* 
  This is Conway's 'Game of Life'
  a cellular automaton.
  Read more by searching for |Conway's Game of Life|
  on Wikipedia.
  ___ RULES : ___
  Cell.alive with numberOfNeighbors.alive<=1 || numberOfNeighbors.alive>=4
  will DIE
  Cell.notalive with numberOfNeighbors.alive==3
  will RESORRECT
  Create your starting patterns by clicking on gray squeres.
  Reclicking a live Cell will kill it.
  
  The grid is supposed to be infinte, 
  but everything is finite in the world (except humen stupidity ;-) ),
  and so the grd is finite.
*/

// Variables for the grid
/*
  The grid is needed for the Cell.checkNeighbors function,
  and also gives a structure to the 'world of Cells' 
*/
Cell[][] grid;
int rows;
int cols;
int scl = 10;

// ArrayList of cells
ArrayList<Cell> cells;

// State of the Animation
// If start then animation starts...
boolean start;

void setup(){

  size(1200, 800);
  // FrameRate is limited so it won't go to fast...
  frameRate(20);
  
  // Creating the empty grid = [][] <- 2D Array
  rows = height / scl;
  cols = width / scl;
  grid = new Cell[rows][cols];

  /* 
    Starting the whole cells world
    This sets start=false, initializes the cells ArrayList 
    and fills up the grid and the cells ArrayList
  */
  restart();
}

void draw(){
  
  // Showing all the Cells in the the cells Array, (alive+dead)
  for(Cell cell : cells){
    cell.show();
  }

  // If Animation started
  if(start){
    /*
      First calculate numbers of alive neighbors 
      for each Cell in the grid
    */
    for(Cell cell : cells){
      cell.checkNeighbors();
    }
    /*
      Then, update the Cells' color
      based on its' state (alive||dead)
    */
    for(Cell cell : cells){
      cell.update();
    }
  }
}

void restart(){
  // Not starting the animation on 
  start = false;
  // Initializing cells ArrayList
  cells = new ArrayList<Cell>();
  
  // Filling both the grid and the cells Array with dead Cells
  for(int row = 0; row < rows; row++){
    for(int col = 0; col < cols; col++){
       grid[row][col] = new Cell(row, col);
       cells.add(grid[row][col]);
    }
  }
}

void keyPressed(){

  // UP key for starting||stopping the animation
  if (keyCode == UP){
    if(start){
      start = false;
    } else {
      start = true;
    }  
  }
  // DOWN key for restarting the whole thing
  if (keyCode == DOWN){
    restart();
  }
}

void mousePressed(){
  // Getting mouse pos on the grid
  int x = (int)floor(mouseX/scl);
  int y = (int)floor(mouseY/scl);

  // Setting selected Cells' state
  if (!grid[y][x].alive){
    grid[y][x].alive = true;  
  } else {
    grid[y][x].alive = false;
  }
}

void mouseDragged(){
  // Getting mouse pos on the grid
  int x = (int)floor(mouseX/scl);
  int y = (int)floor(mouseY/scl);

  // Setting selected Cells' state
  if (!grid[y][x].alive){
    grid[y][x].alive = true;  
  } else {
    grid[y][x].alive = false;
  }
}