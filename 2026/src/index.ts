import { Vector } from "p5"

import "p5"
import "./index.css"

import { Snow } from "./Snow"
import { Maze } from "./Maze"
import { Wish } from "./Wish"
import { Button } from "./Button"

let desiredWidth = 640
let desiredHeight = 960
let margin = 24

let snow: Snow
let maze: Maze
let wish: Wish
let buttons: Button[]

let canvasScale: number

let buttonsVisible = false

function setup() {
    canvasScale = min(1, min((windowWidth - margin) / desiredWidth, (windowHeight - margin) / desiredHeight));
    createCanvas(canvasScale * desiredWidth, canvasScale * desiredHeight);

    snow = new Snow(300)
    maze = new Maze()
    wish = new Wish()
    buttons = [
        new Button("←", new Vector(desiredWidth / 2 - 215, 810), 100, 100, () => maze.movingLeft(), () => maze.stopMoving()),
        new Button("↑", new Vector(desiredWidth / 2 - 105, 810), 100, 100, () => maze.movingUp(), () => maze.stopMoving()),
        new Button("↓", new Vector(desiredWidth / 2 + 5, 810), 100, 100, () => maze.movingDown(), () => maze.stopMoving()),
        new Button("→", new Vector(desiredWidth / 2 + 115, 810), 100, 100, () => maze.movingRight(), () => maze.stopMoving())
    ]
}

function draw() {
    snow.update()
    maze.update()
    wish.update()
    if (buttonsVisible) {
        for (const button of buttons) button.update()
    } else {
        if (millis() > 8000) {
            buttonsVisible = true
            wish.fadeOut()
        }
    }

    if (wish.isTitleDone()) {
        maze.setVisible(true)
    }

    background(0, 0, 30)

    push()
    scale(canvasScale)

    snow.display()

    push()
    translate(desiredWidth / 2, 0)
    wish.display()
    pop()

    push()
    translate((desiredWidth - maze.WIDTH * maze.CELL_SIZE) / 2, 770)
    maze.display()
    pop()

    if (buttonsVisible) {
        for (const button of buttons) {
            button.display()
        }
    }

    pop()
}

function keyPressed() {
    switch (keyCode) {
        case UP_ARROW:
            maze.movingUp()
            break
        case DOWN_ARROW:
            maze.movingDown()
            break
        case LEFT_ARROW:
            maze.movingLeft()
            break
        case RIGHT_ARROW:
            maze.movingRight()
            break
        default:
            break
    }
}

function keyReleased() {
    maze.stopMoving()
}

function mousePressed() {
    for (const button of buttons) {
        button.pressed(new Vector(mouseX / canvasScale, mouseY / canvasScale))
    }

    if (!buttonsVisible && wish.isDone()) {
        buttonsVisible = true
        wish.fadeOut()
    }
}

function mouseReleased() {
    for (const button of buttons) {
        button.released()
    }
}

function touchStarted() {
    for (const button of buttons) {
        button.pressed(new Vector(touches[0].x / canvasScale, touches[0].y / canvasScale))
    }

    if (!buttonsVisible && wish.isDone()) {
        buttonsVisible = true
        wish.fadeOut()
    }
}

function touchEnded() {
    for (const button of buttons) {
        button.released()
    }
}

function windowResized() {
    canvasScale = min(1, min((windowWidth - margin) / desiredWidth, (windowHeight - margin) / desiredHeight));
    resizeCanvas(canvasScale * desiredWidth, canvasScale * desiredHeight);
}

window.setup = setup
window.draw = draw
window.keyPressed = keyPressed
window.keyReleased = keyReleased
window.mousePressed = mousePressed
window.mouseReleased = mouseReleased
window.touchStarted = touchStarted
window.touchEnded = touchEnded
window.windowResized = windowResized
