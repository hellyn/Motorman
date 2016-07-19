import processing.video.*;
Movie myMovie;

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

//Variable for line movement for movie background
int y;

//Button attributes
float buttonXLoc = width/2;
float buttonYLoc = height/2;
float buttonWidth = 211;
float buttonHeight = 50;

void setup() {
  size(900, 650);
  f = loadFont("Helvetica-Bold-45.vlw");
  textAlign(CENTER);
  img = loadImage("ICM_Background.jpg"); 
  minim = new Minim(this); 
  song = minim.loadFile("3_OE_New_Track_111613.mp3");
  //song.loop();

  myMovie = new Movie(this, "icm_movie.mov");
  myMovie.loop();

  //String [] questions = loadStrings("questions.txt");
}

void draw() {
  image(img, 0, 0);

  if (state == 0) { 
    strobeButton();

    //can add a fill here to stop letters from strobing. 
    textFont(f);
    //fill(#1275DB);  
    fill(#3B4DF5);
    text("Click & Type Response", width/2, 285);
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
    text(questions[index], width/2, 285);
    //text(questions[index], 140, 285);  

    //Display text field
    textFont(f);
    fill(255, 0, 0);
    text(typing, width/2, 486);
    fill(220);
    textSize(25);
    text("(Press Enter After Typing)", width/2, 600);


    //Draw yellow button to indicate button is On (make button yellow later)
    noStroke();
    fill(#E5DC2F);
    rect(buttonWidth, buttonYLoc, buttonXLoc, buttonHeight);
  }

  //add else if, play sound, draw movie, no button, no text
  else if (state == 2) {
    background(255);
    song.play();
    image(myMovie, 0, 0);
    textFont(f);
    fill(50 + random(255));
    textSize(25);
    text("Click to Restart", width/2, 640);
    fill(#E5DC2F, 130);
    rect(0, y, width, 100);
    //line(0, y, width, y);
    y++;
   if (y > height) {
     y = 0; 

  }
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
      song.pause();
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

  void stop() {
    song.close();
    minim.stop();
    super.stop();
  }

  void movieEvent(Movie m) {
    m.read();
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

