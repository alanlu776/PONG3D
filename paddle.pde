class Paddle {
  PVector pos;
  float r;
  boolean isfront;
  float w;
  boolean isAI;

  Paddle(boolean _isfront) {
    isfront = _isfront;
    if(isfront) {
      pos = new PVector(0, 0, 50);
    } else {
      pos = new PVector(0, 0, -50);
    }
    r = 20;
    w = 5;
    isAI = false;
  }

  void move(float x, float y) {
    pos.x += x;
    pos.y += y;
    if(pos.x+r/2 > 50) pos.x = 50-r/2;
    if(pos.x-r/2 < -50) pos.x = -50+r/2;
    if(pos.y+r/2 > 50) pos.y = 50-r/2;
    if(pos.y-r/2 < -50) pos.y = -50+r/2;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(r, r, w);
    popMatrix();
  }
}

class AIPaddle extends Paddle {
  PVector vel;
  
  AIPaddle(boolean _isFront){
    super(_isFront);
    vel = new PVector(0, 0, 0);
    isAI = true;
  }
  
  void aimove(Ball b){
    vel.mult(0);
    if(!isfront){
      if(b.pos.z < 10){
        if((b.pos.x > pos.x) && (abs(b.pos.x-pos.x) > r/2)){
          vel.x = 1;
        } else if((b.pos.x < pos.x) && (abs(b.pos.x-pos.x) > r/2)){
          vel.x = -1;
        }
        if((b.pos.y > pos.y) && (abs(b.pos.x-pos.x) > r/2)){
          vel.y = 1;
        } else if((b.pos.y < pos.y) && (abs(b.pos.x-pos.x) > r/2)){
          vel.y = -1;
        }
      }
    } else {
      if(b.pos.z > -10){
        if((b.pos.x > pos.x) && (abs(b.pos.x-pos.x) > r/2)){
          vel.x = 1;
        } else if((b.pos.x < pos.x) && (abs(b.pos.x-pos.x) > r/2)){
          vel.x = -1;
        }
        if((b.pos.y > pos.y) && (abs(b.pos.x-pos.x) > r/2)){
          vel.y = 1;
        } else if((b.pos.y < pos.y) && (abs(b.pos.x-pos.x) > r/2)){
          vel.y = -1;
        }
      }
    }
    pos.add(vel);
    
    if(pos.x+r/2 > 50) pos.x = 50-r/2;
    if(pos.x-r/2 < -50) pos.x = -50+r/2;
    if(pos.y+r/2 > 50) pos.y = 50-r/2;
    if(pos.y-r/2 < -50) pos.y = -50+r/2;
  }
}