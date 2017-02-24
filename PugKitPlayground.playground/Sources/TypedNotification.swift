import Foundation

protocol TypedNotification {
    var name: String { get }
    var content: TypedNotificationContentType? { get }
}

protocol TypedNotificationContentType {
    init()
}

class ObserverToken {
    fileprivate let observer: NSObjectProtocol

    fileprivate init(observer: NSObjectProtocol) {
        self.observer = observer
    }
}

extension TypedNotification {
    static func post(_ notification: Self) {
        let name = Notification.Name(rawValue: notification.name)
        let userInfo = notification.content.map({ ["content": $0] })
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
    }

    static func addObserver(_ notification: Self, using block: @escaping () -> Void) -> ObserverToken {
        let name = Notification.Name(rawValue: notification.name)
        let observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { _ in
            block()
        }
        return ObserverToken(observer: observer)
    }
    static func addObserver
        <ContentType: TypedNotificationContentType>
        (_ notification: (ContentType) -> Self,
         using block: @escaping (ContentType) -> Void)
        -> ObserverToken {
            let name = Notification.Name(rawValue: notification(ContentType()).name)
            let observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { notification in
                if let content = notification.userInfo?["content"] as? ContentType {
                    block(content)
                }
            }
            return ObserverToken(observer: observer)
    }

    static func removeObserver(_ observer: ObserverToken) {
        NotificationCenter.default.removeObserver(observer.observer)
    }
}
