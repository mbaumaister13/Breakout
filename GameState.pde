class GameState {
  PShader background;
  //PShader boxShader;
  PImage box;
  PImage wall;
  int w, h;
  float time;
  int boxY, boxX;
  Ball b;
  Paddle p;
  Box[] walls;
  Box[] level;
  int reset;

  //create a PShader (fragment shader) and PImage (texture)
  //create some helper variables (s,w,h)
  //time variable
  //Declare a: Ball, Paddle, Box[] walls, and Box[] level

  GameState(int w_, int h_, String glsl){ //Constructor
    w = w_;
    h = h_;
    boxX = 175;
    boxY = 250;
    
    background = loadShader(glsl); //http://glslsandbox.com/e#49963.0
    //boxShader = loadShader("box.glsl");
    box = loadImage("block.gif"); //I had these two images already, just edited them to look decent, don't remember where I got them
    wall = loadImage("wall.png");
    
    b = new Ball(width/2, height/2 + 200, 25);
    p = new Paddle(new PVector(width/2, height+175), 400);
    level = level0();
    walls = makeWalls(wall);
    reset = 1;
    
    //set variables
    //create ball, paddle, walls, level
  }

  Box[] level0(){ //Adds all the level boxes to level array, adjusting positions as needed
    level = new Box[60];
    for(int i = 0; i < 60; ++i) {
      if(i % 10 == 0) {
        boxX = 175;
        boxY += 45;
      }
      level[i] = new Box(boxX, boxY, 40, 40, false, box);
      boxX += 45;
    }
    return level;
    
    //Create a grid of boxes
  }

  void update(){
    b.update();
    p.update(b);
    collisions();
    time += 0.01;
    
    //update ball and paddle, call collisions, increase time, and draw
  }
  
  void collisions(){
    ballBoxCollisions(walls);
    ballBoxCollisions(level);
    b.collide_circle(p);
    
    //collide walls, levels, and ball-paddle
  }
  
  void draw(){ //Draws everything
    background(0);
    doShaderStuff();
    
    p.draw();
    b.draw();
    boxArrDraw(level);
    if(b.explode) { //If the box was hit, draw the explosion particles
      drawParticles(b);
    }
    boxArrDraw(walls);
   
    checkWin();
    
    fill(150, 150, 245); //Prints score on screen
    textFont(createFont("Comic Sans MS", 32, true));
    text("Score: " + b.score, 20, 35);
    
    if(!playing) {
      printInstructions();
    }
    
    //draw shader, draw boxes, check/print score/win
  }
  
  void printInstructions() {
    fill(39, 180, 214);
    textFont(createFont("Comic Sans MS", 20, true));
    text("Press P or hit Play to start.", 135, 170);
    text("Press P to pause if game is in progress.", 135, 190);
    text("Press Left Arrow and Right Arrow to move left and right.", 135, 210);
  }
  
  void drawParticles(Ball b) { //Draws the explosion particles when box is hit
    for(int i = 0; i < b.boom.length; ++i) {
      b.boom[i].update();
    }
    if(time % 0.01 == 0) { //Required to draw the particles fully, would disappear quickly without this
      b.explode = false;
    }
  }
  
  Box[] makeWalls(PImage img){ //Adds the three wall boxes to walls array
    walls = new Box[3];
    walls[0] = new Box(0, 0, 100, height, true, img);
    walls[1] = new Box(100, 0, 600, 100, true, img);
    walls[2] = new Box(700, 0, 100, height, true, img);
    return walls;
    
    //Make 3 boxes (left, top, right) as walls
  }
  

  void ballBoxCollisions(Box[] boxes){ //Checks collision for every box
    for(int i = 0; i < boxes.length; ++i) {
      b.collide_box(boxes[i]);
    }
    
    //collide for each in an array of boxes
  }

  void boxArrDraw(Box[] boxes){ //Draws the boxes
    for(int i = 0; i < boxes.length; ++i) {
      if(!boxes[i].wall) //Determines which texture to use based on wall boolean
        boxes[i].draw(box);
      else if(boxes[i].wall)
        boxes[i].draw(wall);
    }
    
    //draw for each in an array of boxes
  }

  void doShaderStuff(){ //Shader stuff
    background.set("resolution", width, height);
    background.set("time", time);
    filter(background);
    
    //Update the time, pass the relevant uniform variables
  }
  
  void checkWin(){  //Prints score or win depending on game state
    if(!hasAlive(level)) { //If there are no more boxes alive, You Win!
      println("You Win");
      
      fill(250, 240, 43);
      textFont(createFont("Comic Sans MS", 72, true)); 
      text("You Win!", 250, 400);
      reset += 1; //Resets the game after a certain amount of time
    } else {
      println(b.score); //Prints score
    }
    
    //if there aren't any boxes left, print "You Win"
    //otherwise print the current score
  }
  
  boolean hasAlive(Box[] boxes){ //If any box is alive, it returns true, else false
    for(int i = 0; i < boxes.length; ++i) {
      if(boxes[i].alive) {
        return true;
      }
    }
    return false;
    
    //Check to see if the level has a box left
  }
  
  void keyPressed(){
    p.keyPressed();
    
    //call the paddle's keyPressed command
  }
  void keyReleased(){
    p.keyReleased();
    
    //call the paddle's keyReleased command
  }
}
