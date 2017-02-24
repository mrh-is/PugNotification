import UIKit
import PlaygroundSupport

// Image credit: https://www.pinterest.com/pin/475270566903222569/
let pugView = PugView(image: #imageLiteral(resourceName: "pug.jpg"), size: 500)
pugView.tapAreasShown = true

let pugViewDelegate = PugNotifier()
pugView.delegate = pugViewDelegate

let printer = NotificationPrinter()

PlaygroundPage.current.liveView = pugView
