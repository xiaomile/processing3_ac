import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

KetaiBluetooth bt;//KetaiBluetooth
KetaiList klist; //KetaiList
boolean isConfiguring;
void onCreate(Bundle savedInstanceState) {
super.onCreate(savedInstanceState);
bt = new KetaiBluetooth(this);
}
void onActivityResult(int requestCode, int resultCode, Intent data) {
bt.onActivityResult(requestCode, resultCode, data);
}
byte[] val_read  =new byte[1]; 
byte[] val_write =new byte[3];  
int length3 = 250;
int y1 = 0;
int y2 = 0;
int y3 = 0;
int y4 = 0;
int x1 = 0;
int x2 = 0;
int x3 = 0;
int x4 = 0;
float w1,w2;
int y=640;
byte s1;
byte s2;
int new_time;
int old_time=0;
byte old_s=0;
byte old_s2=0;
void setup() {
  fullScreen();
  orientation(PORTRAIT);
  smooth();
  ellipseMode(RADIUS);
  textSize(50);
  strokeWeight(5);
  ArrayList names; 
  klist = new KetaiList(this, bt.getPairedDeviceNames());
  bt.start();
  y1 = int(pixelHeight/3);
  y2 = int(pixelHeight/3*2);
  y3 = y1-length3; 
  y4 = y2-length3;
  x1 = int(pixelWidth/2);
  x2 = int(pixelWidth/2);
  x3 = int(pixelWidth/2);
  x4 = int(pixelWidth/2);
  w1 = PI/2;
  w2 = PI/2;
  //System.out.println(x1);
  //System.out.println(pixelHeight);
}

void draw() { 
  
  background(80);
  fill(255,255,0);
  ellipse(x1,y1,50,50);
  fill(255,255,0);
  ellipse(x2,y2,50,50);
  
  if(mousePressed){
    if(dist(mouseX,mouseY,x3,y3)<=50&&mouseX>=(x1-length3-50)&&mouseX<=(x1+length3+50)&&dist(mouseX,mouseY,x1,y1)<=length3+50){
      if(mouseX>=(x1-length3)&&mouseX<=(x1+length3))
      x3=mouseX;
      else if(mouseX<(x1-length3))
      x3=x1-length3;
      else if(mouseX>(x1+length3))
      x3=x1+length3;
      w1 = acos(float(x3-x1)/length3);
      y3=y1-int(length3*sin(acos(float(x3-x1)/length3)));
      
      
      //System.out.println((length3*sin(acos(float(x3-x1)/length3))));
      //System.out.println(acos(float(x3-x1)/length3)/PI*180);
      fill(0,255,0);
      ellipse(x3,y3,50,50);
      fill(255,255,0);
      ellipse(x4,y4,50,50);
    }
    else if(dist(mouseX,mouseY,x4,y4)<=50&&mouseX>=(x2-length3-50)&&mouseX<=(x2+length3+50)&&dist(mouseX,mouseY,x2,y2)<=length3+50){
      if(mouseX>=(x2-length3)&&mouseX<=(x1+length3))
      x4=mouseX;
      else if(mouseX<(x2-length3))
      x4 = x2-length3;
      else if(mouseX>(x2+length3))
      x4 = x2+length3;
      w2 = acos(float(x4-x2)/length3);
      y4=y2-int(length3*sin(acos(float(x4-x2)/length3)));
      //System.out.println((length3*sin(acos(float(x3-x1)/length3))));
      //System.out.println(acos(float(x3-x1)/length3)/PI*180);
      fill(0,255,0);
      ellipse(x4,y4,50,50);
      fill(255,255,0);
      ellipse(x3,y3,50,50);
    }
    else {fill(255,255,0);
      ellipse(x3,y3,50,50);
      ellipse(x4,y4,50,50);}
  }
  else {fill(255,255,0);
  ellipse(x3,y3,50,50);
  ellipse(x4,y4,50,50);}
  fill(255);
  System.out.println(int(50*cos(w1-PI/2))+" "+int(50*sin(w1-PI/2)));
  line(x1+int(50*cos(w1-PI/2)),y1-int(50*sin(w1-PI/2)),x3+int(50*cos(w1-PI/2)),y3-int(50*sin(w1-PI/2)));
  line(x1+int(50*cos(w1+PI/2)),y1-int(50*sin(w1+PI/2)),x3+int(50*cos(w1+PI/2)),y3-int(50*sin(w1+PI/2)));
  line(x2+int(50*cos(w2-PI/2)),y2-int(50*sin(w2-PI/2)),x4+int(50*cos(w2-PI/2)),y4-int(50*sin(w2-PI/2)));
  line(x2+int(50*cos(w2+PI/2)),y2-int(50*sin(w2+PI/2)),x4+int(50*cos(w2+PI/2)),y4-int(50*sin(w2+PI/2)));
  s1=byte(int(acos(float(x3-x1)/length3)/PI*180));
  s2=byte(int(acos(float(x4-x2)/length3)/PI*180));
  text(str(int(acos(float(x3-x1)/length3)/PI*180)),x1-25,y1+100);
  text(str(int(acos(float(x4-x2)/length3)/PI*180)),x2-25,y2+100);
  /*
  line(360,280,360,1000);
  fill(255,255,0);
  ellipse(360,y,50,50);
  s1=byte((y-280)*100/(1000-280));
  text(s1,200,y);
  if(mousePressed){
    if(abs(mouseX-360)<=50&&abs(mouseY-y)<=50&&mouseY>=280&&mouseY<=1000){
      y=mouseY;
    }
  }*/
  new_time= millis();
  if((new_time-old_time)>50){
  if(s1!=old_s){
    val_write[0] = s1;
    val_write[1] = s2;
    val_write[2] = byte(255);
    bt.broadcast(val_write);
    old_s = s1;}
    old_time=new_time;
}
}

void onKetaiListSelection(KetaiList klist) {
String selection = klist.getSelection();
bt.connectToDeviceByName(selection);
//dispose of list for now
klist = null;
}
void onBluetoothDataEvent(String who, byte[] data) {
if (isConfiguring)
return;
val_read=data;
}
