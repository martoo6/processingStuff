int s = 1;//step
int e=0;
int startingHeight=0;

long numA = 1;
long numB = 1;

void setup(){
  size(1280,720);
  noStroke();
  background(0);
}

void draw(){
  int i=startingHeight;
  long tmp=numA+numB;
  for(Integer b:numberToBinary(tmp)){
    fill(b*255);
    rect(e*s,i*s,s,s);
    i++;
  }
  e++;
  if(e*s>=width)  {
    e = 0; 
    startingHeight = i;
  }
  numA=numB;
  numB=tmp;
  println(tmp);
}

ArrayList<Integer> numberToBinary(long number){
  ArrayList<Integer> res = new ArrayList<Integer>();
  
  while(number!=0){
    res.add(0,(number%2==0)? 0: 1);
    number=floor(number/2);
  }
  
  return res;
}

// Calculates the base-10 logarithm of a number
float log2 (int x) {
  return (log(x) / log(2));
}
