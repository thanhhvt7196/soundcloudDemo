//
//  CategoryController.swift
//  myNews
//
//  Created by kennyS on 2/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Reusable
import SVProgressHUD

class CategoryViewController: BaseController, StoryboardBased, ViewModelBased {
    var viewModel: CategoryViewModel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bind()
    }
    
    private func prepareUI() {
        navigationItem.title = Strings.categories
    }
    
    private func bind() {
        let input = CategoryViewModel.Input()
        let output = viewModel.transform(input: input)
    }
}
