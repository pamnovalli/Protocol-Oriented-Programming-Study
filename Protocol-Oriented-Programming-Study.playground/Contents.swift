import UIKit


protocol Racer {
    var speed: Double {get}
}

protocol Bird: CustomStringConvertible {
    
    var name: String {get}
    var canFly: Bool {get}
    
}

extension Bird {
    var canFly: Bool {return self is Flyable}
}

extension CustomStringConvertible where Self: Bird {
    var description: String {
        return canFly ? "I can fly" : "Guess I’ll just sit here :["
    }
}

protocol Flyable {
    
    var airspeedVelocity: Double {get}
    
}

struct FlappyBird: Bird, Flyable {
    
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
    
}

extension FlappyBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}


struct Penguin: Bird {
    let name: String
    
}

extension Penguin: Racer {
    var speed: Double {
        return 42
    }
}

struct SwiftBird: Bird, Flyable {
    var name: String {return "Swift \(version)"}
    let version: Double
    
    var airspeedVelocity: Double {return version * 1000.0}
    
}

extension SwiftBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
        
    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are throw from the bridge of death!")
        }
        
    }
}

extension UnladenSwallow {
    var canFly: Bool {
        return self != .unknown
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        return canFly ? airspeedVelocity : 0
    }
}

UnladenSwallow.unknown.canFly
UnladenSwallow.african.canFly
Penguin(name: "King Penguin").canFly
UnladenSwallow.african

class Motorcycle {
    init(name: String) {
        self.name = name
        speed = 200
    }
    
    var name: String
    var speed: Double
}

extension Motorcycle: Racer {}

let racers: [Racer] =
    [UnladenSwallow.african,
     UnladenSwallow.european,
     UnladenSwallow.unknown,
     Penguin(name: "King Penguin"),
     SwiftBird(version: 3.0),
     FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
     Motorcycle(name: "Giacomo")
]

func topSpeed<RacerType: Sequence>(of racers: RacerType) -> Double
    where RacerType.Iterator.Element == Racer {
        return racers.max(by: { $0.speed < $1.speed})?.speed ?? 0
}

topSpeed(of: racers)

protocol Score: Equatable, Comparable {
    var value: Int { get }
}

struct RacingScore: Score {
    let value: Int
    
    static func ==(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value < rhs.value
    }
}

RacingScore(value: 150) >= RacingScore(value: 130) 

