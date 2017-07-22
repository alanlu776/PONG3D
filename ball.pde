class Ball {
  PVector pos;
  PVector vel;
  float r;
  int frontscore;
  int backscore;
  float rotx = 0;
  float roty = 0;
  
  Ball(){
    pos = new PVector(0, 0, 0);
    vel = PVector.random3D();
    //vel.mult(0.8);
    r = 5;
    frontscore = 0;
    backscore = 0;
  }
  
  void update(){
    pos.add(vel);
    vel.mult(1.0001);
    bounce();
  }
  
  void display(){
    pushMatrix();
    
    rotx += 0.01;
    roty += 0.01;
    translate(pos.x, pos.y, pos.z);
    rotateX(rotx);
    rotateY(roty);
    sphere(r);
    popMatrix();
    
    beginShape(); //rectangle at bottom
    if(pos.z-r > -50){
      vertex(-50, 50, pos.z-r);
      vertex(50, 50, pos.z-r);
    } else {
      vertex(-50, 50, -50);
      vertex(50, 50, -50);
    }
    if(pos.z+r < 50){
      vertex(50, 50, pos.z+r);
      vertex(-50, 50, pos.z+r);
    } else {
      vertex(50, 50, 50);
      vertex(-50, 50, 50);
    }
    endShape(CLOSE);
  }
  
  void bounce(){
    if(pos.x+r/2 > 50) vel.x *= -1;
    if(pos.x-r/2 < -50) vel.x *= -1;
    if(pos.y+r/2 > 50) vel.y *= -1;
    if(pos.y-r/2 < -50) vel.y *= -1;
    if(pos.z+r/2 > 60) {
      pos = new PVector(0, 0, 0);
      vel = PVector.random3D();
      //vel.mult(0.8);
      backscore++;
    }
    if(pos.z-r/2 < -60) {
      pos = new PVector(0, 0, 0);
      vel = PVector.random3D();
      //vel.mult(0.8);
      frontscore++;
    }
  }
  
  void bouncepaddle(Paddle p){
    if(p.isfront){
      if((pos.z+r/2 > 50-p.w)&&(pos.z+r/2 < 50+p.w)){
        if((pos.x < p.pos.x+p.r/2) && (pos.x > p.pos.x-p.r/2)){
          if((pos.y < p.pos.y+p.r/2) && (pos.y > p.pos.y-p.r/2)){
            float ydiff = pos.y - (p.pos.y -p.r/2);
            float xdiff = pos.x - (p.pos.x -p.r/2);
            float angley = map(ydiff, 0, p.r*2, -PI/4, PI/4);
            float anglex = map(xdiff, 0, p.r*2, -PI/4, PI/4);
            vel.x = cos(anglex);
            vel.y = sin(angley);
            pos.z = p.pos.z-p.w/2-r;
            vel.z *= -1;
          }
        }
      }
    } else {
      if((pos.z-r/2 < -50+p.w) && (pos.z -r/2 > -50-p.w)){
        if((pos.x < p.pos.x+p.r/2) && (pos.x > p.pos.x-p.r/2)){
          if((pos.y < p.pos.y+p.r/2) && (pos.y > p.pos.y-p.r/2)){
            float ydiff = pos.y - (p.pos.y -p.r/2);
            float xdiff = pos.x - (p.pos.x -p.r/2);
            float angley = map(ydiff, 0, p.r*2, -3*PI/4, 3*PI/4);
            float anglex = map(xdiff, 0, p.r*2, -3*PI/4, 3*PI/4);
            vel.x = cos(anglex);
            vel.y = sin(angley);
            pos.z = p.pos.z+p.w/2+r;
            vel.z *= -1;
          }
        }
      }
    }
  }
}