class SmokeParticle {
    lifetime;
    position;
    velocity;
    
    constructor(position) {
        this.lifetime = 255;
        this.position = position;
        this.velocity = createVector(0, -1 * (random() + 1));
    }

    update(windForce) {
        this.lifetime -= 1;
        this.velocity.add(windForce);
        this.position.add(this.velocity);
    }

    display() {
        strokeWeight(0);
        fill(200, 200, 200, this.lifetime);
        circle(this.position.x, this.position.y, 4);
    }

    isDead() {
        return this.lifetime <= 0;
    }
}
