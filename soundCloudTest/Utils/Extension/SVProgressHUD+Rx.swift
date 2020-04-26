//
//  SVProgressHUD+RxSwift.swift
//  myNews
//
//  Created by kennyS on 3/27/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD

extension Reactive where Base: SVProgressHUD {
    static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) { _, isVisible in
            isVisible ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
    }
}
