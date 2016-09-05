//: Playground - noun: a place where people can play

import PlaygroundSupport

import UIKit
import CoreGraphics

final class BlinkingButton: UIButton {
    private var timer: Timer?

    func setup() {
        self.layer.shouldRasterize = true

        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

    }
    private let buttonScaleIdentity = CGAffineTransform.init(scaleX: 1.75, y: 1.75)

    func timerAction(timer: Timer) {

        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.transform = self.buttonScaleIdentity
        }) { (completed) in
            if (completed) {
                UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut,
                               animations: {
                                self.transform = CGAffineTransform.identity
                    }, completion: { (_) in })
            }
        }
    }

    deinit {
        self.timer?.invalidate()
    }

}

let button = BlinkingButton(frame: CGRect(x: 75, y: 75, width: 100, height: 50))

button.backgroundColor = UIColor.green
button.setTitle("Boom Boom", for: .normal)
button.titleLabel?.textColor = UIColor.black


let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

PlaygroundPage.current.liveView = view
view.addSubview(button)
button.center = view.center
view.backgroundColor = UIColor.lightGray
button.setup()
