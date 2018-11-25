class Box {


  Body body;
  float w;
  float h;


  Box(float x, float y) {
    w = random(1, 3);
    h = random(1, 3);

    makeBody(new Vec2(x, y), w, h);
  }


  void killBody() {
    box2d.destroyBody(body);
  }


  boolean done() {

    Vec2 pos = box2d.getBodyPixelCoord(body);

    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {

    Vec2 pos = box2d.getBodyPixelCoord(body);

    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(0, 0, 200, 100);
    stroke(0);
    //strokeWeight(2);
    noStroke();
    rect(0, 0, w, h);
    popMatrix();
  }


  void makeBody(Vec2 center, float w_, float h_) {


    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 10;
    fd.friction = 0.3;
    fd.restitution = 0.5;


    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);


    body.setLinearVelocity(new Vec2(random(-0.2, 0.2), random(-1,1.1)));
    body.setAngularVelocity(random(-1, 1));
  }
}
