//
//  MessageHelper.swift
//  myNews
//
//  Created by kennyS on 4/1/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

@objc protocol MessageHelperDelegate: class {
    @objc optional func messageWillShow()
    @objc optional func messageDidShow()
    @objc optional func messageWillHide()
    @objc optional func messageDidHide()
}

class MessageHelper: NSObject {
    private let swiftMessages = SwiftMessages.sharedInstance
    private var messageView: MessageView? = nil
    private var contentview: UIView? 
    private let presentationStyle: SwiftMessages.PresentationStyle
    private let presentationContext: SwiftMessages.PresentationContext
    private let dimMode: SwiftMessages.DimMode
    private let interactiveHide: Bool
    private let statusBarStyle: UIStatusBarStyle
    private let theme: Theme
    private let statusBarHidden: Bool
    
    weak var delegate: MessageHelperDelegate?
    
    init(messageView: MessageView,
         position: SwiftMessages.PresentationStyle = .center,
         context: SwiftMessages.PresentationContext = .window(windowLevel: .alert),
         dimMode: SwiftMessages.DimMode = .gray(interactive: true),
         interactiveHide: Bool = true,
         statusBarStyle: UIStatusBarStyle = .default,
         statusBarHidden: Bool = false,
         theme: Theme) {
        self.messageView = messageView
        self.theme = theme
        self.presentationStyle = position
        self.presentationContext = context
        self.dimMode = dimMode
        self.interactiveHide = interactiveHide
        self.statusBarStyle = statusBarStyle
        self.statusBarHidden = statusBarHidden
        super.init()

        setupMessage()
    }
    
    init(contentView: UIView,
         position: SwiftMessages.PresentationStyle = .center,
         context: SwiftMessages.PresentationContext = .window(windowLevel: .alert),
         dimMode: SwiftMessages.DimMode = .gray(interactive: true),
         interactiveHide: Bool = true,
         statusBarStyle: UIStatusBarStyle = .default,
         statusBarHidden: Bool = false) {
        self.contentview = contentView
        self.theme = .info
        self.presentationStyle = position
        self.presentationContext = context
        self.dimMode = dimMode
        self.interactiveHide = interactiveHide
        self.statusBarStyle = statusBarStyle
        self.statusBarHidden = statusBarHidden
        super.init()

        setupMessage()
    }
    
    private func setupMessage() {
        swiftMessages.defaultConfig.presentationStyle = presentationStyle
        swiftMessages.defaultConfig.presentationContext = presentationContext
        swiftMessages.defaultConfig.dimMode = dimMode
        swiftMessages.defaultConfig.interactiveHide = interactiveHide
        swiftMessages.defaultConfig.preferredStatusBarStyle = statusBarStyle
        swiftMessages.defaultConfig.prefersStatusBarHidden = statusBarHidden
        swiftMessages.defaultConfig.keyboardTrackingView = KeyboardTrackingView()
        
        swiftMessages.defaultConfig.eventListeners.append { event in
            switch event {
            case .willShow:
                self.delegate?.messageWillShow?()
            case .didShow:
                self.delegate?.messageDidShow?()
            case .willHide:
                self.delegate?.messageWillShow?()
            case .didHide:
                self.delegate?.messageDidHide?()
            }
        }
    }
    
    func show() {
        if let messageView = messageView {
            messageView.configureTheme(theme)
            messageView.configureDropShadow()
            messageView.layoutMarginAdditions = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
            (messageView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
            swiftMessages.show(view: messageView)
        } else {
            if let contentView = contentview {
                
                swiftMessages.show(view: contentView)
            }
        }
        
    }
    
    func hide(animated: Bool) {
        swiftMessages.hide(animated: animated)
    }
    
    func hideAll() {
        swiftMessages.hideAll()
    }
}
