import { Color, Vector } from "p5"

export type CellType = "light" | "tree" | "trunk"

export class Cell {
    private position: Vector
    private width: number
    private height: number
    private type: CellType
    private nextType: CellType

    private lightColor: Color
    private treeColor: Color
    private trunkColor: Color

    constructor(position: Vector, width: number, height: number, type: CellType) {
        this.position = position
        this.width = width
        this.height = height
        this.type = type
        this.nextType = type

        this.treeColor = color(0, random(100, 150), random(5, 15))
        this.lightColor = color(random(180, 220), random(170, 200), random(5, 15))
        this.trunkColor = color(random(90, 100), random(55, 65), 0)
    }

    isLight() { return this.type === "light" }
    isTree() { return this.type === "tree" }
    isTrunk() { return this.type === "trunk" }

    toggle() {
        switch (this.type) {
            case "light": 
                this.nextType = "tree"
                this.type = "tree"
                break
            case "tree":
                this.nextType = "light"
                this.type = "light"
                break
        }
    }

    toggleNext() {
        switch (this.nextType) {
            case "light": 
                this.nextType = "tree"
                break
            case "tree":
                this.nextType = "light"
                break
        }
    }

    next() {
        this.type = this.nextType
    }

    display() {
        switch (this.type) {
            case "light":
                fill(this.lightColor)
                break
            case "tree":
                fill(this.treeColor)
                break
            case "trunk":
                fill(this.trunkColor)
                break
        }

        noStroke()

        rect(this.position.x, this.position.y, this.width, this.height)
    }

    covers(pos: Vector) : boolean {
        return (
            this.position.x <= pos.x && pos.x <= this.position.x + this.width &&
            this.position.y <= pos.y && pos.y <= this.position.y + this.height
        )
    }
}