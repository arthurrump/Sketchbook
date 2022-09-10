Rocket rocket;

void setup() {
  size(400, 400);
  
  rocket = new Rocket(new PVector(width / 2, height / 2));
}

void draw() {
  background(#000000);
  
  rocket.update();
  rocket.display();
}
