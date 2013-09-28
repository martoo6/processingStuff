int myItems=5;
int hItems = 10;
int vItems = 5;
int itemSize=50;
Slot currentSlot;  
long lastTime=0;

ArrayList<Slot> chestSlots = new ArrayList<Slot>(); 
ArrayList<Slot> myBagSlots = new ArrayList<Slot>();
;
ArrayList<Slot> allSlots = new ArrayList<Slot>();


void setup() {
  size(800, 600);
  background(50);
  textSize(18);
  noCursor();
  loadSlots();
  loadItems();
}

void draw() {
  background(50);
  //Items superiores
  for (Slot slot:chestSlots) slot.render(); 
  //Valija Actual
  if (myBagSlots!=null) for (Slot slot:myBagSlots) slot.render();
  fill(255);
  text("Items en valija actual",50,340);
  fill(0);
  stroke(255);
  strokeWeight(1);
  triangle(mouseX, mouseY, mouseX +10, mouseY, mouseX, mouseY + 10);
  if (currentSlot!=null) image(currentSlot.componentItem.img, mouseX, mouseY);
}

void loadSlots() {
  for (int i=0;i<hItems;i++) for (int e=0;e<vItems;e++) chestSlots.add(new Slot(new PVector(itemSize+i*itemSize, 50+e*itemSize)));
  for (int i=0;i<5;i++) myBagSlots.add(new Slot(new PVector(itemSize+i*itemSize, 350)));
  allSlots.addAll(chestSlots);
  allSlots.addAll(myBagSlots);
}

void loadItems() {
  ComponentItem[] tmpItems = {  
    new Item("Gema", "./Item1.png", 50), 
    new Item("Item 1", "./Item2.png", 50), 
    new Item("Item 1", "./Item3.png", 50), 
    new Item("Item 1", "./Item4.png", 50), 
    new Item("Item 1", "./Item5.png", 50), 
    new Item("Item 1", "./Item6.png", 50), 
    new Item("Item 1", "./Item7.png", 50), 
    new Item("Item 1", "./Item8.png", 50), 
    new CompositeItem("Bag", "./Bag.png", 50)
    };
    for (Slot slot:chestSlots) slot.setItem(tmpItems[(int)random(tmpItems.length)].clone());
}

void mousePressed() {
  if (millis()-lastTime<500) {
    lastTime = millis();
  }
  for (Slot slot:allSlots) if (mouseX>slot.pos.x && mouseX<slot.pos.x+50 && mouseY>slot.pos.y && mouseY<slot.pos.y+50 )  currentSlot = slot;
}

void mouseReleased() {
  if (currentSlot!=null) {
    
    Slot destSlot = new Slot(new PVector(0,0));
    
    for (Slot slot:allSlots) if (mouseX>slot.pos.x && mouseX<slot.pos.x+50 && mouseY>slot.pos.y && mouseY<slot.pos.y+50 ) destSlot = slot; 
    
        if (destSlot.componentItem==null) {
          if(myBagSlots.contains(currentSlot) && currentSlot.componentItem.parent!=null) currentSlot.componentItem.parent.childs.remove(currentSlot.componentItem);
          destSlot.setItem(currentSlot.componentItem);
          currentSlot.componentItem=null;
        }
        else { 
          if (destSlot.componentItem.isComposite() && destSlot!=currentSlot && ((CompositeItem)destSlot.componentItem).childs.size()<5) {
            if(myBagSlots.contains(currentSlot) && currentSlot.componentItem.parent!=null) currentSlot.componentItem.parent.childs.remove(currentSlot.componentItem);
            ((CompositeItem)destSlot.componentItem).addChild(currentSlot.componentItem);
            currentSlot.componentItem=null;
          }
        }

      if (destSlot==currentSlot && destSlot.componentItem.isComposite()) {
        CompositeItem currentItem = (CompositeItem)currentSlot.componentItem;
        for (int i=0;i<myBagSlots.size();i++) {
          if (i>=currentItem.childs.size()) {
            myBagSlots.get(i).setItem(null);
          }
          else {
            myBagSlots.get(i).setItem(currentItem.childs.get(i));
          }
        }

        int x=0, y=0;
        for (Slot tmpSlot:myBagSlots) {
          tmpSlot.pos.x = 50 + 50*x;
          tmpSlot.pos.y = 350+ 50*y;
          if (x>10) {
            x=-1;
            y++;
          }
          x++;
        }
      }
      
    currentSlot=null;
  }
}

