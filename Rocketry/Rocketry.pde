Rocket rocket;
Stars stars;

void setup() {
  size(800, 1200);
  
  rocket = new Rocket(new PVector(width / 2, height / 2));
  stars = new Stars(25);
}

void draw() {
  background(#000000);
  
  stars.display();
  
  rocket.update();
  rocket.display();
}
