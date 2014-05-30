float t=1;void draw(){t+=0.01;stroke(0,noise(t)*255,(t*10)%255);line(cos(t)*50+50,sin(t)*50+50,50,50);}
