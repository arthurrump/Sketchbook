class Train {
    lightBrightness;
    smoke;
    bumperPosition;
    velocity;
    distance;
    running;

    constructor() {
        this.lightBrightness = 255;
        this.smoke = new Smoke();
        this.bumperPosition = new p5.Vector(500, 220);
        this.velocity = new p5.Vector(-1, 0);
        this.distance = 0;
        this.running = true;
    }

    toggleRunning() {
        this.running = !this.running;
    }

    update() {
        if (this.running) {
            this.velocity.x = noise(frameCount / 100) * -0.2;
            this.distance -= this.velocity.x;
            this.smoke.create(new p5.Vector(this.bumperPosition.x - 50, this.bumperPosition.y - 120));
        }

        this.lightBrightness = 128 + noise(frameCount / 100) * 128;
        this.smoke.update(this.velocity);
    }

    display() {
        strokeWeight(0);
        
        // Body
        fill(2);
        rect(this.bumperPosition.x - 240, this.bumperPosition.y, 240, 100);
        rect(this.bumperPosition.x - 260, this.bumperPosition.y + 30, 20, 70);
        rect(this.bumperPosition.x - 240, this.bumperPosition.y - 80, 20, 80);
        rect(this.bumperPosition.x - 200, this.bumperPosition.y - 80, 20, 80);
        rect(this.bumperPosition.x - 160, this.bumperPosition.y - 80, 20, 80);
        rect(this.bumperPosition.x - 240, this.bumperPosition.y - 100, 120, 20);
        // Details
        fill(50);
        rect(this.bumperPosition.x - 240, this.bumperPosition.y + 25, 235, 5);

        // Chimney
        this.smoke.display();
        fill(2);
        rect(this.bumperPosition.x - 70, this.bumperPosition.y - 120, 40, 120);
        rect(this.bumperPosition.x - 80, this.bumperPosition.y - 130, 60, 10);

        // Light
        let lightColor = color(250, 200, 0, this.lightBrightness);
        fill(lightColor);
        rect(this.bumperPosition.x - 5, this.bumperPosition.y, 5, 30);
        for (let i = 0; i < 100; i++) {
            lightColor.setAlpha(this.lightBrightness - (i / 100) * 255);
            fill(lightColor);
            rect(this.bumperPosition.x + 1 + i, this.bumperPosition.y - 0.5 * i, 1, 30 + i);
        }

        // Wheels
        noFill();
        stroke(50);
        strokeWeight(10);

        push();
        translate(this.bumperPosition.x - 50, this.bumperPosition.y + 100);
        rotate(this.distance);
        circle(0, 0, 70);
        for (let i = 0; i < 5; i++) {
            rotate(TWO_PI / 5);
            line(0, 0, 0, -35);
        }
        pop();

        push();
        translate(this.bumperPosition.x - 210, this.bumperPosition.y + 100);
        rotate(this.distance);
        circle(0, 0, 70);
        for (let i = 0; i < 5; i++) {
            rotate(TWO_PI / 5);
            line(0, 0, 0, -35);
        }
        pop();
    }
}