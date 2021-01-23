//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
int segX;
int segY;

// Add a constructor with parameters to initialize each variable.
  public Segment (int x, int y) {
  this.segX = x;
  this.segY = y;
}


}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
int headX;
int headY;
int foodX;
int foodY;
int direction = UP;
int foodCounter = 0;
ArrayList <Segment> tail = new ArrayList <Segment>();



//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
size(500,500);
head = new Segment(250, 250);
frameRate(20); 
dropFood();
}

void dropFood() {
  //Set the food in a new random location
    foodX = ((int)random(50)*10);
    foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0,0,255);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(255,0,0);
  rect(foodX,foodY,10,10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(0,255,0);
  rect(head.segX, head.segY, 10, 10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
for(int i=0; i<tail.size(); i++) {
  fill(0,255,0);
  rect(tail.get(i).segX,tail.get(i).segY, 10, 10);
}
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  tail.add(new Segment(head.segX, head.segY));
  tail.remove(0);
  
}

void checkTailCollision() {
for(int i=0; i<tail.size(); i++) {
  if(head.segX==tail.get(i).segX && head.segY==tail.get(i).segY) {
    foodCounter=1;
    tail = new ArrayList <Segment>();
    tail.add(new Segment(head.segX, head.segY));
  }
}
  
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if(keyCode == 38 && direction!= DOWN) {
    direction = UP;
  }
  if (keyCode == 40 && direction != UP) {
    direction = DOWN;
  }
  if (keyCode == 37) {
    direction = LEFT;
  }
  if (keyCode == 39) {
    direction = RIGHT;
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
    
  switch(direction) {
  case UP:
    // move head up here 
    head.segY-=10;
    break;
  case DOWN:
    // move head down here 
    head.segY+=10;
    break;
  case LEFT:
   // figure it out 
   head.segX-=10;
    break;
  case RIGHT:
    // mystery code goes here 
    head.segX+=10;
    break;
  }
  checkBoundaries();
  
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
if(head.segX > 500) {
  head.segX = 0;
}
if (head.segX < 0) {
  head.segX = 500;
}
if (head.segY > 500) {
  head.segY = 0;
}
if (head.segY < 0) {
  head.segY = 500;
}
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
if(head.segX == foodX && head.segY == foodY) {
  foodCounter +=1;
  dropFood();
  fill(0,255,0);
  tail.add(new Segment(head.segX, head.segY));
}
}
