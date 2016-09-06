//
//  YJTextField.swift
//  YJTextField
//
//  Created by Jet on 16/9/6.
//  Copyright © 2016年 Jet. All rights reserved.
//

import UIKit

class YJTextField: UIView {
    var moveLengthY: CGFloat = 5.0
    var moveLengthX: CGFloat = 2.0
    var lineHeight: CGFloat = 1.0
    var animationDuration: NSTimeInterval = 0.15
    
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    var placeholderNormalColor: UIColor! = UIColor.lightGrayColor() {
        didSet {
            placeholderLabel.textColor = placeholderNormalColor
        }
    }
    
    var placeholderSelectColor: UIColor! = UIColor.lightGrayColor()
    
    var placeholderNormalFont: UIFont! = UIFont.systemFontOfSize(13) {
        didSet {
            placeholderLabel.font = placeholderNormalFont
        }
    }
    
    var placeholderSelectFont: UIFont! =  UIFont.systemFontOfSize(10)
    
    var cursorTintColor: UIColor! {
        didSet {
            textField.tintColor = cursorTintColor
        }
    }
    
    var delegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = delegate
        }
    }
    
    private(set) var textField: UITextField!
    private var lineView: UIView!
    private var placeholderLabel: UILabel!
    private var lineLayer: CALayer!
    private var changed: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        textField = UITextField(frame: CGRectZero)
        textField.borderStyle = .None
        textField.font = UIFont.systemFontOfSize(15.0)
        textField.textColor = UIColor.whiteColor()
        textField.tintColor = UIColor.whiteColor()
        addSubview(textField)
        
        placeholderLabel = UILabel(frame: CGRectZero)
        placeholderLabel.textColor = placeholderNormalColor
        placeholderLabel.font = placeholderNormalFont
        addSubview(placeholderLabel)
        
        lineView = UIView(frame: CGRectZero)
        lineView.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView)
        
        lineLayer = CALayer()
        lineLayer.frame = CGRectZero
        lineLayer.anchorPoint = CGPointMake(0, 0.5)
        lineLayer.backgroundColor = UIColor.whiteColor().CGColor
        lineView.layer.addSublayer(lineLayer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YJTextField.textFieldInputDidChanged(_:)), name: UITextFieldTextDidChangeNotification, object: textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = CGRectGetWidth(bounds)
        let height = CGRectGetHeight(bounds)
        
        textField.frame = CGRectMake(0, 0, width, height - lineHeight)
        lineView.frame = CGRectMake(0, height - lineHeight, width, lineHeight)
        placeholderLabel.frame = CGRectMake(0, 0, width, height - lineHeight)
    }
    
    func textFieldInputDidChanged(noti: NSNotification) {
        startAnimation()
    }
    
    func startAnimation() {
        let inputSomething = textField.text?.characters.count != 0
        if inputSomething && !changed {
            moveToTop()
        }
        else if !inputSomething && changed {
            backToDefault()
        }
    }
    
    func moveToTop() {
        var x = placeholderLabel.center.x
        var y = placeholderLabel.center.y

        UIView.animateWithDuration(animationDuration) {
            x -= self.moveLengthX
            y -= (self.placeholderLabel.frame.height * 0.5 + self.moveLengthY)
            self.placeholderLabel.center = CGPointMake(x, y)
            
            self.lineLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.lineHeight)
            
            self.placeholderLabel.font = self.placeholderSelectFont
            self.placeholderLabel.textColor = self.placeholderSelectColor
            
            self.changed = true
        }
    }
    
    func backToDefault() {
        var x = placeholderLabel.center.x
        var y = placeholderLabel.center.y
        
        UIView.animateWithDuration(animationDuration) {
            x += self.moveLengthX
            y += (self.placeholderLabel.frame.height * 0.5 + self.moveLengthY)
            self.placeholderLabel.center = CGPointMake(x, y)
            
            self.lineLayer.bounds = CGRectMake(0, 0, 0, self.lineHeight)
            
            self.placeholderLabel.font = self.placeholderNormalFont
            self.placeholderLabel.textColor = self.placeholderNormalColor
            
            self.changed = false
        }
    }
}
