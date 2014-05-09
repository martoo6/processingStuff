import controlP5.*;

int hs[][];

ControlP5 cp5;
Accordion accordion;
DropdownList d1;

ArrayList<trigFunc> waves = new ArrayList<trigFunc>();

void setup() {
  size(700, 500);
  background(0);
  hs=new int[width][height];

  //Control configuration

  cp5 = new ControlP5(this);

  cp5.addTab("hide")
    .activateEvent(true)
      .setId(2)
        ;

  cp5.getTab("default")
    .activateEvent(true)
      .setLabel("Configuration")
        .setId(1)
          ;

  Button b1= cp5.addButton("newWave")
    .setValue(0)
      .setSize(200, 20)
        .setLabel("New Effect")
          .setPosition(10, 40)
            ;


  d1 = cp5.addDropdownList("d1")
    .setPosition(10, 90)
      .setBarHeight(20)
        .setSize(200, 200)
          .setItemHeight(20);



  accordion = cp5.addAccordion("acc").setSize(50, 50).setPosition(220, 40);

  //d1.moveTo("default");
  //accordion.moveTo("default");

  ArrayList<String> lItems = new ArrayList<String>();

  lItems.add("tSinX");
  lItems.add("tSinY");  
  lItems.add("tSinXpY");
  lItems.add("tSinXxY");
  lItems.add("tDiag1");
  lItems.add("tDiag2");
  lItems.add("tDiag3");
  lItems.add("tDist2");
  lItems.add("tDist3");
  lItems.add("tDist4");
  lItems.add("tCirc");
  lItems.add("tCirc2");

  d1.addItems(lItems);
}

void draw() {

  background(0);

  //RealCode !

  float a=255; //Amplitude
  float p=1; //Phase 
  float f=1.01; //Frequency
  float aa=0.1;

  if(waves.size()>0){
    for(trigFunc t: waves) t.anim();
    for (int y=0;y<height;y++) {
      for (int x=0;x<width;x++) {
        float calc=0;
        for(trigFunc t: waves) calc+=t.calc(x, y);
        calc=(calc/waves.size())*255;
        color c = color(calc);
        set(x, y, c);
      }
    }
  
  }
}


public void newWave() {
  if (d1!=null) {
    String name= d1.getItem((int)d1.getValue()).getName();
    
    int n=waves.size();
    
    trigFunc t=new tSinX();
    
    if (name=="tSinX")   t=new tSinX();
    if (name=="tSinY")   t=new tSinY();  
    if (name=="tSinXpY") t=new tSinXpY();
    if (name=="tSinXxY") t=new tSinXxY();
    if (name=="tDiag1")  t=new tDiag1();
    if (name=="tDiag2")  t=new tDiag2();
    if (name=="tDiag3")  t=new tDiag3();
    if (name=="tDist2")  t=new tDist2();
    if (name=="tDist3")  t=new tDist3();
    if (name=="tDist4")  t=new tDist4();
    if (name=="tCirc")   t=new tCirc();
    if (name=="tCirc2")  t=new tCirc2();
    
    waves.add(t);    
    
    ControlGroup g = cp5.addGroup("group"+n).setLabel(t.toString());
    
    Slider freq = cp5.addSlider("freq"+n).setPosition(0,0).setSize(200,20).moveTo(g).setMax(1).setDefaultValue(1).setDecimalPrecision(3);
    Slider phase = cp5.addSlider("phase"+n).setPosition(0,30).setSize(200,20).moveTo(g).setMax(TWO_PI);
    Slider amp = cp5.addSlider("amp"+n).setPosition(0,60).setSize(200,20).moveTo(g);
    Slider speed = cp5.addSlider("speed"+n).setPosition(0,90).setSize(200,20).moveTo(g);
    Button anim = cp5.addButton("anim"+n).setPosition(250,90).setSize(20,20).moveTo(g).setLabel("Animate");
    Button delete = cp5.addButton("delete"+n).setPosition(0,120).setSize(40,30).moveTo(g).setLabel("Delete");
    
    ControlListener l1 = new FreqControlListener(t,freq, phase, amp, speed, anim, delete, g);
    
    accordion.addItem(g).setWidth(250);
  }
}

class FreqControlListener implements ControlListener{
  trigFunc t;
  Slider freq, phase, amp, speed;
  Button anim, delete;
  ControlGroup controlGroup;
  FreqControlListener(trigFunc t,Slider freq,Slider phase,Slider amp, Slider speed, Button anim, Button delete, ControlGroup controlGroup){
    this.t=t;
    this.freq=freq;
    this.phase=phase;
    this.amp=amp;
    this.speed=speed;
    this.anim=anim;
    this.delete=delete;
    this.controlGroup=controlGroup;
    
    freq.addListener(this);
    phase.addListener(this);
    amp.addListener(this);
    anim.addListener(this);
    speed.addListener(this);
    delete.addListener(this);
  }
  public void controlEvent(ControlEvent theEvent){
    if(theEvent.getController()==freq) t.setFreq(theEvent.getController().getValue());
    if(theEvent.getController()==phase) t.setPhase(theEvent.getController().getValue());
    if(theEvent.getController()==speed) t.speedAnim(theEvent.getController().getValue());
    if(theEvent.getController()==anim) t.toogleAnim();
    if(theEvent.getController()==delete) {
      waves.remove(t);
      accordion.remove(controlGroup);
    }
    //if(theEvent.getController()==freq) t.setAmp(theEvent.getController().getValue());
  }
}

//Classes

abstract class trigFunc {
  float p=1;//Phase
  float f=1;//Frequency
  float s=1;//speed
  boolean anim;

  abstract float calc(float x, float y);
  
  String toString(){
    
    return this.getClass().getSimpleName();
  }
  
  trigFunc setPhase(float p) {
    this.p=p;
    return this;
  }

  trigFunc setFreq(float f) {
    this.f=f;
    return this;
  }
  
  trigFunc toogleAnim() {
    anim=!anim;
    return this;
  }
  
  trigFunc anim() {
    if(anim) p=frameCount*s;
    return this;
  }
  
  trigFunc speedAnim(float s) {
    this.s=s;
    return this;
  }
}

class tSinX extends trigFunc {
  float calc(float x, float y) {
    return sin(x*f+p);
  }
}

class tSinY extends trigFunc {
  float calc(float x, float y) {
    return sin(y*f+p);
  }
}

class tSinXxY extends trigFunc {
  float calc(float x, float y) {
    return sin(x*y*f+p);
  }
}

class tSinXpY extends trigFunc {
  float calc(float x, float y) {
    return sin((x+y)*f+p);
  }
}

class tCirc2 extends trigFunc {
  float calc(float x, float y) {
    return cos(x*f+p)*sin(y*f+p);
  }
}

class tCirc extends trigFunc {
  float calc(float x, float y) {
    return cos(x*f+p)+sin(y*f+p);
  }
}

class tDiag1 extends trigFunc {
  float calc(float x, float y) {
    return sin((x+y)*f+p);
  }
}

class tDiag2 extends trigFunc {
  float calc(float x, float y) {
    return sin((x-y)*f+p);
  }
}

class tDiag3 extends trigFunc {
  float calc(float x, float y) {
    return x>=width/2?sin((x+y)*f+p):sin((x-y)*f+p);
  }
}

class tDist4 extends trigFunc {
  float calc(float x, float y) {
    return sin(abs(width/2-x)*f+abs(height/2-y)*f+p);
  }
}

class tDist2 extends trigFunc {
  float calc(float x, float y) {
    return sin((pow(width/2-x, 2)+pow(height/2-y, 2))*f+p); //Distance not euclidian, ergo..higher frequency when gatting away from center...
  }
}

class tDist3 extends trigFunc {
  float calc(float x, float y) {
    return sin(sqrt((pow(width/2-x, 2)+pow(height/2-y, 2))*f)+p); //Perfect circle
  }
}

class tSinc2 extends trigFunc {
  float calc(float x, float y) {
    return sin(x*f+p)+sin(y*f+p);
  }
}
