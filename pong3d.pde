import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PFont font;
int state; //0 is start screen, 1 is playing, 2 is paused

PeasyCam cam;
//AIPaddle front;
Paddle front;
Paddle back;
//AIPaddle back;
Ball ball;

boolean[] frontk = {false, false, false, false};
boolean[] backk = {false, false, false, false};
float roty;
boolean rotatepos = true;
boolean disablerot = false;

void setup() {
  size(1200, 1000, P3D);
  cam = new PeasyCam(this, 200);
  font = createFont("Courier", 40);
  //front = new AIPaddle(true);
  front = new Paddle(true);
  back = new Paddle(false);
  //back = new AIPaddle(false);
  ball = new Ball();
  state = 0;
  noFill();
  stroke(255);
  sphereDetail(20);
  textFont(font);
  textSize(7);
  //ortho();
}

void keyPressed() {
  if(key == CODED){
    if (keyCode == UP) frontk[0] = true;
    else if (keyCode == DOWN) frontk[1] = true;
    else if (keyCode == LEFT) frontk[2] = true;
    else if (keyCode == RIGHT) frontk[3] = true;
  } else {
    if(key == 'w') backk[0] = true;
    else if(key == 's') backk[1] = true;
    else if(key == 'a') backk[2] = true; //needs to be switched
    else if(key == 'd') backk[3] = true; //to account for perspective
    else if((key == ' ') && (state == 0)) state = 1;
    else if(((key == ' ') || (key == 'p') || (key == 'P')) && (state == 1)) state = 2;
    else if(((key == ' ') || (key == 'p') || (key == 'P')) && (state == 2)) state = 1;
  }
}

void keyReleased() {
  if(key == CODED){
    if (keyCode == UP) frontk[0] = false;
    else if (keyCode == DOWN) frontk[1] = false;
    else if (keyCode == LEFT) frontk[2] = false;
    else if (keyCode == RIGHT) frontk[3] = false;
  } else {
    if(key == 'w') backk[0] = false;
    else if(key == 's') backk[1] = false;
    else if(key == 'a') backk[2] = false; //needs to be switched
    else if(key == 'd') backk[3] = false; //to account for perspective
  }
}
void draw() {
  background(0);
  if(state == 1){
    if(!disablerot){
      rotateY(roty);
      rotateX(roty/4);
      if(rotatepos){
        roty += 0.001;
        if(roty > 0.5) rotatepos = false;
      } else {
        roty -= 0.001;
        if(roty < -0.5) rotatepos = true;
      }
    }
    textAlign(LEFT);
    text("P1 score:\n" + ball.frontscore, -100, 20, 50);
    textAlign(RIGHT);
    text("P2 score:\n" + ball.backscore, 100, 20, -50);
    box(100);

    front.display();
    back.display();
    ball.update();
    ball.display();
    ball.bouncepaddle(front);
    ball.bouncepaddle(back);
    if(!front.isAI){
      if(frontk[0]) front.move(0, -1);
      if(frontk[1]) front.move(0, 1);
      if(frontk[2]) front.move(-1, 0);
      if(frontk[3]) front.move(1, 0);
    } else {
      //front.aimove(ball);
    }
    
    if(!back.isAI){
      if(backk[0]) back.move(0, -1);
      if(backk[1]) back.move(0, 1);
      if(backk[2]) back.move(-1, 0);
      if(backk[3]) back.move(1, 0);
    } else {
      //back.aimove(ball);
    }
  } else if(state == 0){
    box(100);
    textAlign(CENTER);
    text("SPACE TO START", 0, -20, 0);
    text("P1: ARROW KEYS", 0, -10, 0);
    text("P2: WSAD", 0, 10, 0);
    text("P TO PAUSE", 0, 20, 0);
    ball.display();
    front.display();
    back.display();
  } else {
    if(!disablerot){
      rotateY(roty);
      rotateX(roty/4);
    }
    box(100);
    textAlign(CENTER);
    text("PAUSED", 0, 0, 0);
    textAlign(LEFT);
    text("P1 score:\n" + ball.frontscore, -100, 20, 50);
    textAlign(RIGHT);
    text("P2 score:\n" + ball.backscore, 100, 20, -50);
    ball.display();
    front.display();
    back.display();
  }
}