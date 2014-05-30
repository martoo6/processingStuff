PImage img, img2;

void setup(){
  img = loadImage("http://www.processingcities.org/wp-content/uploads/2011/12/Processing_Bordeaux_background_test_pcities.jpg");
  img2 = loadImage("http://www.processingcities.org/wp-content/uploads/2011/12/Processing_Bordeaux_background_test_pcities.jpg");
  size(img.width,img.height);  
  noSmooth();
  
  /*for(int y=0;y<img.height;y++){
    for(int x=0;x<img.width;x++){
      if(img.get(x,y)!=img2.get(x,y)){
        println("Not the same en ",x,y);
        break;
      }
    }
  }*/
}

void draw(){
  //This two are the same
  //img.copy(img.get(),0,0,img.width,img.height,0,0,img.width,img.height);
  //img.copy(img,0,0,img.width,img.height,0,0,img.width-1,img.height-1);
  
  //This doesnt work either..its not making the copy right


  img.copy(img.get(),0,0,img.width,img.height,0,0,img.width,img.height);  
  //Doesn't work with another image either
  //img2.copy(img,0,0,img.width,img.height,0,0,img.width,img.height);
  
  println("Blue: ", blue(img.get(40,40)), "Red: ", red(img.get(40,40)), "Green: ", green(img.get(40,40)));
  
  image(img,0,0);
}
