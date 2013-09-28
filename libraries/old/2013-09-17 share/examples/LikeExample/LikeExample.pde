import nucky.share.Like;

Like like;

void setup() {
 size(200,100); 
 
 try {
   /*
   * To create our Like voting object : 
   * new Like(this, server URL, sketch/poll ID, highest mark between 2 and 9)
   * Or a simpler constructor that will use 5 as the highest mark (5 buttons)
   * new Like(this, server URL, sketch/poll ID)
   * These constructors can throw a MalformedURLException in case the URL given 
   * has not the right syntax
   * Note that pollId must be higher than 0.
   */
   like = new Like(this, "http://exemples.nucky.io/share/like.php", 1, 3);
   like.setVisible(true); // Sets the voting box visible and ready to be used
   
   /*
   * Sets x, y, width, height of the voting box
   * About width / height : w/h will be always at least big enough
   * so we can print the label text with the default or set font
   * but if the bounds are too small, the buttons will be 1px on 1px
   * wich means they will be not visible and not clickable
   */
   like.setBounds(10,10, 100, 60);
   
   
   /*
   * For drawing the buttons there is several options :
   * -If you don't call setShape() or setShapes(), buttons will be simple circles 
   * -If you call setShape() but not setShapes(), buttons will all be 
   * shaped with the PShape
   * -Finally, if you call setShapes(shapes[]), first button will be shaped with the shapes[0]
   * shapes[0], second with shapes[1], ...
   * Little confused ? you can comment / uncomment lines below to try
   */
   like.setShape(loadShape("star.svg")); // Sets one shape for all buttons
   like.setShapes(new PShape[]{loadShape("sad.svg"), loadShape("neutral.svg"), loadShape("happy.svg")});
   
   // Sets the colors of the voting box - you can of course use alpha
   like.setColors(color(245,126,15), color(227, 343 ,50), color(247, 12, 32));
   
   // Sets the label of the voting box - default is Rank me : 
   like.setLabel("Do you like me ?");
   
   // You can also set a font for the label of the voting box :
   // like.setFont(createFont("somefont.vfw", 20));
   
  // You can read the average mark before the user votes, with getAverage()
  println(like.getAverage());
   
 } catch (Exception e) {
   exit();
 }
}

void draw() {
  background(255);
}

// Voted is called when the user voted, whether it worked or not
void voted() {
  
 /*
 hasVoted() returns true if the vote was successfull, false otherwise
 * If hasVoted() is false here, it could be for several reasons :
 * -No internet connection or server is down
 * -User already voted for this sketch
 * -Problem occured server side (SQL connection, PHP Warning ...)
 * A message will be printed to the console
 */
 if (like.hasVoted()) like.setLabel("People likes me : ");

}
