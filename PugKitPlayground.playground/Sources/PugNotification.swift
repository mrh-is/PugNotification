enum PugNotification {
    case arrive
    case blep(isBlepping: Bool)
    case boop(count: UInt)
    case pet(location: PetLocation)
    case leave(snack: SnackInfo)
}

public enum PetLocation {
    case ear
    case back
    case tummy
}

struct SnackInfo {
    let name: String
    let count: UInt
}

extension PugNotification: TypedNotification {
    public var name: String {
        switch self {
        case .arrive:
            return "pug.arrive"
        case .blep:
            return "pug.blep"
        case .boop:
            return "pug.boop"
        case .pet:
            return "pug.pet"
        case .leave:
            return "pug.leave"
        }
    }

    public var content: TypedNotificationContentType? {
        switch self {
        case .arrive:
            return nil
        case .blep(let isBlepping):
            return isBlepping
        case .boop(let count):
            return count
        case .pet(let location):
            return location
        case .leave(snack: let snack):
            return snack
        }
    }
}

extension Bool: TypedNotificationContentType {}
extension UInt: TypedNotificationContentType {}
extension PetLocation: TypedNotificationContentType {
    public init() {
        self = .ear
    }
}
extension SnackInfo: TypedNotificationContentType {
    public init() {
        self.init(name: "", count: 0)
    }
}
