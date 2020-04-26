//
//  PlayerControllerViewModel.swift
//  soundCloudTest
//
//  Created by kennyS on 4/24/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PlayerControllerViewModel: ViewModel {
    let errorTracker = ErrorTracker()
    let tracks = BehaviorRelay<[Track]>(value: [])
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension PlayerControllerViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
