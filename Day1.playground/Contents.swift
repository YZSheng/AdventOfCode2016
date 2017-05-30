import XCTest

enum Direction {
    case north
    case east
    case south
    case west
    
    mutating func turn(towards: String) {
        if towards == "R" {
            turnRight()
        } else if towards == "L" {
            turnLeft()
        }
    }
    
    mutating private func turnRight() {
        switch self {
        case .east:
            self = .south
        case .south:
            self = .west
        case .west:
            self = .north
        case .north:
            self = .east
        }
    }
    
    mutating private func turnLeft() {
        switch self {
        case .east:
            self = .north
        case .north:
            self = .west
        case .west:
            self = .south
        case .south:
            self = .east
        }
    }
}

var direction = Direction.east

direction.turn(towards: "L")
XCTAssertEqual(direction, Direction.north)

direction.turn(towards: "R")
XCTAssertEqual(direction, Direction.east)

struct Location {
    var direction: Direction = Direction.north
    var movedSteps: [Direction: Int] = [
        .east: 0,
        .south: 0,
        .west: 0,
        .north: 0
    ]
    
    mutating func move(steps: [String]) {
        steps.forEach { step in
            move(step: step)
        }
    }
    
    func calculateDistance() -> Int {
        return abs(movedSteps[.east]! - movedSteps[.west]!) + abs(movedSteps[.north]! - movedSteps[.south]!)
    }
    
    private mutating func move(step: String) {
        let index = step.index(step.startIndex, offsetBy: 1)
        let firstLetter = step.substring(to: index)
        let stepsCount = step.substring(from: index)
        
        direction.turn(towards: firstLetter)
        advance(direction: direction, steps: Int(stepsCount)!)
    }
    
    private mutating func advance(direction: Direction, steps: Int) {
        movedSteps[direction]! += steps
    }
}

var locationOne = Location()
let stepsOne = "R2, L3"
locationOne.move(steps: stepsOne.components(separatedBy: ", "))
XCTAssertEqual(locationOne.calculateDistance(), 5)

var locationTwo = Location()
let stepsTwo = "R2, R2, R2"
locationTwo.move(steps: stepsTwo.components(separatedBy: ", "))
XCTAssertEqual(locationTwo.calculateDistance(), 2)

var locationThree = Location()
let stepsThree = "R5, L5, R5, R3"
locationThree.move(steps: stepsThree.components(separatedBy: ", "))
XCTAssertEqual(locationThree.calculateDistance(), 12)

var locationFour = Location()
let stepsFour = "R1, R1, R3, R1, R1, L2, R5, L2, R5, R1, R4, L2, R3, L3, R4, L5, R4, R4, R1, L5, L4, R5, R3, L1, R4, R3, L2, L1, R3, L4, R3, L2, R5, R190, R3, R5, L5, L1, R54, L3, L4, L1, R4, R1, R3, L1, L1, R2, L2, R2, R5, L3, R4, R76, L3, R4, R191, R5, R5, L5, L4, L5, L3, R1, R3, R2, L2, L2, L4, L5, L4, R5, R4, R4, R2, R3, R4, L3, L2, R5, R3, L2, L1, R2, L3, R2, L1, L1, R1, L3, R5, L5, L1, L2, R5, R3, L3, R3, R5, R2, R5, R5, L5, L5, R2, L3, L5, L2, L1, R2, R2, L2, R2, L3, L2, R3, L5, R4, L4, L5, R3, L4, R1, R3, R2, R4, L2, L3, R2, L5, R5, R4, L2, R4, L1, L3, L1, L3, R1, R2, R1, L5, R5, R3, L3, L3, L2, R4, R2, L5, L1, L1, L5, L4, L1, L1, R1"
locationFour.move(steps: stepsFour.components(separatedBy: ", "))
XCTAssertEqual(locationFour.calculateDistance(), 241)
