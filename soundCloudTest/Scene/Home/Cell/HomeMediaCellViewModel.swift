//
//  HomeMediaCellViewModel.swift
//  soundCloudTest
//
//  Created by kennyS on 4/26/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift

class HomeMediaCellViewModel {
    var track: Observable<Track>
    
    init(track: Track) {
        self.track = .just(track)
    }
}
