class Rocket {
  PVector position;
  PVector velocity;
  PVector nosePosition;
  Fire fire;
  
  Rocket(PVector position) {
    this.position = position;
    this.velocity = new PVector(random(2.5, 5), 0).rotate(random(TWO_PI));
    this.fire = new Fire();
  }
  
  void update() {
    PVector nosePosition = position.copy().add(velocity.copy().normalize().mult(40));
    if (nosePosition.x <= 0 || nosePosition.x >= width) {
      velocity.x = -velocity.x;
    }
    if (nosePosition.y <= 0 || nosePosition.y >= height) {
      velocity.y = -velocity.y;
    }
    
    position.add(velocity);
    fire.update(position.copy().add(velocity.copy().normalize().rotate(PI).mult(32)));
  }
  
  void display() {
    fire.display();
    
    pushMatrix();
    translate(position.x, position.y);
    rotate(this.velocity.heading() + PI / 2);
    scale(0.2);

    noStroke();
    
    // Head cone
    fill(#ff0000);
    triangle(0, -200, -50, -100, 50, -100);
    
    // Body
    fill(#ffdd00);
    rect(-50, -100, 100, 200);
    
    // Fins
    fill(#ff0000);
    triangle(-50, 100, -50, 50, -100, 150);
    triangle(50, 100, 50, 50, 100, 150);
    
    // Exhaust
    fill(#959595);
    quad(-20, 100, 20, 100, 40, 160, -40, 160);
    
    popMatrix();
  }
}
