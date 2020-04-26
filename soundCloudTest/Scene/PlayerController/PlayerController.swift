//
//  PlayerController.swift
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

class PlayerController: BaseController, StoryboardBased, ViewModelBased {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var miniPlayerView: MiniPlayerView!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    
    var viewModel: PlayerControllerViewModel!
    
    override func loadView() {
        super.loadView()
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            stackViewBottomConstraint.constant += window.safeAreaInsets.bottom
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bind()
    }
    
    private func prepareUI() {
        miniPlayerView.alpha = 1
        contentView.alpha = 0
    }
    
    private func bind() {
        
    }
    
    func setupMiniPlayer(with track: Track) {
        miniPlayerView.configView(track: track)
    }
}
