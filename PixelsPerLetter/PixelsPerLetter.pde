import java.util.*;

void setup() { 
 size(30,30);
 HashMap hm = new HashMap();
 fill(255);
 PFont font = loadFont("Haettenschweiler-48.vlw");
 textFont(font,20);
 textAlign(CENTER);

 for (int i=65; i<91; i++) {
    background(0);
    text(char(i),width/2,height-(textDescent()+textAscent())/2); 
    loadPixels();
    int white=0;
    for (int k=0; k<pixels.length; k++) {
       white+=red(pixels[k]);
    }
    hm.put(char(i),white);
  }

  HashMap sorted = getSortedMap(hm);

  String asciiString = new String();

  for (Iterator<Map.Entry> i = sorted.entrySet().iterator(); i.hasNext();) { 
    Map.Entry me = (Map.Entry)i.next();
    asciiString += me.getKey();
  }

  println(asciiString); //the string in ascending pixel order

}

public HashMap getSortedMap(HashMap hmap) {
  HashMap map = new LinkedHashMap();
  List mapKeys = new ArrayList(hmap.keySet());
  List mapValues = new ArrayList(hmap.values());

  TreeSet sortedSet = new TreeSet(mapValues);
  Object[] sortedArray = sortedSet.toArray();
  int size = sortedArray.length;

  // a) Ascending sort

  for (int i=0; i<size; i++) {
    map.put(mapKeys.get(mapValues.indexOf(sortedArray[i])), sortedArray[i]);
  }
  return map;
}
