class Box {
  PVector tlc;
  PVector wh;
  boolean alive;
  boolean wall;
  PVector center;
  PImage wallImage;
  //PShader fancy;

 //top left corner
 //width and height
 //bools for alive and wall
 //vector for image's source location
  
 Box(float x1, float y1, float w, float h, boolean wall_, PImage pimg){ //Constructor
   tlc = new PVector(x1, y1);
   wh = new PVector(w, h);
   center = new PVector(x1 + w/2, y1 + h/2); //Center position vector
   wall = wall_;
   texture(pimg);
   alive = true;
   
   //Set the vectors for the top left, and the width and height
   //Set the wall boolean
   //Set the src x and y positions from the pimage
   //  Make sure to subtract the pimg's width and height to stay within the image
 }

 void draw(PImage pimg){
   if(alive) {
     if(wall) { //If the box is a wall, use the wall texture
       wallImage = pimg.get(0, 0, (int)wh.x, (int)wh.y);
       image(wallImage, tlc.x, tlc.y);
     } else { //Otherwise use the level texture
       pimg.resize((int)wh.x, (int)wh.y);
       image(pimg, tlc.x, tlc.y);
     }
   }
   
   //If it's alive, draw the rect
     //Draw a box
     //rect(tl.x, tl.y, wh.x, wh.y);
     //Use copy to crop part of the pimage
 }
 
 // void draw(PShader pshader){ Tried to make PShader boxes, couldn't figure it out :(
 //  if(alive) {
 //    //stroke(0);
 //    //fill(255);
 //    pshader.set("size", wh.x, wh.y);
 //    shader(pshader);
 //    rect(tlc.x, tlc.y, wh.x, wh.y);
 //  }
 //  //If it's alive, draw the rect
 //    //Draw a box
 //    //rect(tl.x, tl.y, wh.x, wh.y);
 //    //Use copy to crop part of the pimage
 //}
}
