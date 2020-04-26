//
//  HomeViewController.swift
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

class HomeViewController: BaseController, StoryboardBased, ViewModelBased {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    private let bag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    private let loadDataTrigger = PublishSubject<Void>()
    private let mediaServices = MediaServices.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bindData()
        loadData()
    }
    
    private func prepareUI() {
        configNavigationBar()
        configTableView()
        configProgressHUD()
    }
    
    private func configNavigationBar() {
        navigationItem.title = Strings.home
    }
    
    private func configProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
//        tableView.refreshControl = refreshControl
        refreshControl.tintColor = .black
        tableView.register(cellType: HomeMediaCell.self)
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
    }
    
    private func bindData() {
        let input = HomeViewModel.Input(loadDataTrigger: loadDataTrigger, itemSelected: tableView.rx.itemSelected.asObservable())
        let output = viewModel.transform(input: input)
        
        output.loading
            .bind(to: SVProgressHUD.rx.isAnimating)
            .disposed(by: bag)
        
        let tracks = output.playLists
        
        tracks
            .bind(to: tableView.rx.items) { tableView, row, item in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath) as HomeMediaCell
                let viewModel = HomeMediaCellViewModel(track: item)
                cell.bindViewModel(viewModel: viewModel)
                return cell
            }
            .disposed(by: bag)
        
        tableView.rx.itemSelected
            .withLatestFrom(tracks) { indexPath, tracks -> (Int, [Track]) in
                return (indexPath.row, tracks)
            }
            .subscribe(onNext: { [weak self] index, tracks in
                guard let self = self else { return }
                self.mediaServices.tracks = tracks
                self.playMedia(index: index)
            })
            .disposed(by: bag)
    }
}

extension HomeViewController {
    private func playMedia(index: Int) {
        guard let tabbarController = UIApplication.shared.getRootViewController() as? RootTabbarController else {
            return
        }
        tabbarController.configPlayerView(index: index)
    }
}

extension HomeViewController {
    private func loadData() {
        loadDataTrigger.onNext(())
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
