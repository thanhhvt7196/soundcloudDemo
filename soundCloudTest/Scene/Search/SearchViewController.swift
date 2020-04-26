//
//  SearchViewController.swift
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

class SearchViewController: BaseController, StoryboardBased, ViewModelBased {
    @IBOutlet weak var searchTextField: LeftImageTextField!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func prepareUI() {
        configTableView()
        configSearchBar()
    }
    
    private func configTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func configSearchBar() {
        searchTextField.leftImage = UIImage(named: "search")
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.textColor = .black
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for news", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
    
    private func bind() {
        let keyword = searchTextField.rx.text
            .debounce(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .asObservable()
            .unwrap()
            .filter { $0.replacingOccurrences(of: " ", with: "").count > 0 }
        
        let input = SearchViewModel.Input()
        let output = viewModel.transform(input: input)
    }
}
