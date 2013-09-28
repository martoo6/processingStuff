import processing.pdf.*;
import java.util.Iterator;
import java.util.Map;
import de.bezier.data.sql.*;

//Sumarle la libreria ANI

SQLite db;
String[] lines;
int index = 0;
HashMap hm;

int cantPalabras=3500;
float size[]=new float[cantPalabras];
PVector pos[]=new PVector[cantPalabras];
//int tam=3000;
int tam=700;
color paletas [][]={{#8D7966,#A8A39D,#D8C8B8,#E2DDD9,#F8F1E9},
                   {#FC5810,#EE15A2,#702BFF,#1FCD51,#FAD703},
                   {#ECD078,#D95B43,#C02942,#542437,#53777A},
                   {#12354B,#0577AB,#EEE9E3,#EEBF35,#C42329},                   
                   {#FFFFFF,#000000,#FFFFFF,#000000,#FFFFFF},                   
                   {#070E2B,#BF7D75,#6A314F,#12354B,#FFFFFF},                   
                   {#80B4E6,#68AB8F,#E53491,#EEE9E3,#000000},                   
                   {#F5DD9F,#727D8E,#FC0487,#C42329,#FFFFFF},                   
                   {#0665B9,#EAF3C6,#AC1E69,#0577AB,#000000},                   
                   {#0665B9,#EAF3C6,#AC1E69,#0577AB,#000000}
                  };

void setup() {
  //size(tam, tam, PDF, "resultado.pdf");
  size(tam, tam);
  //background(0);
  noLoop();
  smooth();
  noStroke();
  db = new SQLite( this, "db.sqlite");  // open database file
  lines = loadStrings("Tolkien - La comunidad del anillo2.txt");
  int wordCount=0;

  //si falla la conexion a la bd nada mas importa..
  if ( db.connect() )
  {
    //Cuento la cantidad de palabras para generar el hashmap
    println(lines.length);
    while (index < lines.length) {
      String[] pieces = splitTokens(lines[index], ", ();:.¿?¡!-");
      wordCount+=pieces.length;
      index = index + 1;
    }

    hm = new HashMap(wordCount);
    index=0;

    //Leo linea por linea ingresando las palabras en el hashmap
    println("Llenamos el hashmap !");
    while (index < lines.length) {
      String[] pieces = splitTokens(lines[index], ", ();:.¿?¡!-");
      for (int i=0;i<pieces.length;i++) {
        if (hm.containsKey(pieces[i])) {
          hm.put(pieces[i], ((Integer)hm.get(pieces[i]))+1);
        }
        else {
          hm.put(pieces[i], 1);
        }
      }
      index = index + 1;
    }


    Iterator i = hm.entrySet().iterator();

    println("Llenamos la Base de Datos !");
    int a=0;
    db.execute("begin");
    db.execute("DELETE FROM words");
    while (i.hasNext ()) {
      Map.Entry me = (Map.Entry)i.next();
      db.execute("Insert into words (word,cant) values ('"+me.getKey()+"',"+me.getValue()+")");
      a++;
    }
    db.execute("end");
    println("Hicimos "+a+" inersiones");
  }
}

void draw() {
    fill(0);
    rect(0,0,tam,tam);
  
    //db.query( "Select sum(cant) as cant from words where length(word)>4" );
    //db.query( "Select sum(cant) as cant from words" );
    db.query("Select sum(cant) as cant from words where word in ('Anborn','Angbor','Aragorn','Arod','Arwen','Asfaloth','Bárbol','Baya','Beregond','Bergil','Bilbo','Bill','Helechal','Bob','Sauron','Boromir','Campanilla','Buenchico','Cebadilla','Mantecona','Celeborn','Ceorl','Corteza','Crinblanca','Dáin','Damrod','Déagol','Denethor','Derufin','Dervorin','Drogo','Duilin','Duinhir','Dwimmerlaik','Déorwine','Dúnhere','Eldarion','Elfhelm','Ella-Laraña','Elladan','Elrohir','Elrond','Éomer','Éothain','Éowyn','Erestor','Erkenbrand','Faramir','Amroth','Fíriel','Forlong','Fredegar','Bolger','Frodo','Bolsón','Galadriel','Gamelin','Samsagaz','Gamyi','Gandalf','Ghân-buri-Ghân','Gildor','Gilraen','Gimli','Glóin','Glorfindel','Gléowine','Golasgil','Gollum','Gorbag','Terronillo','Gothmog','Gríma','Grimbold','Grishnákh','Guthlaf','Gwaihir','Halbarad','Haldir','Háma','Hamfast','Gamyi','Hasufel','Hayala','Hirgon','Hirluin','Imrahil','Ingold','Ioreth','Khamûl','Lagduf','Landroval','Legolas','Lindir','Lobelia','Lotho','Lugdush','Mablung','Maggot','Mauhúr','Meneldor','Meriadoc','Morwen','Muzgash','Nob','Paladin','Peregrin','Perla Tuk','Prímula','Brandigamo','Póney Bill','Radagast','Radbug','Ramaviva','Roheryn','Rosita Coto','Rúmil','Sacovilla-Bolsón','Saruman','Sauron','Nazgûl','Shagrat','Sméagol','Snaga','Snaga','Sombragrís','Stybba','Ted Arenas','Théoden','Théodred','Tolman Coto','Tom Bombadil','Ufthak','Uglúk','Hombre-Sauce','Widfara','Will Pieblanco','Zarcillo') order by cant desc");
    db.next ();
    float cantTotal=db.getFloat("cant");
    println("La cantidad total de palabras es: "+cantTotal);

    //db.query( "Select * from words where length(word)>4 order by cant desc limit "+cantPalabras );
    //db.query( "Select * from words order by cant desc limit "+cantPalabras );
    db.query("Select * from words where word in ('Anborn','Angbor','Aragorn','Arod','Arwen','Asfaloth','Bárbol','Baya','Beregond','Bergil','Bilbo','Bill','Helechal','Bob','Sauron','Boromir','Campanilla','Buenchico','Cebadilla','Mantecona','Celeborn','Ceorl','Corteza','Crinblanca','Dáin','Damrod','Déagol','Denethor','Derufin','Dervorin','Drogo','Duilin','Duinhir','Dwimmerlaik','Déorwine','Dúnhere','Eldarion','Elfhelm','Ella-Laraña','Elladan','Elrohir','Elrond','Éomer','Éothain','Éowyn','Erestor','Erkenbrand','Faramir','Amroth','Fíriel','Forlong','Fredegar','Bolger','Frodo','Bolsón','Galadriel','Gamelin','Samsagaz','Gamyi','Gandalf','Ghân-buri-Ghân','Gildor','Gilraen','Gimli','Glóin','Glorfindel','Gléowine','Golasgil','Gollum','Gorbag','Terronillo','Gothmog','Gríma','Grimbold','Grishnákh','Guthlaf','Gwaihir','Halbarad','Haldir','Háma','Hamfast','Gamyi','Hasufel','Hayala','Hirgon','Hirluin','Imrahil','Ingold','Ioreth','Khamûl','Lagduf','Landroval','Legolas','Lindir','Lobelia','Lotho','Lugdush','Mablung','Maggot','Mauhúr','Meneldor','Meriadoc','Morwen','Muzgash','Nob','Paladin','Peregrin','Perla Tuk','Prímula','Brandigamo','Póney Bill','Radagast','Radbug','Ramaviva','Roheryn','Rosita Coto','Rúmil','Sacovilla-Bolsón','Saruman','Sauron','Nazgûl','Shagrat','Sméagol','Snaga','Snaga','Sombragrís','Stybba','Ted Arenas','Théoden','Théodred','Tolman Coto','Tom Bombadil','Ufthak','Uglúk','Hombre-Sauce','Widfara','Will Pieblanco','Zarcillo') order by cant desc");
    int cant;
    
    /*float scale=600;
    float scale2=220;
    float tamMin=1;*/
    float scale=1600;
    //float scale2=125;
    float scale2=25;
    float tamMin=1;
    
    int a=0;
    textAlign(CENTER);
    while (db.next ()) {
      cant=db.getInt("cant");
      size[a]=log((cant/cantTotal)*scale+tamMin)*scale2;
      textSize((size[a]/5));
      
      //pos[a]=new PVector(random(150, tam-150), random(150, tam-150));
      pos[a]=new PVector(random(20, tam-20), random(20, tam-20));
      while(estaOcupado(pos[a],size[a],a)){
        pos[a].set(random(100, tam-150), random(100, tam-150),0);
      }
      
      int paleta=0;
      int invertir=4;
      if(cant<=200){
        fill(paletas[paleta][invertir-0]);
      }
      if(cant>200){
        fill(paletas[paleta][invertir-1]);
      }
      if(cant>400){
        fill(paletas[paleta][invertir-2]);
      }
      if(cant>800){
        fill(paletas[paleta][invertir-3]);
      }
      if(cant>1500){
        fill(paletas[paleta][invertir-4]);
      }

      ellipse(pos[a].x, pos[a].y, size[a], size[a]);
      fill(0);
      text(db.getString("word"), pos[a].x, pos[a].y);
      a++;
    }
    
    println("FIN");
    //exit();
}

boolean estaOcupado(PVector currPos,float currSize, int cant){
  if((currPos.x-(currSize/2)<0)||(currPos.y-(currSize/2)<0)||(currPos.x+(currSize/2)>tam)||(currPos.y+(currSize/2)>tam)){
    return true;
  }
  for(int i=0;i<cant;i++){
    if((PVector.dist(pos[i],currPos)-((currSize+size[i])/2))<2){
      return true;
    }
  }
  return false;
}
