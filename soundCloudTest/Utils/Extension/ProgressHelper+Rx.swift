//
//  ProgressHelper+Rx.swift
//  myNews
//
//  Created by kennyS on 4/19/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: ProgressHelper {
    static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) { _, isAnimating in
            isAnimating ? ProgressHelper.shared.show() : ProgressHelper.shared.hide()
        }
    }
}
