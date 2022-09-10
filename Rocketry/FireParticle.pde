class FireParticle {
  PVector position;
  PVector velocity;
  float rotation;
  int lifetime;
  float hue;
  
  FireParticle(float hue, PVector position, PVector velocity) {
    this.hue = hue;
    this.position = position;
    this.velocity = velocity;
    this.rotation = random(TWO_PI);
    this.lifetime = 255;
  }
  
  void update() {
    position.add(velocity);
    lifetime = lifetime - 10;
  }
  
  void display() {
    pushMatrix();
    translate(position.x - 2, position.y - 2);
    rotate(rotation);
    
    noStroke();
    colorMode(HSB, 255);
    fill(color((hue * 255 + 128) % 255, 255, 255, lifetime));
    square(0, 0, 4);
    
    popMatrix();
  }
  
  boolean isDead() {
    return lifetime <= 0;
  }
}
