//
//  CategoryViewModel.swift
//  myNews
//
//  Created by kennyS on 2/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CategoryViewModel: ViewModel {
    var errorTracker = ErrorTracker()
    private let bag = DisposeBag()
    
    var isFirstLaunnch = true
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension CategoryViewModel {
    struct Input {

    }
    
    struct Output {
        
    }
}
