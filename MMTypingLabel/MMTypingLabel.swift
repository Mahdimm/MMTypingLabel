//
//  MMTypingLabel.swift
//  MMTypingLabel
//
//  Created by Mahdi Mahjoobi on 2/22/20.
//  Copyright © 2020 Cocoapods. All rights reserved.
//

import UIKit

@IBDesignable public class MMTypingLabel: UILabel {
    
    /// Setting delay for showing next character
    @IBInspectable public var interval: Double = 0.2
    
    /// Calling when animation finished
    public var didFinishAnimating: (() -> Void)?
    
    // Private instances
    private var pauseTyping  = false
    private var finishTyping = false
    private var attributes: [NSAttributedString.Key: Any]?
    private var pausedText: String? = nil
        
    public override var text: String? {
        get {
            return super.text
        }

        set {
            guard let text = newValue, text.count > 0 else {
                return
            }
            
            setTextWithAnimation(typingText: text)
        }
    }
    
    public override var attributedText: NSAttributedString? {
        get {
            return super.attributedText
        }

        set {
            guard let text = newValue?.string, text.count > 0 else {
                return
            }
            
            attributes = newValue?.attributes(at: 0, effectiveRange: nil)
            setTextWithAnimation(typingText: text, attributes: attributes)
        }
    }
    
    /**
     Pause text animating
    */
    public func pause() {
        pauseTyping = true
    }
    
    /**
     Continue text animating
    */
    public func continueAnimating() {
        if finishTyping && !pauseTyping {
            return
        }
        
        guard let text = pausedText else {
            return
        }
        
        pauseTyping = false
        
        setTextWithAnimation(typingText: text, attributes: attributes)
    }
    
    /**
     Clear current label text
    */
    func clear() {
        super.text = nil
    }
    
    // MARK: - Set text for type animating
    private func setTextWithAnimation(typingText: String, attributes: Dictionary<NSAttributedString.Key, Any>? = nil) {
        guard typingText.count > 0 else {
            finishTyping = true

            if let notNilClosure = didFinishAnimating {
                DispatchQueue.main.sync(execute: notNilClosure)
            }
            
            return
        }
                                
        DispatchQueue.main.async {
            if super.text == nil {
                super.text = ""
            }
            
            if self.pauseTyping {
                self.pausedText = typingText
                return
            }
            
            if let firstChar = typingText.first {
                if let attr = attributes {
                    super.attributedText = NSAttributedString(string: super.attributedText!.string +  String(firstChar), attributes: attr)
                } else {
                    super.text = super.text! + String(firstChar)
                }
            }
            
            DispatchQueue(label: "TypingLabel").asyncAfter(deadline: .now() + self.interval) {
                self.setTextWithAnimation(typingText: String(typingText.dropFirst()), attributes: attributes)
            }
        }
        
    }
    
}
