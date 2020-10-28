import controlP5.*;

ControlP5 cp5;
GameState gs;
int w, h;
boolean playing;
Button play;

void setup(){
  size(800, 800, P2D);
  init();
  
  //set the size and renderer to P2D
  //Call init()
}

void init(){
  w = 800;
  h = 800;
  gs = new GameState(w, h, "background.glsl");
  playing = false;
  cp5 = new ControlP5(this);
  play = playButton();
  
  //set w, h, gs, play
}

void draw() {
  background(0);
  if(play.isPressed() && !playing) { //Toggles with button
    toggle();
  }
  if(playing) {
    gs.update();
    gs.draw();
  } else if(!playing) {
    gs.draw();
  }
  
  if((gs.b.y > height) || (gs.reset % 500 == 0)) { //Resets if ball "dies" or a certain amount of time after winning
    init();
  }
  
  //reset background
  //if the game is playing, update and draw, otherwise just draw 
  //if the ball position exceeds the window height, call init() (to reset)
}

Button playButton(){
  play = cp5.addButton("PLAY").setPosition(300, 400).setSize(200, 75);
  PFont font = createFont("Comic Sans MS", 36, true); //Comic Sans ;)
  ControlFont cfont = new ControlFont(font);
  cp5.getController("PLAY").setFont(cfont);
  return play;
  
  //Create a Button, return it.
  //Use createFont, ControlFont, and setFont 
  //Center the font by subtracting half of the size from the position
}

void toggle(){
  playing = !playing;
  if(playing) {
    play.hide();
  } else {
    play.show();
  }
  
  //Flip the value of the boolean
  //If the game is playing, hide the button, otherwise show it
  //use the button's hide and show functions
}

void keyPressed(){
  if(playing)
    gs.keyPressed();
  
  if(key == 'p') {
    toggle();
  } else if (key == '`') {
    saveFrame("screenshots/screenshot-####.png");
  }
  
  //call the GameState's keyPressed command
  //press 'p' to pause/unpause (via toggle())
  //if(key == '`') saveFrame("screenshots/screenshot-####.png");
}
void keyReleased(){
  gs.keyReleased();
  
  //call the GameState's keyReleased command
}
