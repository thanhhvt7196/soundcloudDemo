//
//  PageControl+RxSwift.swift
//  myNews
//
//  Created by kennyS on 4/18/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: FlexiblePageControl {
    var currentPage: Binder<Int> {
        return Binder(base) { pageControl, currentPage in
            pageControl.setCurrentPage(at: currentPage)
        }
    }
    
    var numberOfPage: Binder<Int> {
        return Binder(base) { pageControl, numberOfPage in
            pageControl.numberOfPages = numberOfPage
        }
    }
}
