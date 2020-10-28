class Particle { //Found this online, used for particle explosions when box is hit https://www.openprocessing.org/sketch/49434# 
  float x;
  float y;
  float velX; //speed or velocity
  float velY;
  
  Particle(Box b) { //Uses the center of the box destroyed as initial particle position
    x = b.center.x;
    y = b.center.y;
    
    velX = random(-50,50); //Randomizes direction
    velY = random(-50,50); 
  }
  
  void update() {
    x+=velX;
    y+=velY;
    this.draw();
  }
  
  void draw() { //Randomizes particle sizes and colors (stays between yellow and red)
    noStroke();
    fill(250, random(43,230), 43);
    ellipse(x,y,random(5,11),random(5,11));
  }
}
