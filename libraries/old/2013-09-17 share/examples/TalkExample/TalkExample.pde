
import nucky.share.*;

Talk talk; // Our Talk object
int[][] boxes = new int[20][20]; // Boxes status arrays

int order = 0; // Total number of received messages
int current = 1; // Current message being faded in
int lastStart = 0; // Last frame when fading started

void setup() {
  size(400,400);
  frameRate(60);

  // Creates a talk with no ciphering on talkId 3
  // Uses the default refresh rate (30 seconds)
  // Note that talkId must be higher than 0.
  try {
    talk = new Talk(this, "http://exemples.nucky.io/share/talk.php", 1);
  } catch (Exception e) {
    exit();
  }
  // You can also use :
  // new Talk(this, "URL", talkId, custom refresh rate in ms)
  // new Talk(this, "URL", talkId, password, custom refresh rate in ms)
  // (see the javadoc)

}

void draw() {
  background(0);
  
  fill(255);
  noStroke();
  
  if (frameCount > lastStart+10) {
    current ++;
    lastStart = frameCount;
  }
  
  // Draws the boxes
  for (int i = 0; i<boxes.length; i++) {
    for (int j = 0; j<boxes.length; j++) {
       if (boxes[i][j] <= current && boxes[i][j] > 0) {
         if (boxes[i][j] == current) {
           fill(255, map(frameCount, lastStart, lastStart+30, 0, 255));
         } else {
           fill(255);
         }
         
         rect(i*20, j*20, 20, 20);
       }
    }
  }
  
  // Draws the mouse box
  noFill();
  stroke(255);
  strokeWeight(2);
  rect(mouseX/20*20, mouseY/20*20,20, 20);
  
}

void mouseClicked() {
   // On mouse clicked, calculates the x and y index
   int x = int(mouseX / 20);
   int y = int(mouseY / 20);
  
  if (boxes[x][y] == 0) { // if the box is not yet filled
   if (talk.sendMessage(str(x)+","+str(y))) { // try to send the message (format : x,y)
     order++;
     lastStart = frameCount;
     boxes[x][y] = order; // if the message was sent, fill our box
   }
  }
}

void messageReceived(String message) {
  // This method is called by Talk when it receives a new message
  String[] where = split(message, ","); // Split the message by ,
  order++;
  boxes[int(where[0])][int(where[1])] = order; // Sets the box x,y to true
}

