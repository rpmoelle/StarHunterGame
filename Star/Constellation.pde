class Constellation
{
  float x;
  float y;
  float w;
  float h;
  float a;
  float r;
  char drawType;
  char[] starForms={'c','a','s'};
  boolean notDead=true;
  
  Constellation()
  {
    x=100;
    y=100;
    w=20;
    h=20;
    a=100;
  }
  Constellation (float ax, float ay,float aw,float ah,float alpha)
  {
    x=ax;
    y=ay;
    w=aw;
    h=ah;
    a=alpha;
    r=10;
    int picker=int(random(0,3));
    drawType=starForms[picker];
  }
  
  void update()
  {
    if(a<0)
    {
      notDead=false;
    }
    
    if(notDead)
    {
      if(drawType=='c')
        {
          r=sin(millis()/250);
          r=int(map(r,-1,1,2,5));
        }
      if(drawType=='a')
        {
          r=sin(millis()/700);
          r=int(map(r,-1,1,2,5));
        }
      if(drawType=='s')
        {
          r=sin(millis()/500);
          r=int(map(r,-1,1,2,7));
        }
    }
    
  }
  
  void render()
  {
    stroke(255,a);
    //noFill();
    //rect(x,y,w,h);
    fill(255,a);
    drawStars();
  }
  
  void drawLayers(float px, float py)
  {
   for(int i=0;i<3;i++)
    {
     ellipse(px,py,r-i,r-i);
    } 
  }
  
  void drawStars()
  {
    float posx=x+(((x+w)-x)/2);
    float posy=y+(((y+h)-y)/2);
    float midx=(((posx)-x)/2);
    float midy=(((posy)-y)/2);
    float r2=r*2;
    if(drawType=='c')
    {
      r2=r*1.7;
      ellipse(x,posy,r,r);
      ellipse(x+midx,y+midy-5,r,r);
      line(x,posy,x+midx,y+midy-5);
      ellipse(posx,y,r,r);
      line(x+midx,y+midy-5,posx,y);
      ellipse(posx+midx,posy+midy,r,r);
      line(posx,y,x+w,posy);
      ellipse(x+w,posy,r,r);
      line(x+w,posy,posx+midx,posy+midy);
      ellipse(x+midx,posy+midy,r,r);
      line(posx+midx,posy+midy,posx,y+h);
      ellipse(posx,y+h,r,r);
      line(posx,y+h,x+midx,posy+midy);
      ellipse(posx+midx,y+midy,r,r);
      line(x+midx,posy+midy,x,posy);
      noFill();
      ellipse(x,posy,r2,r2);
      ellipse(x+midx,y+midy-5,r2,r2);
      ellipse(posx,y,r2,r2);
      ellipse(posx+midx,posy+midy,r2,r2);
      ellipse(x+w,posy,r2,r2);
      ellipse(x+midx,posy+midy,r2,r2);
      ellipse(posx,y+h,r2,r2);
      ellipse(posx+midx,y+midy,r2,r2);
      
    }
    if(drawType=='a')
    {
      ellipse(x,y,r,r);
      ellipse(posx,posy,r,r);
      line(x,y,posx,posy);
      ellipse(posx+(midx/2),posy,r,r);
      line(posx,posy,posx+(midx/2),posy);
      ellipse(posx,y+h,r,r);
      line(posx+(midx/2),posy,posx,y+h);
      noFill();
      ellipse(x,y,r2,r2);
      ellipse(posx,posy,r2,r2);
      ellipse(posx+(midx/2),posy,r2,r2);
      ellipse(posx,y+h,r2,r2);
    }
    if(drawType=='s')
    {
      r2=r*2.2;
      ellipse(posx,y,r,r);
      ellipse(x+midx,y+midy,r,r);
      line(posx,y,x+midx,y+midy);
      ellipse(posx+midx,posy,r,r);
      line(x+midx,y+midy,posx+midx,posy);
      ellipse(x+midx,y+h,r,r);
      line(posx+midx,posy,x+midx,y+h);
      noFill();
      ellipse(posx,y,r2,r2);
      ellipse(x+midx,y+midy,r2,r2);
      ellipse(posx+midx,posy,r2,r2);
      ellipse(x+midx,y+h,r2,r2);
      
    }
    
  }
  
  boolean isCollide(float cx,float cy)
  {
   if(cx>=x && cx<=x+w)
   {
     if(cy>=y && cy<=y+h)
     {
       return true;
     }
     return false;
   }
   return false;
  }

  
}
  
