let train;

function setup() {
    createCanvas(600, 400);
    train = new Train();
}

function draw() {
    train.update();

    let skyColor = color(60, 60, 80);
    let horizonSkyColor = color(20, 20, 30);
    let groundColor = color(40, 60, 40);
    let horizonGroundColor = color(20, 25, 20);

    background(horizonSkyColor);
    strokeWeight(1);
    for (let i = 0; i < height * 2 / 3; i++) {
        stroke(lerpColor(skyColor, horizonSkyColor, i / (height * 2 / 3)));
        line(0, i, width, i);
    }
    for (let i = height * 2 / 3; i < height; i++) {
        stroke(lerpColor(horizonGroundColor, groundColor, (i - height * 2 / 3) / (height / 3)));
        line(0, i, width, i);
    }

    train.display();
}

function mousePressed() {
    train.toggleRunning();
}
