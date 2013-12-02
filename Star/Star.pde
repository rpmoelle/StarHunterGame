/*Rachel Moeller
Star Hunter

Thank you Michelle Ma for velocity function.
Thank you Adam Guthrie for sound composition.
*/
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;

Minim minim;
AudioPlayer comet1;
AudioPlayer comet2;
AudioPlayer comet3;

Serial port;
float velocity=0.0;
int lf=10;

boolean isOver;
ArrayList<Constellation> sky;
ArrayList<Comet> comets;
int numConstellations=10;
Clouds bg;
void setup()
{
  isOver=false;
  size(600,400);
  port= new Serial(this,"COM3",9600);
  port.bufferUntil(lf);
  bg=new Clouds();
  
  minim = new Minim(this);
  comet1 = minim.loadFile("comet1.wav");
  comet2 = minim.loadFile("comet2.wav");
  comet3 = minim.loadFile("comet3.wav");
  
  
  comets=new ArrayList<Comet>();
  sky=new ArrayList<Constellation>();
  for(int i=0;i<10;i++)
  {
    float h=random(50,150);
    float w=random(50,150);
    float x=random(w,width-w);
    float y=random(h,height-h);
    sky.add(new Constellation(x,y,w,h,100));
  }
}

void draw()
{
 println(velocity);
  background(0);
  bg.render();
  for(int i=0;i<numConstellations;i++)
  {
    sky.get(i).update();
    sky.get(i).render();
  }
  
  for(int i=0;i<comets.size();i++)
  {
    comets.get(i).update();
    comets.get(i).render();
  }
  
  if(numConstellations<1)
  {
    for(int i=0;i<comets.size();i++)
    {
      if(i<comets.size()-1)
      {
        Comet comet1=comets.get(i);
        Comet comet2=comets.get(i+1);
        stroke(255);
        line(comet1.x,comet1.y,comet2.x,comet2.y);
        noFill();
        ellipse(comet1.x,comet1.y,comet1.r*2,comet1.r*2);
      }
    }
    isOver=true;
  }
  
  for(int i=0;i<numConstellations;i++)
  {
    for(int j=0;j<comets.size();j++)
    {
    if(sky.get(i).isCollide(comets.get(j).x,comets.get(j).y))
    {
      sky.get(i).a=0;
      numConstellations-=1;
    }
    }
  }
  
  
}


void mouseClicked()
{
  if(numConstellations>0)
  {
    comets.add(new Comet(mouseX,mouseY));
    int r=int(random(1,4));
    if(r==1)
      {
      AudioPlayer comet1= minim.loadFile("comet1.wav");
      comet1.play();
      }
    if(r==2)
     {
      AudioPlayer comet2= minim.loadFile("comet2.wav");
      comet2.play();
      }
    if(r==3)
     {
      AudioPlayer comet3= minim.loadFile("comet3.wav");
      comet3.play();
      }
  }
  if(isOver)
  {
  isOver=false;
  bg=new Clouds();
  comets=new ArrayList<Comet>();
  sky=new ArrayList<Constellation>();
  for(int i=0;i<10;i++)
  {
    float h=random(50,150);
    float w=random(50,150);
    float x=random(w,width-w);
    float y=random(h,height-h);
    sky.add(new Constellation(x,y,w,h,100));
  }
  numConstellations=10;
  }
}


void serialEvent(Serial port)
{
  velocity=float(port.readStringUntil(lf));
  velocity=map(velocity,1,6,1,30);
  float x=random(30,width-30);
  float y=velocity*30;
   if(numConstellations>0)
  {
    comets.add(new Comet(x,y));
    int r=int(random(1,4));
  if(r==1)
      {
      AudioPlayer comet1= minim.loadFile("comet1.wav");
      comet1.play();
      }
    if(r==2)
     {
      AudioPlayer comet2= minim.loadFile("comet2.wav");
      comet2.play();
      }
    if(r==3)
     {
      AudioPlayer comet3= minim.loadFile("comet3.wav");
      comet3.play();
      }
    
  }
}
  
