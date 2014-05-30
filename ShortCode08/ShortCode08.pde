float t=1,i,c,r;void draw(){t+=0.1;for(i=0;i<100;i++,stroke((t*10)%255,(t*t)%255,t%255, 5),line(cos(t)*50+50,sin(t)*50+50,50,50));}
