class Comet
{
  float x;
  float y;
  float r;
  float speed;
  float targetx;
  float targety;
  
  Comet(float tx,float ty)
  {
    targetx=tx;
    targety=ty;
    r=20;
    //Start at the top of the screen
    x=width/2;
    y=r;
  }
  
  void update()
  {
    
    //Illusion of depth, make the comet smaller as it approaches
    /*if(r>0){r-=.1;}
    else{r=0;}*/
    
    //Move the comet towards the target
    x=(0.95*x+0.05*targetx);
    y=(0.95*y+0.05*targety);
  }
  
  void render()
  {
    float a=sin(millis()/100);
    a=map(a,-1,1,50,200);
    fill(255,a);
    ellipse(x,y,r,r);
    ellipse(x,y,r/2,r/2);
    ellipse(x,y,r-2,r-2);
    ellipse(x,y,r-4,r-4);
  }
  
}
    
  
