import { Vector } from "p5";
import { Star } from "./Star";

export class Stars {
    private stars: Star[]

    constructor(starCount: number, desiredWidth: number, desiredHeight: number) {
        this.stars = new Array(starCount)
        for (let i = 0; i < starCount; i++) {
            this.stars[i] = new Star(new Vector(random(desiredWidth), random(desiredHeight)), random(5, 15))
        }
    }

    update() {
        for (const star of this.stars) star.update()
    }

    display() {
        for (const star of this.stars) star.display()
    }
}