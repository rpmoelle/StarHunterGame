/*Star Hunter Accelerometer Data Harvest
*Rachel Moeller
Thank you Michelle Ma for the velocity function.
Thank you Adam Guthrie for sound composition.

flat x-- -1.3
thrown x-- -9.14
*/
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345.h>

/* Assign a unique ID to this sensor at the same time */
Adafruit_ADXL345 accel = Adafruit_ADXL345(12345);
float flatThresh=-1.3;
float thrownThresh=-8.0;
boolean throwOccured=false;

float computeVel(float a) {
  //THANK YOU MICHELLE MA
  // Will collect over 250 ms
  // Using trapezoid rule to compute estimated velocity
  float sum = 0;
  int samples = 25;
  int dt = 10;
  for (int i=0; i < samples; i++) {
    if ((i==0)||(i==(samples-1))) {
      sum += abs(a);
    } else {
      sum += 2*abs(a);
    }
    delay(dt);
  }
  //dt is in milliseconds
  float result = ((dt/1000.0)/2.0)*(sum);
  Serial.println(result);
  return result;
}

boolean isAThrow(float x)
{
 if(!throwOccured && x<=thrownThresh)
 {
   throwOccured=true;
   return true;
 }
 else if(throwOccured && x>thrownThresh)
 {
   throwOccured=false;
   return false;
 }
 return false;
}
void setup(void) 
{
  Serial.begin(9600);
  //Serial.println("Accelerometer Test"); Serial.println("");
  
  /* Initialise the sensor */
  if(!accel.begin())
  {
    /* There was a problem detecting the ADXL345 ... check your connections */
    //Serial.println("Ooops, no ADXL345 detected ... Check your wiring!");
    while(1);
  }

  /* Set the range to whatever is appropriate for your project */
  accel.setRange(ADXL345_RANGE_16_G);

  //Serial.println("");
}

void loop(void) 
{
  /* Get a new sensor event */ 
  sensors_event_t event; 
  accel.getEvent(&event);
  if(isAThrow(event.acceleration.x))
  {
    //Serial.print("Weeeeeee!");
    float vel=computeVel(event.acceleration.x);
    //Serial.println();
    
  }
 

  /* Display the results (acceleration is measured in m/s^2) */
  /*Serial.print("X: "); 
  Serial.print(event.acceleration.x); 
  Serial.print("  ");
  Serial.println();
  Serial.print(throwOccured);
  Serial.println();*/
  //Serial.println(event.acceleration.y);
  delay(50);
}
