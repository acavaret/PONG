////// FOR THE BALL
int rad = 20;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 5.8;  // Speed of the shape
float yspeed = 5.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom

////// P1 & P2
float paddleX;
float paddleY = 20;
float paddleW = 100; //40
float paddleH = 10;

float paddle2X;
float paddle2Y = 470;

///// Score 
PFont f;

///// OSC
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;


void setup() {
  size(500, 500); // w x h
  reset();
  
  /////// FOR THE BALL
  noStroke();
  frameRate(30);
  ellipseMode(CENTER);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
  
  ////// FOR P1 & P2
  fill (255);
  rectMode(CORNER);
  paddleX = 30;
  paddle2X = 370;

  f = createFont("Arial",12,true); // A font to write text on the screen
  
  ////// OSC
  oscP5 = new OscP5(this,12345);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("149.31.139.143",12345);
}

void draw() {
  background(0);
  Pong();
  P1();
  P2();
  dataOut ();
   
  ////// Display number of lives left
  textFont(f,14);
  fill(255);
  //text("Lives left: " + lives,10,20);
  //rect(10,24,lives*10,10);

  
}

void Pong() {
  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-rad || xpos < rad) {
    xdirection *= -1;
  }
  if (ypos < 0) {
    text("Player 2 Wins",200,250);
  }
  if (ypos > height) {
    text("Player 1 Wins",200,250);
  }
  /*
  if (ypos > height-rad || ypos < rad) {
    ydirection *= -1;
  }
*/
  ////// Draw the shape
  ellipse(xpos, ypos, rad, rad);
 
}

void dataOut () {
  OscMessage ballSend = new OscMessage("/ball/position");
    ballSend.add(xpos);
    ballSend.add(ypos);
    
  OscMessage paddleSend = new OscMessage("/player/position");
    paddleSend.add(paddleX);
    paddleSend.add(paddleY);
    
  /* send the message */
  oscP5.send(ballSend, myRemoteLocation);
  oscP5.send(paddleSend, myRemoteLocation);
}

void P1() {
  rect(paddleX, paddleY, paddleW, paddleH); // x,y,w,h 

/**/ 
  ////// Bounce Ball off paddle
  if (collision(paddleX, paddleY, paddleW, paddleH)) {
    ydirection = -ydirection; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
  }
 
  if (ypos < 0) {
    ydirection = -ydirection; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
  }
 
  if (xpos > width) {
    xdirection = -xdirection; // if dY == 2, it becomes -2; if dY is -2, it becomes 2
  }
 
  if (xpos < 0) {
    xdirection = -xdirection; // if dY == 2, it becomes -2; if dY is -2, it becomes 2
  }

}
////// end P1 Draw

void mouseMoved() {
  paddleX = mouseX;
  //paddle2X = mouseX;
}

/**/
boolean collision(float px, float py, float pw, float ph) {
  boolean returnValue = false; // assume there is no collision
   if ((ypos >= py) && (ypos <= py + ph)){
     if ((xpos >= px) && (xpos <= px + pw)){
       returnValue = true;
    }
  }
  return returnValue;
}

/////// Press any key to reset game
void reset() {
  size(500, 500); // w x h

  
  /////// FOR THE BALL
  noStroke();
  frameRate(30);
  ellipseMode(CENTER);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
  
  ////// FOR P1 & P2
  fill (255);
  rectMode(CORNER);
  paddleX = 30;
  paddle2X = 370;

  f = createFont("Arial",12,true); // A font to write text on the screen  
}

void keyPressed() {
 reset();
}

void P2() {
  rect(paddle2X, paddle2Y, paddleW, paddleH); // x,y,w,h 
  

  ////// Bounce Ball off paddle
  if (collision(paddle2X, paddle2Y, paddleW, paddleH)) {
    ydirection = -ydirection; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
  }
 
  if (ypos < 0) {
    ydirection = -ydirection; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
  }
 
  if (xpos > width) {
    xdirection = -xdirection; // if dY == 2, it becomes -2; if dY is -2, it becomes 2
  }
 
  if (xpos < 0) {
    xdirection = -xdirection; // if dY == 2, it becomes -2; if dY is -2, it becomes 2
  } 

}
////// end P2 Draw


//////* incoming osc message are forwarded to the oscEvent method. */ 
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/player/position")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("ff")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      paddle2X = theOscMessage.get(0).floatValue();  
      paddle2Y = theOscMessage.get(1).floatValue();
      //String thirdValue = theOscMessage.get(2).stringValue();
      print("### received an osc message /test with typetag ff.");
      //println(" values: "+firstValue+", "+secondValue+", "+thirdValue);
      return;
    }  
  } 

}

