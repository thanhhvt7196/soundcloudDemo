//
//  MiniPlayerView.swift
//  soundCloudTest
//
//  Created by kennyS on 4/24/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import RxSwift
import RxCocoa

class MiniPlayerView: UIView, NibOwnerLoadable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var titleLabel: MarqueeLabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private let bag = DisposeBag()
    
    private func commonInit() {
        loadNibContent()
        bind()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configView(track: Track) {
        titleLabel.text = track.title
        artistLabel.text = track.user?.username
    }
    
    private func bind() {
        likeButton.rx.tap
            .subscribe(onNext: { _ in
                print("like tapped")
            })
            .disposed(by: bag)
        
        playButton.rx.tap
            .subscribe(onNext: { _ in
                print("play tapped")
            })
            .disposed(by: bag)
    }
    
    func enableInteraction(_ isEnable: Bool) {
        likeButton.isEnabled = isEnable
        playButton.isEnabled = isEnable
    }
}
