//
//  MyPageViewModel.swift
//  myNews
//
//  Created by kennyS on 12/17/19.
//  Copyright © 2019 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MyPageViewModel: ViewModel {
    let errorTracker = ErrorTracker()
    private let bag = DisposeBag()
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension MyPageViewModel {
    struct Input {
            
    }
    
    struct Output {
        
    }
}
