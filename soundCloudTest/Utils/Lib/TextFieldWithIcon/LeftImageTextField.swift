//
//  LeftImageTextField.swift
//  myNews
//
//  Created by kennyS on 2/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import UIKit

@objc protocol LeftImageTextFieldDelegate: AnyObject {
    @objc optional func textFieldShouldReturn(_ textField: LeftImageTextField) -> Bool
    @objc optional func textFieldShouldBeginEditing(_ textField: LeftImageTextField) -> Bool
    @objc optional func textFieldDidBeginEditing(_ textField: LeftImageTextField)
    @objc optional func textFieldShouldEndEditing(_ textField: LeftImageTextField) -> Bool
    @objc optional func textFieldDidEndEditing(_ textField: LeftImageTextField)
    
    @objc optional func textField(_ textField: LeftImageTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    @objc optional func textFieldDidChangeSelection(_ textField: LeftImageTextField)
    @objc optional func textFieldShouldClear(_ textField: LeftImageTextField) -> Bool
}

class LeftImageTextField: UITextField {
    weak var leftImageTextFieldDelegate: LeftImageTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        delegate = self
        leftViewMode = .always
        rightViewMode = .always
    }
    
    var rightPadding: CGFloat = 0
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightRect = super.rightViewRect(forBounds: bounds)
        rightRect.origin.x -= rightPadding
        return rightRect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds)
    }
    
    var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    
    var imageColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    override func layoutSubviews() {
        UIView.performWithoutAnimation {
            super.layoutSubviews()
        }
    }
    
    private func updateView() {
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = imageColor
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
            leftPaddingView.addSubview(imageView)
            imageView.center = CGPoint(x: leftPaddingView.frame.size.width/2, y: leftPaddingView.frame.size.height/2)
            leftPaddingView.backgroundColor = .clear
            leftView = leftPaddingView
        } else {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        }
        if let rightImage = rightImage {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.image = rightImage
            imageView.tintColor = imageColor
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
            rightPaddingView.addSubview(imageView)
            imageView.center = CGPoint(x: rightPaddingView.frame.size.width/2, y: rightPaddingView.frame.size.height/2)
            rightView = rightPaddingView
        } else {
            rightView = nil
        }
    }
}

extension LeftImageTextField: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return leftImageTextFieldDelegate?.textFieldShouldClear?(self) ?? true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return leftImageTextFieldDelegate?.textFieldShouldBeginEditing?(self) ?? true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        leftImageTextFieldDelegate?.textFieldDidBeginEditing?(self)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return leftImageTextFieldDelegate?.textFieldShouldEndEditing?(self) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        leftImageTextFieldDelegate?.textFieldDidEndEditing?(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return leftImageTextFieldDelegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        leftImageTextFieldDelegate?.textFieldDidChangeSelection?(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        leftImageTextFieldDelegate?.textFieldShouldReturn?(self) ?? true
    }
}
