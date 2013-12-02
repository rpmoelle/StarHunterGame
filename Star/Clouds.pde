class Clouds
{
  int[] stars=new int[160];
  
  Clouds()
  {
    for(int i=0;i<160;i=i+4)
    {
     stars[i]= int(random(0,width));
     stars[i+1]=int(random(0,height));
     stars[i+2]=int(random(2,10));
     stars[i+3]=int(random(100,255));
    }
  }
  
  void render()
  {
    noStroke();
   for(int i=0;i<160;i=i+4)
   {
     fill(255,stars[i+3]);
     ellipse(stars[i],stars[i+1],stars[i+2],stars[i+2]);
   }
  }
  
  
}
