//
//  BaseController.swift
//  myNews
//
//  Created by kennyS on 12/16/19.
//  Copyright © 2019 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var isStatusBarHidden = false
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    func setStatusBarHidden(_ isHidden: Bool) {
        isStatusBarHidden = isHidden
        UIView.animate(withDuration: 0.1) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
