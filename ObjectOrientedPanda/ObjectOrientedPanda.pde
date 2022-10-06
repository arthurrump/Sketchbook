int x = 200;
int y = 200;

void setup() {
  size(400, 400);
}

void draw() {
  background(255, 255, 255);
  
  stroke(0, 0, 0);
  strokeWeight(7);
  fill(255, 255, 255);

  // Teken oren
  ellipse(x - 70, y - 70, 60, 90);
  ellipse(x + 70, y - 70, 60, 90);
  fill(0, 0, 0);
  ellipse(x - 70, y - 70, 40, 60);
  ellipse(x + 70, y - 70, 45, 50);
  fill(#E58BB7);
  ellipse(x - 70, y - 70, 30, 40);
  ellipse(x + 70, y - 70, 30, 35);

  // Teken hoofd
  fill(255, 255, 255);
  ellipse(x, y, 190, 180);
  
  // Teken vlekken
  fill(0, 0, 0);
  ellipse(x + 60, y + 20, 60, 50);
  ellipse(x - 78, y + 15, 20, 60);
  ellipse(x, y - 75, 70, 30);
  
  // Teken tong
  fill(#DE0437);
  if (mousePressed && dist(mouseX, mouseY, this.x, this.y) < 100) {
    ellipse(x + 10, y + 60, 40, 80);
  } else {
    ellipse(x + 10, y + 60, 40, 40);
  }

  // Teken snuit
  fill(255, 255, 255);
  ellipse(x + 10, y + 35, 80, 70);

  // Teken ogen en neus met letters OOP
  fill(0, 0, 0);
  textSize(80);
  textAlign(CENTER);
  text("OO", x, y);

  textAlign(LEFT);
  text("P", x - 5, y + 68);

  // Teken iris en pupillen in de ogen
  noStroke();
  fill(#8BB1E5);
  ellipse(x - 25, y - 25, 20, 30);
  ellipse(x + 28, y - 25, 20, 30);
  fill(0, 0, 0);
  ellipse(x - 23, y - 30 + (10 * mouseY / height), 6, 8);
  ellipse(x + 30, y - 30 + (10 * mouseY / height), 6, 8);
}
