class Ball {
  float x, y;
  float speed;
  PVector vel;
  PVector newPos, relativePos, normal, reflection;
  float magnitude;
  Paddle temp;
  float diam;
  float score;
  float paddleDist;
  float boxDistX, boxDistY;
  Particle[] boom;
  boolean explode;
  
  //Declare position, velocity, diameter, speed, score

  Ball(float x_, float y_, float d_){ //Constructor
    x = x_;
    y = y_;
    diam = d_;
    speed = 5;
    vel = new PVector(random(-3, 3), speed); //Randomizes x direction when game starts
    boom = new Particle[50];
    explode = false;
    
    //Initialize position, velocity, diameter, speed
  }
  
  void update(){
    x += vel.x;
    y += vel.y;
    
    //update the position
  }
  
  void collide_circle(Paddle pad){ //Uses weird convoluted formula with a million different vectors
    newPos = new PVector(x + vel.x, y + vel.y);
    relativePos = new PVector(pad.pos.x - newPos.x, pad.pos.y - newPos.y);
    magnitude = sqrt(relativePos.x * relativePos.x + relativePos.y * relativePos.y);
    normal = new PVector(relativePos.x / magnitude, relativePos.y / magnitude);
    
    if((relativePos.x * relativePos.x + relativePos.y * relativePos.y) <= ((diam + pad.diam)/2) * ((diam + pad.diam)/2)) {
      reflection = new PVector(vel.x - 2 * (vel.x * normal.x + vel.y * normal.y) * normal.x, vel.y - 2 * (vel.x * normal.x + vel.y * normal.y) * normal.y);
      vel.x = reflection.x * speed / sqrt(reflection.x * reflection.x + reflection.y * reflection.y);
      vel.y = reflection.y * speed / sqrt(reflection.x * reflection.x + reflection.y * reflection.y);
    }
    
    //Check that the distance between the centers 
    //  is less than the sum of the radii.
    //if so
      //Calculate the reflection vector R where n is the normal
      //Reflection_n(v) = v - 2(dot(v,n))n
  }

  void collide_box(Box b) { //Checks for box collision
    if(b.alive) {
      newPos = new PVector(x + vel.x, y + vel.y);
    
      boxDistX = newPos.x - max(b.tlc.x, min(newPos.x, b.tlc.x + b.wh.x));
      boxDistY = newPos.y - max(b.tlc.y, min(newPos.y, b.tlc.y + b.wh.y));
    
      if((boxDistX * boxDistX + boxDistY * boxDistY) < ((diam/2) * (diam/2))) {
        if(!b.wall) { //Does not set wall boxes to not-alive
          b.alive = false;
          ++score;
          for(int i = 0; i < boom.length; ++i) { //Updates particles for particle explosion
            boom[i] = new Particle(b);
          }
          explode = true;
        }
        if(boxDistY == 0) {
           vel.x = -vel.x;
        } else if (boxDistX == 0) {
           vel.y = -vel.y; 
        } else {
          temp = new Paddle(b.center, sqrt((b.wh.x/2) * (b.wh.x/2)));
          collide_circle(temp);
        }
      }
    }
    
    //Is the box "alive"?
      //Make a new position vector which is the position plus the velocity (using new PVector)
      //Why do we do this?
      //So that we don't update that way if we were going to collide.

      //Use the following site to determine if the box collides
      //https://yal.cc/rectangle-circle-intersection-test/
  
      //Check if the circle and box are colliding
        //If they are
        //If it's not a wall, make it not alive, increase score
        //If it's on the left or right, flip the x velocity
        //If it's on the top or bottom, flip the y velocity
        //calculate bools
        //is the position between the y or x bounds of the box?
        //if so, flip the direction 
          //(ex, between x bounds means it's above or below)
        //otherwise
          //Use the same reflection, assume the box is a square
          //then treat the box as a circle
  }
  
  void draw (){
    stroke(0);
    strokeWeight(2);
    fill((float)random(100,255), (float)random(100,255), (float)random(100,255)); //Randomizes the colors every frame for a nice seizure-inducing effect
    ellipse(x, y, diam, diam);
    
    //draw an ellipse, or draw with the shader via GameState
  }
}
