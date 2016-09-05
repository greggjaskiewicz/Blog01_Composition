//: Playground - noun: a place where people can play

import PlaygroundSupport

import UIKit
import CoreGraphics

final class BlinkingButtonViewController: UIViewController {

    private var button: UIButton?
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.button = UIButton(frame: CGRect(x: 250, y: 250, width: 100, height: 50))
        if let button = self.button {
            button.layer.shouldRasterize = true
            button.backgroundColor = UIColor.green
            button.setTitle("Boom Boom", for: .normal)
            button.titleLabel?.textColor = UIColor.black
            self.view.addSubview(button)
            self.view.backgroundColor = UIColor.lightGray
        }

        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    private let buttonScaleIdentity = CGAffineTransform.init(scaleX: 1.75, y: 1.75)

    func timerAction(timer: Timer) {

        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.button?.transform = self.buttonScaleIdentity
        }) { (completed) in
            if (completed) {
                UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut,
                               animations: {
                                self.button?.transform = CGAffineTransform.identity
                    }, completion: { (_) in })
            }
        }
    }

    deinit {
        self.timer?.invalidate()
        self.button = nil
    }
}

let x = BlinkingButtonViewController()

PlaygroundPage.current.liveView = x.view




