import XCTest

enum Direction:Character {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
}

struct Position {
    var x:Int
    var y:Int
    let UPPER_BOUND = 2
    
    mutating func move(direction: Direction) {
        switch direction {
        case .down where y < UPPER_BOUND:
            y += 1
        case .left where x > 0:
            x -= 1
        case .up where y > 0:
            y -= 1
        case .right where x < UPPER_BOUND:
            x += 1
        default:
            return
        }
    }
    
    mutating func move(steps: String) -> Position {
        
        steps.characters.forEach{ char in
            if let direction = Direction(rawValue: char) {
                move(direction: direction)
            }
        }
        return self
    }
    
    func deriveNumber() -> Int {
        return x + 1 + y * 3
    }
}

extension Position: Equatable {
    public static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

var positionOne = Position(x: 0, y: 0)

positionOne.move(direction: .up)
XCTAssertEqual(positionOne, Position(x: 0, y: 0))

positionOne.move(direction: .right)
XCTAssertEqual(positionOne, Position(x: 1, y: 0))

positionOne.move(direction: .right)
XCTAssertEqual(positionOne, Position(x: 2, y: 0))

positionOne.move(direction: .right)
XCTAssertEqual(positionOne, Position(x: 2, y: 0))

positionOne.move(direction: .down)
XCTAssertEqual(positionOne, Position(x: 2, y: 1))

positionOne.move(direction: .down)
XCTAssertEqual(positionOne, Position(x: 2, y: 2))

positionOne.move(direction: .down)
XCTAssertEqual(positionOne, Position(x: 2, y: 2))

positionOne.move(direction: .left)
XCTAssertEqual(positionOne, Position(x: 1, y: 2))

positionOne.move(direction: .left)
XCTAssertEqual(positionOne, Position(x: 0, y: 2))

positionOne.move(direction: .left)
XCTAssertEqual(positionOne, Position(x: 0, y: 2))

var positionTwo = Position(x: 1, y: 1)

var positionThree = positionTwo.move(steps: "ULL")
XCTAssertEqual(positionThree.deriveNumber(), 1)

var positionFour = positionThree.move(steps: "RRDDD")
XCTAssertEqual(positionFour.deriveNumber(), 9)

var positionFive = positionFour.move(steps: "LURDL")
XCTAssertEqual(positionFive.deriveNumber(), 8)

var positionSix = positionFive.move(steps: "UUUUD")
XCTAssertEqual(positionSix.deriveNumber(), 5)

let testStrings = ["DUURRDRRURUUUDLRUDDLLLURULRRLDULDRDUULULLUUUDRDUDDURRULDRDDDUDDURLDLLDDRRURRUUUDDRUDDLLDDDURLRDDDULRDUDDRDRLRDUULDLDRDLUDDDLRDRLDLUUUDLRDLRUUUDDLUURRLLLUUUUDDLDRRDRDRLDRLUUDUDLDRUDDUDLLUUURUUDLULRDRULURURDLDLLDLLDUDLDRDULLDUDDURRDDLLRLLLLDLDRLDDUULRDRURUDRRRDDDUULRULDDLRLLLLRLLLLRLURRRLRLRDLULRRLDRULDRRLRURDDLDDRLRDLDRLULLRRUDUURRULLLRLRLRRUDLRDDLLRRUDUDUURRRDRDLDRUDLDRDLUUULDLRLLDRULRULLRLRDRRLRLULLRURUULRLLRRRDRLULUDDUUULDULDUDDDUDLRLLRDRDLUDLRLRRDDDURUUUDULDLDDLDRDDDLURLDRLDURUDRURDDDDDDULLDLDLU", "LURLRUURDDLDDDLDDLULRLUUUDRDUUDDUDLDLDDLLUDURDRDRULULLRLDDUDRRDRUDLRLDDDURDUURLUURRLLDRURDRLDURUDLRLLDDLLRDRRLURLRRUULLLDRLULURULRRDLLLDLDLRDRRURUUUDUDRUULDLUDLURLRDRRLDRUDRUDURLDLDDRUULDURDUURLLUDRUUUUUURRLRULUDRDUDRLLDUDUDUULURUURURULLUUURDRLDDRLUURDLRULDRRRRLRULRDLURRUULURDRRLDLRUURUDRRRDRURRLDDURLUDLDRRLDRLLLLRDUDLULUDRLLLDULUDUULLULLRLURURURDRRDRUURDULRDDLRULLLLLLDLLURLRLLRDLLRLUDLRUDDRLLLDDUDRLDLRLDUDU", "RRDDLDLRRUULRDLLURLRURDLUURLLLUUDDULLDRURDUDRLRDRDDUUUULDLUDDLRDULDDRDDDDDLRRDDDRUULDLUDUDRRLUUDDRUDLUUDUDLUDURDURDLLLLDUUUUURUUURDURUUUUDDURULLDDLDLDLULUDRULULULLLDRLRRLLDLURULRDLULRLDRRLDDLULDDRDDRURLDLUULULRDRDRDRRLLLURLLDUUUDRRUUURDLLLRUUDDDULRDRRUUDDUUUDLRRURUDDLUDDDUDLRUDRRDLLLURRRURDRLLULDUULLURRULDLURRUURURRLRDULRLULUDUULRRULLLDDDDURLRRRDUDULLRRDURUURUUULUDLDULLUURDRDRRDURDLUDLULRULRLLURULDRUURRRRDUDULLLLLRRLRUDDUDLLURLRDDLLDLLLDDUDDDDRDURRL", "LLRURUDUULRURRUDURRDLUUUDDDDURUUDLLDLRULRUUDUURRLRRUDLLUDLDURURRDDLLRUDDUDLDUUDDLUUULUUURRURDDLUDDLULRRRUURLDLURDULULRULRLDUDLLLLDLLLLRLDLRLDLUULLDDLDRRRURDDRRDURUURLRLRDUDLLURRLDUULDRURDRRURDDDDUUUDDRDLLDDUDURDLUUDRLRDUDLLDDDDDRRDRDUULDDLLDLRUDULLRRLLDUDRRLRURRRRLRDUDDRRDDUUUDLULLRRRDDRUUUDUUURUULUDURUDLDRDRLDLRLLRLRDRDRULRURLDDULRURLRLDUURLDDLUDRLRUDDURLUDLLULDLDDULDUDDDUDRLRDRUUURDUULLDULUUULLLDLRULDULUDLRRURDLULUDUDLDDRDRUUULDLRURLRUURDLULUDLULLRD", "UURUDRRDDLRRRLULLDDDRRLDUDLRRULUUDULLDUDURRDLDRRRDLRDUUUDRDRRLLDULRLUDUUULRULULRUDURDRDDLDRULULULLDURULDRUDDDURLLDUDUUUULRUULURDDDUUUURDLDUUURUDDLDRDLLUDDDDULRDLRUDRLRUDDURDLDRLLLLRLULRDDUDLLDRURDDUDRRLRRDLDDUDRRLDLUURLRLLRRRDRLRLLLLLLURULUURRDDRRLRLRUURDLULRUUDRRRLRLRULLLLUDRULLRDDRDDLDLDRRRURLURDDURRLUDDULRRDULRURRRURLUURDDDUDLDUURRRLUDUULULURLRDDRULDLRLLUULRLLRLUUURUUDUURULRRRUULUULRULDDURLDRRULLRDURRDDDLLUDLDRRRRUULDDD"]

var position = Position(x: 1, y: 1)
var code = ""

testStrings.forEach { str in
    position = position.move(steps: str)
    code.append(String(position.deriveNumber()))
}

XCTAssertEqual(code, "44558")
