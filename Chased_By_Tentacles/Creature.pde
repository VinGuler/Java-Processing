class Creature{
  
  // Amount of parts
  int parts;
  // Length of of each part
  float len;
  // Base of the tentacle (for the one connected to an edge
  PVector base;
  
  // The creatures' tentcles - list of Segments ;)
  Segment[] tentacle;
  // One Segment of the tentale has to be the head
  // Rest of this tentacle Segments follows the head
  Segment head;
 
  // CONSTRUCTOR
  // Recieve a base location (PVector with x and y)
  Creature(PVector ba, int p, float l){
    // Setting this creatures' base, amount of parts and length of parts
    base = ba;
    parts = p;
    len = l;
    
    // Initializing tentacle list
    tentacle = new Segment[parts];
    
    // Creating the head with starting location/target at the middle of the screen
    head = new Segment(width/2, height/2, len);  
    // Adding head to the tentacle list on the last spot
    tentacle[parts-1] = head;
    
    // Filling the tentacle list from the last-1(head) to the first
    // Each Segment recieves the next Segment as a parent Segment
    // Which creates this list starting with the head as master parent
    for(int i=parts-2; i>=0; i--){
      tentacle[i] = new Segment(tentacle[i+1], i-int(len)/4);      
    }
  }
  
  // Showing the creature (the tentacles[])
  // This function recieves a target coordination (x, y)
  void show(float x, float y){
    
    // Head follows the target
    tentacle[parts-1].follow(x, y);
    // See update() function in Segment class, 
    // basically calculating pointB relativly to current pointA
    tentacle[parts-1].update();
    
    // See update() and follow() functions in Segment class
    for(int i=parts-2; i>=0; i--){
      tentacle[i].follow(tentacle[i+1].pointA.x, tentacle[i+1].pointA.y);
      tentacle[i].update();
    }
      
    // First Segment in the tentacle list is connected to the edge (base location)
    tentacle[0].setBase(base);
    
    // All the other Segments, their base is the Segment before the in the list
    // So each Segment has the base at pointB of the Segment before it***
    // *** After it in the list order
    for(int i=1; i<parts; i++){
      tentacle[i].setBase(tentacle[i-1].pointB);
    }
    
    // Calling Segment.show() on each Segment of the tentacle
    // Well... to show the Segments
    for(int i=parts-2; i >=0; i--){
      tentacle[i].show();
    }  
  }
}