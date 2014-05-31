/**
 * TimerTask (v1.3)
 * by GoToLoop (2013/Dec)
 *
 * forum.processing.org/two/discussion/1725/millis-and-timer
 */
 
import java.util.Timer;
import java.util.TimerTask;
 
final Timer t = new Timer();
boolean hasFinished = true;
 
void draw() {
  if (hasFinished) {
    final float waitTime = random(10);
    createScheduleTimer(waitTime);
 
    println("\n\nTimer scheduled for "
      + nf(waitTime, 0, 2) + " secs.\n");
  }
 
  if ((frameCount & 0xF) == 0)   print('.');
}
 
void createScheduleTimer(final float sec) {
  hasFinished = false;
 
  t.schedule(new TimerTask() {
    public void run() {
      print(" " + nf(sec, 0, 2));
      hasFinished = true;
    }
  }
  , (long) (sec*1e3));
}
