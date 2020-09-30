// import the TUIO library
import TUIO.*;
// declare a TuioProcessing client
TuioProcessing tuioClient;

// these are some helper variables which are used
// to create scalable graphical feedback 
//fill(255);
  //   if(tobj.getSymbolID() == 1){
    // stroke(0,255,51);
    // fill(0,255,51);
     //text("1", tobj.getScreenX(width), tobj.getScreenY(height));
     //image(jupiter,tobj.getScreenX(width), tobj.getScreenY(height));
     
//     }
     //else if(tobj.getSymbolID() == 2){
     //stroke(64,0,0);
     //fill(64,0,0);
     //text("2", tobj.getScreenX(width), tobj.getScreenY(height));
     //image(saturn,tobj.getScreenX(width), tobj.getScreenY(height));
     //}
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;
PImage bg;
PImage jupiter;
PImage saturn;
PImage neptune;
PImage uranus;
PImage earth;
PImage mercury;
PImage venus;
PImage mars;
int y;
//
PImage img[];
int nPics = 8;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks

void setup()
{
  // GUI setup
  noCursor();
  size(2048,1536);
  noStroke();
  bg = loadImage("back.jpg");
  fill(0);
  
  // periodic updates
  if (!callback) {
    loop();
    frameRate(60);
  } else noLoop(); // or callback updates 
  
  font = createFont("Arial", 12);
  scale_factor = height/table_size;
  
  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  
  background(bg);
  
  img = new PImage[nPics];
  img[0] = loadImage("Pjup.png");
  img[1] = loadImage("sat.png");
  
  jupiter = loadImage("Pjup.png");
  saturn = loadImage("sat.png");
  neptune = loadImage("nep.png");
  uranus = loadImage("Pur.png");
  earth = loadImage("Pter.png");
  mercury = loadImage("Pmerc.png");
  venus = loadImage("Pven.png");
  mars = loadImage("Pmar.png");
  textFont(font,12*scale_factor);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 
   
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = tuioObjectList.get(i);
     //stroke(64,0,0);
     //fill(64,0,0);
     pushMatrix();
     textSize(26); 
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     rect(-obj_size/2,-obj_size/2,obj_size,obj_size);
     popMatrix();
     if (tobj.getSymbolID()>=0 && tobj.getSymbolID()<2){
     stroke(64,0,0);
     fill(64,0,0);
   //  text("3", tobj.getScreenX(width), tobj.getScreenY(height));
     image(img[tobj.getSymbolID()],tobj.getScreenX(width), tobj.getScreenY(height));
    
     }
     
    else if(tobj.getSymbolID() == 3){
     stroke(64,0,0);
     fill(64,0,0);
     text("3", tobj.getScreenX(width), tobj.getScreenY(height));
     image(neptune,tobj.getScreenX(width), tobj.getScreenY(height));
     }
     else if(tobj.getSymbolID() == 4){
     stroke(64,0,0);
     fill(64,0,0);
     text("4", tobj.getScreenX(width), tobj.getScreenY(height));
     image(uranus,tobj.getScreenX(width), tobj.getScreenY(height));
     }
     else if(tobj.getSymbolID() == 5){
       
     stroke(64,0,0);
     fill(64,0,0);
     text("5", tobj.getScreenX(width), tobj.getScreenY(height));
     image(earth,tobj.getScreenX(width), tobj.getScreenY(height));
     }
     else if(tobj.getSymbolID() == 6){
     stroke(64,0,0);
     fill(64,0,0);
     text("6", tobj.getScreenX(width), tobj.getScreenY(height));
     image(mercury,tobj.getScreenX(width), tobj.getScreenY(height));
     }
     else if(tobj.getSymbolID() == 7){
     stroke(64,0,0);
     fill(64,0,0);
     text("7", tobj.getScreenX(width), tobj.getScreenY(height));
     image(venus,tobj.getScreenX(width), tobj.getScreenY(height));
     }
     else if(tobj.getSymbolID() == 8){
     stroke(64,0,0);
     fill(64,0,0);
     text("8", tobj.getScreenX(width), tobj.getScreenY(height));
     image(mars,tobj.getScreenX(width), tobj.getScreenY(height));
     }
 
 }
   
   ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
   for (int i=0;i<tuioCursorList.size();i++) {
      TuioCursor tcur = tuioCursorList.get(i);
      ArrayList<TuioPoint> pointList = tcur.getPath();
      
      if (pointList.size()>0) {
        stroke(0,0,255);
        TuioPoint start_point = pointList.get(0);
        for (int j=0;j<pointList.size();j++) {
           TuioPoint end_point = pointList.get(j);
           line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
           start_point = end_point;
        }
        
        stroke(64,0,64);
        fill(64,0,64);
        ellipse( tcur.getScreenX(width), tcur.getScreenY(height),cur_size,cur_size);
        fill(0);
        text(""+ tcur.getCursorID(),  tcur.getScreenX(width)-5,  tcur.getScreenY(height)+5);
      }
   }
   
  ArrayList<TuioBlob> tuioBlobList = tuioClient.getTuioBlobList();
  for (int i=0;i<tuioBlobList.size();i++) {
     TuioBlob tblb = tuioBlobList.get(i);
     stroke(64);
     fill(64);
     pushMatrix();
     translate(tblb.getScreenX(width),tblb.getScreenY(height));
     rotate(tblb.getAngle());
     ellipse(0,0, tblb.getScreenWidth(width), tblb.getScreenHeight(height));
     popMatrix();
     fill(255);
     text(""+tblb.getBlobID(), tblb.getScreenX(width), tblb.getScreenY(height));
   }
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
          +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
