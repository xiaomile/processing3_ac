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
byte[] val_write =new byte[1];  
int y=640;
byte s1;
int new_time;
int old_time=0;
byte old_s=0;
void setup() {
  size(720,1280);
  smooth();
  ellipseMode(RADIUS);
  textSize(50);
  strokeWeight(5);
  bt.start();
  ArrayList names; 
  klist = new KetaiList(this, bt.getPairedDeviceNames());
  //System.out.println("run here!1");
}

void draw() { 
  background(80);
  fill(255);
  line(360,280,360,1000);
  fill(255,255,0);
  ellipse(360,y,50,50);
  s1=byte((y-280)*100/(1000-280));
  text(s1,200,y);
  if(mousePressed){
    if(abs(mouseX-360)<=50&&abs(mouseY-y)<=50&&mouseY>=280&&mouseY<=1000){
      y=mouseY;
    }
  }
  new_time= millis();
  if((new_time-old_time)>100){
  if(s1!=old_s){
    val_write[0] = s1;
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
