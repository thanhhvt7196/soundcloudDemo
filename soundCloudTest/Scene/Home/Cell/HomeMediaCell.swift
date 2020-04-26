//
//  HomeMediaCell.swift
//  soundCloudTest
//
//  Created by kennyS on 4/26/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class HomeMediaCell: UITableViewCell, NibReusable {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var bag = DisposeBag()
    private var viewModel: HomeMediaCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func prepareUI() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func bindViewModel(viewModel: HomeMediaCellViewModel) {
        self.viewModel = viewModel
        bindData()
    }
    
    private func bindData() {
        viewModel.track
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.track
            .map { $0.user?.username }
            .bind(to: artistLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.track
            .map { $0.artworkURL }
            .unwrap()
            .mapToURL()
            .bind(to: bannerImageView.rx.imageURL)
            .disposed(by: bag)
    }
}
