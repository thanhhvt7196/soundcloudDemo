//
//  UIApplication+Extension.swift
//  myNews
//
//  Created by kennyS on 4/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

enum SelectCase {
    case confirm
    case cancel
}

extension UIApplication {
    func showErrorAlert(title: String = Strings.error, message: String, cancelTitle: String = Strings.OK, completion: (() -> Void)? = nil) {
        let messageView = MessageView.viewFromNib(layout: .centeredView)
        messageView.button?.setTitle(cancelTitle, for: .normal)
        messageView.configureContent(title: title, body: message)
        let messageHelper = MessageHelper(messageView: messageView, theme: .error)
        messageView.buttonTapHandler = { _ in
            messageHelper.hide(animated: true)
            completion?()
        }
        messageHelper.show()
    }
    
    func showConfirmAlert(title: String?, message: String?, cancelTitle: String = Strings.cancel, confirmTitle: String = Strings.OK, completion: @escaping((SelectCase) -> Void)) {
        let confirmView = ConfirmDialogView(title: title, message: message, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        let baseView = BaseView(frame: .zero)
        baseView.installContentView(confirmView)
        baseView.layoutMargins = .zero
        baseView.layoutMarginAdditions = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        let messageHelper = MessageHelper(contentView: baseView)
        confirmView.getCancelAction = {
            messageHelper.hide(animated: true)
            completion(.cancel)
        }
        confirmView.getConfirmAction = {
            messageHelper.hide(animated: true)
            completion(.confirm)
        }
        messageHelper.show()
    }
}

extension UIApplication {
    func getRootViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
}
