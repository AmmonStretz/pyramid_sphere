ArrayList<PVector> points = new ArrayList();
ArrayList<Pyramid> geos = new ArrayList();
float r = 160;
ArrayList<Integer> lightColors;
ArrayList<Integer> darkColors;
color strokeColor, bgColor;
int weight = 1;
  
void setup() {
  size(600,600,P3D);
  lightColors = new ArrayList();
  darkColors = new ArrayList();
  //RED
  lightColors.add(color(245, 115, 106));
  darkColors.add(color(221, 104, 96));
  
  //BROWN
  lightColors.add(color(146, 89, 81));
  darkColors.add(color(132, 80, 73));
  
  //GREY
  lightColors.add(color(157, 155, 157));
  darkColors.add(color(142, 140, 142));
  
  //ORANGE
  lightColors.add(color(254, 186, 76));
  darkColors.add(color(229, 168, 69));
  
  bgColor = color(238, 223, 162);
  strokeColor = color(20);
  
  float t = (1.0 + sqrt(5.0)) / 2.0;
  points.add(new PVector(-1,  t,  0).mult(r));
  points.add(new PVector( 1,  t,  0).mult(r));
  points.add(new PVector(-1, -t,  0).mult(r));
  points.add(new PVector( 1, -t,  0).mult(r));
  
  points.add(new PVector( 0, -1,  t).mult(r));
  points.add(new PVector( 0,  1,  t).mult(r));
  points.add(new PVector( 0, -1, -t).mult(r));
  points.add(new PVector( 0,  1, -t).mult(r));
  
  points.add(new PVector( t,  0, -1).mult(r));
  points.add(new PVector( t,  0,  1).mult(r));
  points.add(new PVector(-t,  0, -1).mult(r));
  points.add(new PVector(-t,  0,  1).mult(r));
  geos.add(new Pyramid(0, 11, 5));
  geos.add(new Pyramid(0, 5, 1));
  geos.add(new Pyramid(0, 1, 7));
  geos.add(new Pyramid(0, 7, 10));
  geos.add(new Pyramid(0, 10, 11));
  
  // 5 adjacent 
  geos.add(new Pyramid(1, 5, 9));
  geos.add(new Pyramid(5, 11, 4));
  geos.add(new Pyramid(11, 10, 2));
  geos.add(new Pyramid(10, 7, 6));
  geos.add(new Pyramid(7, 1, 8));
  
  // 5  around point 3
  geos.add(new Pyramid(3, 9, 4));
  geos.add(new Pyramid(3, 4, 2));
  geos.add(new Pyramid(3, 2, 6));
  geos.add(new Pyramid(3, 6, 8));
  geos.add(new Pyramid(3, 8, 9));
  
  // 5 adjacent 
  
  geos.add(new Pyramid(4, 9, 5));
  geos.add(new Pyramid(2, 4, 11));
  geos.add(new Pyramid(6, 2, 10));
  geos.add(new Pyramid(8, 6, 7));
  geos.add(new Pyramid(9, 8, 1));
  
  geos = split(geos, 1);
  geos = split(geos, 0.3);
  geos = split(geos, 0.1);
}
ArrayList<Pyramid> split(ArrayList<Pyramid> geos, float propability) {
  ArrayList<Pyramid> geos1 = new ArrayList();
  for(Pyramid p: geos) {
    if(random(1)<propability) {
    PVector a = p.a.copy().normalize().mult(r);
    PVector b = p.b.copy().normalize().mult(r);
    PVector c = p.c.copy().normalize().mult(r);
    PVector ab = PVector.lerp(p.a,p.b,0.5).copy().normalize().mult(r);
    PVector bc = PVector.lerp(p.b,p.c,0.5).copy().normalize().mult(r);
    PVector ca = PVector.lerp(p.c,p.a,0.5).copy().normalize().mult(r);
    geos1.add(new Pyramid(a, ab, ca));
    geos1.add(new Pyramid(b, ab, bc));
    geos1.add(new Pyramid(c, bc, ca));
    geos1.add(new Pyramid(ab, bc, ca));
    } else {
      geos1.add(p);
    }
  }
  return geos1;  
}
void draw() {
  background(bgColor);
  translate(width/2, height/2);
  rotateX(TWO_PI*millis()/32000.0);
  rotateY(TWO_PI*millis()/32000.0);
  //scale(100.);
  fill(0);
  strokeWeight(1);
  noStroke();
  sphereDetail(4);
  sphere(90);

  for(Pyramid p: geos) {
    p.draw();
  }
  /*
  loadPixels();
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      if(brightness(color(pixels[x+y*width]))==230)
      pixels[x+y*width] = lerpColor(color(pixels[x+y*width]), color(0), new PVector(x,y).dist(new PVector(width/2, height/2))/width/2);
    }
  }
  updatePixels();*/
}
