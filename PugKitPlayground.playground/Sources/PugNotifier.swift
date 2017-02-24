public class PugNotifier: PugViewDelegate {
    private class PugModel {
        var isBlepping = false
        var boopCount: UInt = 0
    }
    private let pug = PugModel()

    public init() {}

    public func didAppear() {
        PugNotification.post(.arrive)
    }

    public func didTap(on spot: PugView.Spot) {
        switch spot {
        case .nose:
            pug.boopCount += 1
            PugNotification.post(.boop(count: pug.boopCount))
        case .mouth:
            pug.isBlepping = !pug.isBlepping
            PugNotification.post(.blep(isBlepping: pug.isBlepping))
        case .ear:
            PugNotification.post(.pet(location: .ear))
        case .back:
            PugNotification.post(.pet(location: .back))
        case .tummy:
            PugNotification.post(.pet(location: .tummy))
        case .tail:
            PugNotification.post(.leave(snack: SnackInfo(name: "treat", count: 2)))
        }
    }
}
