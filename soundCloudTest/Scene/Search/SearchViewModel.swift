//
//  SearchViewModel.swift
//  myNews
//
//  Created by kennyS on 2/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModel {
    let errorTracker = ErrorTracker()
    
    private let bag = DisposeBag()
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension SearchViewModel {
    struct Input {

    }
    
    struct Output {

    }
}
