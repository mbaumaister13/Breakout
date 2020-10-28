class Paddle {
  PVector pos, relativePos;
  float diam;
  boolean left, right;
  float speed;
  //PImage paddle;
  //position vector
  //diameter
  //flags for moving left or right
  //set the speed
  
  Paddle(PVector p_, float d_){
    pos = p_;
    diam = d_;
    left = false;
    right = false;
    //paddle = loadImage("target.jpg");
    //paddle.resize((int)diam, (int)diam);
    //Set the initial position and diameter
  }
  void update(Ball b){ 
    if(moveable(b)) { //Checks both direction and moveable flags
      if(left && !right) {
        pos.x += move();
        this.draw();
      }
      if(right && !left) {
        pos.x += move();
        this.draw();
      }
    }
    
    //If the flag is set, update that direction
    //this.draw();
  }
  
  float move(){
    if(left && (pos.x - diam/2 > 0)) { //Manually set speed of 8 in any direction
      return -8.0;
    } else if (right && (pos.x + diam/2 < 800)) {
      return 8.0;
    }
    return 0.0;
    
    //return the change in x based off of movement flags
  }

  boolean moveable(Ball b){
    relativePos = new PVector(b.x - pos.x, b.y - pos.y);
    if((relativePos.x * relativePos.x + relativePos.y * relativePos.y) < ((diam + b.diam)/2) * ((diam + b.diam)/2)) { //Distance cehcking formula
      return false;
    }
    return true;
    
    //Check that the distance between the centers 
    //  is less than the sum of the radii.
  }


  void draw(){
    fill(255, 150, 150);
    stroke(0);
    strokeWeight(3);
    arc(pos.x, pos.y, diam, diam, PI, 2*PI, CHORD);
    
    //Draw an arc using the CHORD parameter from theta past PI to theta shy of 2*PI
    //Add the radius to the y position and subtract the y offset. 
    //ellipse(p.x, p.y, d,d);
  }
  void keyPressed(){ //Uses left and right arrow keys to move
    if(key == CODED) {
      if(keyCode == LEFT) {
        left = true;
      } else if (keyCode == RIGHT) {
        right = true;
      }
    }
    
    //Set movement 'key' flags to true
  }
  void keyReleased(){
    left = false;
    right = false;
    
    //Set movement 'key' flags to false
  }
}
