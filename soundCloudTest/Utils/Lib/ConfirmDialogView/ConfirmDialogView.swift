//
//  ConfirmDialogView.swift
//  myNews
//
//  Created by kennyS on 4/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import UIKit
import Reusable

class ConfirmDialogView: UIView, NibOwnerLoadable {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var getConfirmAction: (() -> Void)?
    var getCancelAction: (() -> Void)?
    
    convenience init(title: String?, message: String?, cancelTitle: String, confirmTitle: String) {
        self.init()
        configDialog(title: title, message: message, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
    }
    
    private func commonInit() {
        loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func configDialog(title: String?, message: String?, cancelTitle: String, confirmTitle: String) {
        cancelButton.setTitle(cancelTitle, for: .normal)
        confirmButton.setTitle(confirmTitle, for: .normal)
        titleLabel.text = title
        messageLabel.text = message
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        getCancelAction?()
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        getConfirmAction?()
    }
}
