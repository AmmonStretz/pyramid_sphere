class Pyramid {
  PVector a, b, c, m;
  color light, dark;
  PShape s;
  Pyramid(int a, int b, int c) {
    this.a = points.get(a);
    this.b = points.get(b);
    this.c = points.get(c);
    m = PVector.add(this.a, this.b).add(this.c).div(3);
    setColors();
    s = generate();
  }
  Pyramid(PVector a, PVector b, PVector c) {
    this.a = a;
    this.b = b;
    this.c = c;
    m = PVector.add(this.a, this.b).add(this.c).div(3);
    setColors();
    s = generate();
  }
  void setColors(){
    int colorIndex = (int)random(lightColors.size());
    light = lightColors.get(colorIndex);
    dark = darkColors.get(colorIndex);
  }
  PShape generate() {
    PShape t0 = createShape();
    t0.beginShape();
    t0.stroke(strokeColor);
    t0.strokeWeight(weight);
    t0.fill(light);
    t0.vertex(a.x,a.y,a.z);
    t0.vertex(b.x,b.y,b.z);
    t0.vertex(c.x,c.y,c.z);
    t0.endShape(CLOSE);
    
    PShape t1 = createShape();
    t1.beginShape();
    t1.stroke(strokeColor);t1.strokeWeight(weight);
    t1.fill(dark);
    t1.vertex(a.x,a.y,a.z);
    t1.vertex(b.x,b.y,b.z);
    t1.fill(lerpColor(color(0), dark,0.2));
    t1.vertex(0,0,0);
    t1.endShape(CLOSE);
    
    PShape t2 = createShape();
    t2.beginShape();
    t2.stroke(strokeColor);
    t2.strokeWeight(weight);
    t2.fill(lerpColor(color(0), dark,0.2));
    t2.vertex(0,0,0);
    t2.fill(dark);
    t2.vertex(b.x,b.y,b.z);
    t2.vertex(c.x,c.y,c.z);
    t2.endShape(CLOSE);
    
    PShape t3 = createShape();
    t3.beginShape();
    t3.stroke(strokeColor);
    t3.strokeWeight(weight);
    t3.fill(dark);
    t3.vertex(a.x,a.y,a.z);
    t3.fill(lerpColor(color(0), dark,0.2));
    t3.vertex(0,0,0);
    t3.fill(dark);
    t3.vertex(c.x,c.y,c.z);
    t3.endShape(CLOSE);
    
    
    PShape s = createShape(GROUP);
    s.addChild(t0);
    s.addChild(t1);
    s.addChild(t2);
    s.addChild(t3);
    return s;
  }
  void draw() {
    //s =createShape();
    float d = 0.08+0.08*sin(TWO_PI+millis()/1000.0+TWO_PI*noise(1000+m.x*1000.0,1000+m.y*1000.0,1000+m.z*1000.0));
    pushMatrix();
    translate(d*m.x,d*m.y,d*m.z);
    fill(color(light));
    shape(s);
    popMatrix();
  }
}
