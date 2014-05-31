Scheduler scheduler = new Scheduler();

void setup() {
  size(500, 500);
  background(0);
  fill(255);

  Task t = new Task() {
    public void execute() {
      text("This is arduino code and I will only run once, I will be so quick that you will not see me!!!", 50, 50);
    }
    public void waitingAction() {
      text("Hi there! ..lets wait a little...", 50, 50);
    }
  };
  t.setDelay(5000);
  scheduler.addTask(t);

  //Another way
  t = new Task() {
    public void execute() {
      text("More aduino code !", 50, 50);
    }
    public void waitingAction() {
      text("Lets wait a little AGAIN", 50, 50);
    }
  }.setDelay(2000);
  scheduler.addTask(t);

  //Another
  t = new Task(5000) {
    public void execute() {
      text("More super fast aduino code !", 50, 50);
    }
    public void waitingAction() {
      text("Hi there! ..lets wait a little once AGAIN", 50, 50);
    }
  };
  scheduler.addTask(t);
}

void draw() {
  background(0);
  scheduler.execute();
}

class Scheduler {
  ArrayList<Task> tasks = new ArrayList<Task>();
  long lastMillis=0;
  int currentDelay=0;
  Task currentTask;

  void addTask(Task task) {
    tasks.add(task);
  }
  void execute() {
    if (millis()-lastMillis>=currentDelay && tasks.size()>0) {
      lastMillis = millis();
      currentTask = tasks.remove(0);
      currentDelay=currentTask.getDelay();
      currentTask.execute();
    }
    else {
      if (currentTask!=null) currentTask.waitingAction();
    }
  }
}

abstract class Task {
  private int delay=0;
  abstract void execute();
  abstract void waitingAction();

  Task() {
  }

  Task(int delay) {
    this.delay = delay;
  }

  Task setDelay(int delay) {
    this.delay=delay;
    return this;
  }

  int getDelay() {
    return delay;
  }
}
