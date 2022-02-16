let points = [];
let geos = [];
let r = 100;
let weight = 1;
let strokeColor;
let colors;

function setup() {
  createCanvas(400, 400, WEBGL);
  strokeColor = color(0);
  colors = [{
    light: color(255,0,0),
    dark: color(200,0,0)
  }];
  let t = (1.0 + Math.sqrt(5.0)) / 2.0;
  let rects = [
    { x: -1, y: t, z: 0}, { x: 1, y: t, z: 0}, { x: -1, y: -t, z: 0}, { x: 1, y: -t, z: 0},
    { x: 0, y: -1, z: t}, { x: 0, y: 1, z: t}, { x: 0, y: -1, z: -t}, { x: 0, y: 1, z: -t},
    { x: t, y: 0, z: -1}, { x: t, y: 0, z: 1}, { x: -t, y: 0, z: -1}, { x: -t, y: 0, z: 1}
  ];  
  for(let i = 0; i < rects.length; i++) { 
    points.push(rects[i])
  }
  let pyr = [
    [0, 11, 5], [0, 5, 1], [0, 1, 7], [0, 7, 10], [0, 10, 11],
    [1, 5, 9], [5, 11, 4], [11, 10, 2], [10, 7, 6], [7, 1, 8],
    [3, 9, 4],[3, 4, 2],[3, 2, 6],[3, 6, 8],[3, 8, 9],
    [4, 9, 5], [2, 4, 11], [6, 2, 10], [8, 6, 7], [9, 8, 1]
  ];
  for(let i = 0; i < pyr.length; i++) {
    geos.push(pyramid(points[pyr[i][0]], points[pyr[i][1]], points[pyr[i][2]]))
  }
  
  //geos = split(geos, 1);
  //geos = split(geos, 0.3);
  //geos = split(geos, 0.1);
}

function draw() {
  colorMode(HSB)
  background(20,255,255);
  rotateX(TWO_PI*millis()/32000.0);
  rotateY(TWO_PI*millis()/32000.0);
  scale(100.);
  for(let i = 0; i < geos.length; i++) {
    geos[i].draw();
  }
}
function pyramidFromIndex(a, b, c) {
  return pyramid(points[a], points[b], points[c]);
}
function pyramid(a, b, c) {
  let m = { x: (a.x+b.x+c.x)/3, y: (a.y+b.y+c.y)/3, z: (a.z+b.z+c.z)/3};
  let f = colors[floor(random(colors.length))];
  return {
    draw: ()=> {
    let d = 0.08+0.08*sin(TWO_PI+millis()/1000.0+TWO_PI*noise(1000+m.x*1000.0,1000+m.y*1000.0,1000+m.z*1000.0));
    push();
    translate(d*m.x,d*m.y,d*m.z);
    beginShape();
    stroke(strokeColor);
    strokeWeight(weight);
    fill(f.light);
    vertex(a.x,a.y,a.z);
    vertex(b.x,b.y,b.z);
    vertex(c.x,c.y,c.z);
    endShape(CLOSE);
    
    beginShape();
    stroke(strokeColor);
    strokeWeight(weight);
    fill(f.dark);
    vertex(a.x,a.y,a.z);
    vertex(b.x,b.y,b.z);
    fill(lerpColor(color(0), f.dark,0.2));
    vertex(0,0,0);
    endShape(CLOSE);
    
    beginShape();
    stroke(strokeColor);
    strokeWeight(weight);
    fill(lerpColor(color(0), f.dark,0.2));
    vertex(0,0,0);
    fill(f.dark);
    vertex(b.x,b.y,b.z);
    vertex(c.x,c.y,c.z);
    endShape(CLOSE);
      
    beginShape();
    stroke(strokeColor);
    strokeWeight(weight);
    fill(f.dark);
    vertex(a.x,a.y,a.z);
    fill(lerpColor(color(0), f.dark,0.2));
    vertex(0,0,0);
    fill(f.dark);
    vertex(c.x,c.y,c.z);
    endShape(CLOSE);
    
    pop();
    }
  }
}