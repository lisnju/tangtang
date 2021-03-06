import ddf.minim.*;

int DEFAULT_XIAN_NUM =7;
Xian[] xian;
float[] xianHight;
int FrameRate = 30;
int DEFAULT_PLAY_TIME = 2 ;// 2s play time
float DEFAULT_AMP=6;
float EPS = 5;
Minim minim;

void setup(){
  size(640,360);
  frameRate(FrameRate);
  minim = new Minim(this);
  
  // draw static Xian 
  float xianHead=width;
  float xianTail=0;
  float xianTop = height*0.2;
  float xianBottom = height*0.95;
  
  float xianOffset=(xianBottom-xianTop)/(DEFAULT_XIAN_NUM-1);
  EPS=xianOffset*0.3;
  xian = new Xian[DEFAULT_XIAN_NUM];
  float [] xianHeight = new float[DEFAULT_XIAN_NUM];
  for(int i = 0; i<DEFAULT_XIAN_NUM; ++i){
     
     float currentXianHeight = xianTop + xianOffset * i;
     xianHeight[i] = currentXianHeight;
     xian[i]= new Xian(i+1,xianHead,currentXianHeight,xianTail,currentXianHeight);
  }
  
}
  
// Drag (click and hold) your mouse across the 
// image to change the value of the rectangle
void mouseDragged() {
     for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].crossed(pmouseX,pmouseY,mouseX,mouseY)){
       int status = 1;
       play(i,status,DEFAULT_AMP,0,mouseX);
     }
   }
}

void mouseMoved(){
  
   for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].crossed(pmouseX,pmouseY,mouseX,mouseY)){
       int status = 1;
       play(i,status,DEFAULT_AMP,0,mouseX);
     }
   }
       
}

void mouseClicked(){
  
   for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].near(mouseX,mouseY)){
       int status = 3;
       play(i,status,DEFAULT_AMP*0.3,0,mouseX);
     }
   }
       
}
void play (int i,int status,float a, float l, float r){ // xian index, vibrate status(0 still,1 san,2 an,3 fan), amplitude, lefthand position, right hand position, amplitude
  xian[i].play(status,a,l,r);
 // audioTest();
}




void draw(){
  
  background(0);
  for (int i = 0; i < DEFAULT_XIAN_NUM; ++i){
    xian[i].update();
  }
}

void stop(){
  for(int i =0;i<DEFAULT_XIAN_NUM;i++){
    xian[i].stop();
  }
  minim.stop();
  super.stop();
}
