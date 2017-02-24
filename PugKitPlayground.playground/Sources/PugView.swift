import UIKit

public protocol PugViewDelegate: class {
    func didAppear()
    func didTap(on spot: PugView.Spot)
}

public class PugView: UIView {
    public enum Spot {
        case nose
        case mouth
        case ear
        case back
        case tummy
        case tail
    }

    public weak var delegate: PugViewDelegate?

    public var tapAreasShown = false {
        didSet {
            tapAreas.forEach({ $0.isShown = tapAreasShown })
        }
    }
    private var tapAreas = [TapArea]()

    public init(image: UIImage, size: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        super.init(frame: frame)
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(imageView)

        tapAreas = Spot.all.map({ TapArea(spot: $0, size: size, target: self) })
        tapAreas.forEach({ addSubview($0) })

        let finishButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        finishButton.addTarget(self, action: #selector(PugView.finish), for: .touchUpInside)
        addSubview(finishButton)
    }

    func finish() {
        print("$$$$$$$$\\ $$$$$$\\ $$\\   $$\\ ")
        print("$$  _____|\\_$$  _|$$$\\  $$ |")
        print("$$ |        $$ |  $$$$\\ $$ |")
        print("$$$$$\\      $$ |  $$ $$\\$$ |")
        print("$$  __|     $$ |  $$ \\$$$$ |")
        print("$$ |        $$ |  $$ |\\$$$ |")
        print("$$ |      $$$$$$\\ $$ | \\$$ |")
        print("\\__|      \\______|\\__|  \\__|")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { 
            print("")
            print("(You may now clap and then ask questions)")
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        delegate?.didAppear()
    }

    func didTap(area: TapArea) {
        delegate?.didTap(on: area.spot)
    }

    class TapArea: UIButton {
        let spot: Spot
        var isShown = false {
            didSet {
                let borderWidth: CGFloat = isShown ? 2 : 0
                layer.borderWidth = borderWidth
            }
        }

        init(spot: Spot, size: CGFloat, target: Any?) {
            self.spot = spot
            super.init(frame: spot.area(forSize: size))
            layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
            addTarget(target, action: #selector(PugView.didTap(area:)), for: .touchUpInside)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension PugView.Spot {
    fileprivate func area(forSize size: CGFloat) -> CGRect {
        let area = self.area
        return CGRect(x: area.origin.x*size/1000,
                      y: area.origin.y*size/1000,
                      width: area.width*size/1000,
                      height: area.height*size/1000)
    }

    private var area: CGRect {
        switch self {
        case .nose:
            return CGRect(x: 715, y: 345, width: 70, height: 65)
        case .mouth:
            return CGRect(x: 735, y: 415, width: 75, height: 80)
        case .ear:
            return CGRect(x: 400, y: 195, width: 130, height: 200)
        case .back:
            return CGRect(x: 285, y: 345, width: 135, height: 100)
        case .tummy:
            return CGRect(x: 235, y: 695, width: 180, height: 110)
        case .tail:
            return CGRect(x: 150, y: 285, width: 135, height: 180)
        }
    }

    fileprivate static var all = [PugView.Spot.nose, .mouth, .ear, .back, .tummy, .tail]
}
