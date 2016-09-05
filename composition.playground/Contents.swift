//: Playground - noun: a place where people can play

import PlaygroundSupport

import UIKit
import CoreGraphics

final class PulsateViewAnimator: NSObject {

    private weak var view: UIView?

    private var timer: Timer?
    private let breathOutDuration: TimeInterval
    private let holdDuration: TimeInterval
    private let breathInDuration: TimeInterval
    private let pulseScaleIdentity: CGAffineTransform

    init(view: UIView, pulseScale: CGFloat,
         breathOutDuration: TimeInterval,
         holdDuration: TimeInterval,
         breathInDuration: TimeInterval,
         intervalBetweenPulses: TimeInterval)
    {

        self.view = view
        self.breathInDuration = breathInDuration
        self.breathOutDuration = breathOutDuration
        self.holdDuration = holdDuration
        self.pulseScaleIdentity = CGAffineTransform.init(scaleX: pulseScale, y: pulseScale)

        super.init()

        // setup
        self.timer = Timer.scheduledTimer(timeInterval: intervalBetweenPulses, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }


    @objc func timerAction(timer: Timer) {

        UIView.animate(withDuration: self.breathOutDuration, delay: self.holdDuration, options: .curveEaseInOut, animations: {
            self.view?.transform = self.pulseScaleIdentity
        }) { (completed) in
            if (completed) {
                UIView.animate(withDuration: self.breathInDuration, delay: self.holdDuration, options: .curveEaseInOut,
                               animations: {
                                self.view?.transform = CGAffineTransform.identity
                    }, completion: { (_) in })
            }
        }
    }

    deinit {
        self.timer?.invalidate()
        self.view = nil
    }
}


let button = UIButton(frame: CGRect(x: 75, y: 75, width: 100, height: 50))

let buttonAnimator = PulsateViewAnimator(view: button, pulseScale: 1.75, breathOutDuration: 0.5, holdDuration: 0.3, breathInDuration: 0.5, intervalBetweenPulses: 5)

button.backgroundColor = UIColor.green
button.setTitle("Boom Boom", for: .normal)
button.titleLabel?.textColor = UIColor.black

let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

PlaygroundPage.current.liveView = view
view.addSubview(button)
view.backgroundColor = UIColor.lightGray

let count = 15
let center = CGPoint(x: view.frame.width/2, y:view.frame.height/2)
button.center = center

let radius : CGFloat = 100
var angle = CGFloat(2 * M_PI)

for i in 1...count {

    let x = cos(angle) * radius + center.x
    let y = sin(angle) * radius + center.y

    let step = CGFloat(2 * M_PI) / CGFloat(count)

    let button = UIButton(frame: CGRect(x: x, y: y, width: 30, height: 30))

    let buttonAnimator = PulsateViewAnimator(view: button, pulseScale: 0.5, breathOutDuration: 0.2, holdDuration: 0.0, breathInDuration: 0.2, intervalBetweenPulses: 0.2+0.2+0.4)

    button.backgroundColor = UIColor.cyan
    button.setTitle("o/", for: .normal)
    button.titleLabel?.textColor = UIColor.black
    view.addSubview(button)
    button.center = CGPoint(x: x, y: y)

    angle += step
}

