
//
//  MyPageController.swift
//  myNews
//
//  Created by kennyS on 12/17/19.
//  Copyright © 2019 kennyS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import SVProgressHUD

class MyPageController: BaseController, StoryboardBased, ViewModelBased {
    
    var viewModel: MyPageViewModel!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
