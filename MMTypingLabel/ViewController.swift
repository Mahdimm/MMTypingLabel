//
//  ViewController.swift
//  MMTypingLabel
//
//  Created by NiliN on 2/22/20.
//  Copyright © 2020 Cocoapods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label: MMTypingLabel!
    var secondLabel: MMTypingLabel!
    var pauseBtn: UIButton!
    var startBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = MMTypingLabel(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 40))
        label.textAlignment   = .center
        label.text            = "hi it would be cool"
        view.addSubview(label)
        
        secondLabel = MMTypingLabel(frame: CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 60))
        secondLabel.textAlignment = .center
        let attributedQuote = NSMutableAttributedString(string: "atributed string")
        
        let attributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.yellow, NSAttributedString.Key.ligature: 10]
        attributedQuote.addAttributes(attributes, range: NSRange(location: 0, length: 6))
        
        secondLabel.attributedText = attributedQuote
        view.addSubview(secondLabel)
        
        label.didFinishAnimating = { [weak self] in
            self?.doSomething()
        }
        
        pauseBtn = UIButton(frame: CGRect(x: 40, y: 200, width: UIScreen.main.bounds.width - 80, height: 40))
        pauseBtn.backgroundColor = .blue
        pauseBtn.setTitle("Pause", for: .normal)
        pauseBtn.setTitleColor(.white, for: .normal)
        pauseBtn.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        view.addSubview(pauseBtn)
        
        startBtn = UIButton(frame: CGRect(x: 40, y: 300, width: UIScreen.main.bounds.width - 80, height: 40))
        startBtn.backgroundColor = .blue
        startBtn.setTitle("Start", for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.addTarget(self, action: #selector(startAnimating(_:)), for: .touchUpInside)
        view.addSubview(startBtn)
    }
    
    @objc func handleButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Pause" {
            pauseBtn.setTitle("Continue", for: .normal)
            label.pause()
        } else {
            pauseBtn.setTitle("Pause", for: .normal)
            label.continueAnimating()
        }
    }
    
    @objc func startAnimating(_ sender: UIButton) {
        label.clear()
        label.text = "The same question"
    }
    
    func doSomething() {
        print("FINISH")
    }

}

