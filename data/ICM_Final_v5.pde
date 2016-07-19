import ddf.minim.*;
//Declare variable for minim
//Declare AudioPlayer song
Minim minim;
AudioPlayer song;

PFont f;

PImage img;

//Variable to store text currently being typed
String typing = "";
String saved = "";


//Boolean to know if button on/off. State 0
boolean isOn = false;

//Boolean to know if person is typing
boolean typingOn = false;

//Variable for questions
int i = 0;
String[] questions;

//Variable for state 0 through 2 (3 states)
int state = 0;

int index;

//Button attributes
float buttonXLoc = width/2;
float buttonYLoc = height/2;
float buttonWidth = 230;
float buttonHeight = 50;

void setup() {
  size(900, 650);
  f = createFont("Arial", 25);
  img = loadImage("ICM_Background.jpg"); 
    minim = new Minim(this); 
    song = minim.loadFile("3_OE_New_Track_111613.mp3");
  
  //String [] questions = loadStrings("questions.txt");
}

void draw() {
  image(img, 0, 0);

  if (state == 0) { 
    strobeButton();

    //can add a fill here to stop letters from strobing. 
    textFont(f);
    fill(255);  
    text("Click Button & Type Response to Question", 220, 300);
    
  }

  //if current state changes to next state 1 (button click)
  //then draw questions, draw button, display text field
  else if (state == 1) {

    //draw a question at random from txt file
    questions = loadStrings("questions.txt");
    //index = int(random(questions.length));
    println(questions[index]);      
    textFont(f);
    fill(0);
    text(questions[index], 200, 300);  
 
    //Display text field
    textFont(f);
    fill(0);
    text(typing, 230, 410);
    //add text "press enter to clear type"

    //Draw white button to indicate button is On (make button yellow later)
    noStroke();
    fill(255);
    rect(buttonWidth, buttonYLoc, buttonXLoc, buttonHeight);
  }

  //add else if, play sound, draw movie, no button, no text
  else if(state == 2) {
  
    song.play();
    //add text click screen to restart?
    }
  

     
}



void keyPressed() {
  if (state == 1 && questions.length > 0 && key == '\n') {
    state = 2;
    saved = typing;
    typing = "";
  } 
  else {
    typing = typing + key;
  }
}


void mousePressed() {
  if (state == 0 && mouseX > buttonXLoc && mouseX < buttonXLoc + buttonWidth && mouseY > buttonYLoc && mouseY < buttonYLoc + buttonHeight) {
    isOn = true;
    println("isOn");
    
    state ++;
  }
else if (state <= 3) {
  state = 0;
}

//i++;


else {
  //state = state;
  isOn = false;
}
}


void mouseClicked() {
   index = int(random(questions.length));
  // Turn the button on/off if your mouse clicked and you're hovering over it
  if (isOn) {
    isOn = !isOn;

  }
}

void stop(){
  song.close();
  minim.stop();
  super.stop();
}

//Strobe Rect Function
void strobeButton() {
  buttonXLoc = width/2;
  buttonYLoc = height/2;
  noStroke();
  fill(0 + random(255));
  rect(buttonWidth, buttonYLoc, buttonXLoc, buttonHeight);
}


//if click on strobe bar
//text will appear as a question. say "type to respond"




//type response
//if response if typed
//press return

//if return is pressed
//then text will fade away
//how to make text fade to the background?

//then sound will play

