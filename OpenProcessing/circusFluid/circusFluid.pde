/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/29833*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/* 
Circus Fluid
Made by Jared "BlueThen" C. on June 5th, 2011.
Updated June 7th, 2011 (Commenting, refactoring, coloring changes)

www.bluethen.com
www.twitter.com/BlueThen
www.openprocessing.org/portal/?userID=3044
www.hawkee.com/profile/37047/

Feel free to email me feedback, criticism, advice, job offers at:
bluethen (@) gmail.com
*/

// Variables for the timeStep
long previousTime;
long currentTime;
float timeScale = 1; // Play with this to slow down or speed up the fluid (the higher, the faster)
final int fixedDeltaTime = (int)(10 / timeScale);
float fixedDeltaTimeSeconds = (float)fixedDeltaTime / 1000;
float leftOverDeltaTime = 0;

// The grid for fluid solving
GridSolver grid;

void setup () {
  size(640, 480, P2D);
  colorMode(HSB, 255);
  noStroke();
  
  // grid = new GridSolver(integer cellWidth)
  grid = new GridSolver(5); 
}

void draw () {
  /******** Physics ********/
  // time related stuff
  
  // Calculate amount of time since last frame (Delta means "change in")
  currentTime = millis();
  long deltaTimeMS = (long)((currentTime - previousTime));
  previousTime = currentTime; // reset previousTime
  
  // timeStepAmt will be how many of our fixedDeltaTimes we need to make up for the passed time since last frame. 
  int timeStepAmt = (int)(((float)deltaTimeMS + leftOverDeltaTime) / (float)(fixedDeltaTime));
  
  // If we have any left over time left, add it to the leftOverDeltaTime.
  leftOverDeltaTime += deltaTimeMS - (timeStepAmt * (float)fixedDeltaTime); 
  
  if (timeStepAmt > 15) {
    timeStepAmt = 15; // too much accumulation can freeze the program!
    println("Time step amount too high");
  }
  
  // Update physics
  for (int iteration = 1; iteration <= timeStepAmt; iteration++) {
    grid.solve(fixedDeltaTimeSeconds * timeScale);
  }
  
  grid.draw();
  //println(frameRate);
}

/* Interation stuff below this line */

void mouseDragged () {
  // The ripple size will be determined by mouse speed
  float force = dist(mouseX, mouseY, pmouseX, pmouseY) * 255;
  
  /* This is bresenham's line algorithm
     http://en.wikipedia.org/wiki/Bresenham's_line_algorithm
     Instead of plotting points for a line, we create a ripple for each pixel between the
     last cursor pos and the current cursor pos 
  */
  float dx = abs(mouseX - pmouseX);
  float dy = abs(mouseY - pmouseY);
  float sx;
  float sy;
  if (pmouseX < mouseX)
    sx = 1;
  else
    sx = -1;
  if (pmouseY < mouseY)
    sy = 1;
  else
    sy = -1;
  float err = dx - dy;
  float x0 = pmouseX;
  float x1 = mouseX;
  float y0 = pmouseY;
  float y1 = mouseY;
  while ( (x0 != x1) || (y0 != y1)) {
    // Make sure the coordinate is within the window
    if (((int)(x0 / grid.cellSize) < grid.density.length) && ((int)(y0 / grid.cellSize) < grid.density[0].length) &&
      ((int)(x0 / grid.cellSize) > 0) && ((int)(y0 / grid.cellSize) > 0))
      grid.velocity[(int)(x0 / grid.cellSize)][(int)(y0 / grid.cellSize)] += force;
    float e2 = 2 * err;
    if (e2 > -dy) {
      err -= dy;
      x0 = x0 + sx;
    }
    if (e2 < dx) {
      err = err + dx;
      y0 = y0 + sy;
    }
  }
}

// If the user clicks instead of drags the mouse, we create a ripple at one spot.
void mouseClicked () {
  float force = 250000;
  if (((int)(mouseX / grid.cellSize) < grid.density.length) && ((int)(mouseY / grid.cellSize) < grid.density[0].length) &&
    ((int)(mouseX / grid.cellSize) > 0) && ((int)(mouseY / grid.cellSize) > 0)) {
    grid.velocity[(int)(mouseX / grid.cellSize)][(int)(mouseY / grid.cellSize)] += force;
  }
}

