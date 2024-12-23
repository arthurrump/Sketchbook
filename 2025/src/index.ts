import { Font, Vector } from "p5"

import { CELL_MARGIN, CELL_WIDTH, PATTERNS, Tree } from "./Tree"

import "p5"
import "./index.css"
import { Wish } from "./Wish"
import { Stars } from "./Stars"

let desiredWidth = 640
let desiredHeight = 960
let margin = 24

let stars: Stars
let wish: Wish
let tree: Tree

let canvasScale: number

let fontGwendolynBold: Font

function preload() {
    fontGwendolynBold = loadFont("resc/gwendolyn-bold.ttf")
}

function setup() {
    canvasScale = min(1, min((windowWidth - margin) / desiredWidth, (windowHeight - margin) / desiredHeight));
    createCanvas(canvasScale * desiredWidth, canvasScale * desiredHeight);

    stars = new Stars(35, desiredWidth, desiredHeight * 0.8)
    wish = new Wish(fontGwendolynBold)
    tree = new Tree(new Vector((desiredWidth - CELL_WIDTH - CELL_MARGIN) / 2, 270), 24, 5, random(PATTERNS))
}

function draw() {
    if (millis() > 6000)
        tree.start()

    stars.update()
    wish.update()
    tree.update()

    background(0, 0, 30)

    push()
    scale(canvasScale)

    stars.display()

    push()
    translate(desiredWidth / 2, 0)
    rotate(-0.05 * PI)
    translate(-20, 50)
    wish.display()
    pop()

    tree.display()

    pop()
}

function mousePressed() {
    tree.pointerPressed(new Vector(mouseX / canvasScale, mouseY / canvasScale))
}

function mouseDragged() {
    tree.pointerDragged(new Vector(mouseX / canvasScale, mouseY / canvasScale))
}

function mouseReleased() {
    tree.pointerReleased()
}

function touchStarted() {
    console.log(touches)
    tree.pointerPressed(new Vector(touches[0].x / canvasScale, touches[0].y / canvasScale))
}

function touchMoved() {
    console.log(touches)
    tree.pointerDragged(new Vector(touches[0].x / canvasScale, touches[0].y / canvasScale))
}

function touchEnded() {
    tree.pointerReleased()
}

function windowResized() {
    canvasScale = min(1, min((windowWidth - margin) / desiredWidth, (windowHeight - margin) / desiredHeight));
    resizeCanvas(canvasScale * desiredWidth, canvasScale * desiredHeight);
}

window.preload = preload;
window.setup = setup;
window.draw = draw;
window.mousePressed = mousePressed
window.mouseDragged = mouseDragged
window.mouseReleased = mouseReleased
window.touchStarted = touchStarted
window.touchMoved = touchMoved
window.touchEnded = touchEnded
window.windowResized = windowResized
