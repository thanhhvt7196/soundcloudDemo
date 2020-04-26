//
//  RootTabbarController.swift
//  myNews
//
//  Created by kennyS on 12/17/19.
//  Copyright © 2019 kennyS. All rights reserved.
//

import Foundation
import Reusable
import UIKit
import RAMAnimatedTabBarController

class RootTabbarController: RAMAnimatedTabBarController, StoryboardBased {
    private var playerViewController: PlayerController!
    private var isFirstLaunch = true
    private var panGesture: UIPanGestureRecognizer?
    private let miniPlayerHeight: CGFloat = 40
    private let screenSize = UIScreen.main.bounds
    private let distanceToHideMiniPlayer: CGFloat = 150
    private var containerView: UIView!
    private var tabbarY: CGFloat!
    private let mediaServices = MediaServices.shared
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    private var isStatusBarHidden = false {
        didSet {
            guard let navigationController = selectedViewController as? UINavigationController,
                let currentController = navigationController.visibleViewController as? BaseController
            else {
                return
            }
            currentController.setStatusBarHidden(isStatusBarHidden)
        }
    }
    
    private var fullPlayerPercentage: CGFloat {
        let contentHeight = screenSize.height - tabBar.frame.height - miniPlayerHeight
        return (contentHeight - containerView.frame.origin.y) / contentHeight
    }
    
    private var miniPlayerPercentage: CGFloat {
        let contentHeight = screenSize.height - tabBar.frame.height - miniPlayerHeight
        if contentHeight - containerView.frame.origin.y > distanceToHideMiniPlayer {
            return 1
        } else {
            return (contentHeight - containerView.frame.origin.y) / distanceToHideMiniPlayer
        }
    }
    
    private var fullPlayerContentPercentage: CGFloat {
        let contentHeight = screenSize.height - tabBar.frame.height - miniPlayerHeight
        if containerView.frame.origin.y > contentHeight - distanceToHideMiniPlayer {
            return 0
        } else {
            return 1 - containerView.frame.origin.y / (contentHeight - distanceToHideMiniPlayer)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func loadView() {
        super.loadView()
        let playerViewModel = PlayerControllerViewModel()
        playerViewController = PlayerController.instantiate(withViewModel: playerViewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
        prepareUI()
    }
    
    private func prepareUI() {
        configTabbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLaunch {
            configPlayerView()
            configPanGesture()
            isFirstLaunch = false
        }
    }
    
    private func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configTabbar() {
        tabBar.tintColor = .themeOrange
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
    }
    
    private func configPlayerView() {
        print("tabbar frame y = \(tabBar.frame.origin.y)")
        tabbarY = tabBar.frame.origin.y
        containerView = UIView(frame: CGRect(x: 0, y: screenSize.height - tabBar.frame.height - miniPlayerHeight, width: screenSize.width, height: screenSize.height))
        containerView.isHidden = true
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        view.bringSubviewToFront(tabBar)
        
        addChild(playerViewController)
        playerViewController.view.frame = containerView.bounds
        containerView.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
    }
    
    private func configPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture?.maximumNumberOfTouches = 1
        panGesture?.delegate = self
        panGesture?.cancelsTouchesInView = false
        playerViewController.view.addGestureRecognizer(panGesture!)
    }
}

extension RootTabbarController {
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let contentHeight = screenSize.height - tabBar.frame.height - miniPlayerHeight
        switch gesture.state {
        case .began:
            playerViewController.miniPlayerView.enableInteraction(false)
        case .changed:
            let containerY = containerView.frame.origin.y
            if containerY <= contentHeight && containerY >= view.bounds.origin.y {
                if containerY + translation.y < 0 {
                    containerView.frame.origin.y = view.bounds.origin.y
                    tabBar.frame.origin.y = tabbarY + tabBar.frame.height
                } else if containerY + translation.y > contentHeight {
                    containerView.frame.origin.y = contentHeight
                    tabBar.frame.origin.y = tabbarY
                } else {
                    containerView.frame.origin.y += translation.y
                    tabBar.frame.origin.y -= translation.y * (tabBar.frame.height/contentHeight)
                }
                print("tabbar frame = \(tabBar.frame.origin.y)")
                playerViewController.miniPlayerView.alpha = 1 - miniPlayerPercentage
                playerViewController.contentView.alpha = fullPlayerContentPercentage
                gesture.setTranslation(.zero, in: view)
            }
        case .ended:
            let velocity = gesture.velocity(in: view)
            if velocity.y > 0 {
//                self.isStatusBarHidden = false
                UIView.animate(withDuration: 0.2, animations: {
                    self.containerView.frame.origin.y = self.tabbarY - self.miniPlayerHeight
                    self.playerViewController.miniPlayerView.alpha = 1
                    self.playerViewController.contentView.alpha = 0
                    self.tabBar.frame.origin.y = self.tabbarY
                }) { _ in
                    self.playerViewController.miniPlayerView.enableInteraction(true)
                    print("end gesture frame = \(self.tabBar.frame.origin.y)")
                }
            } else {
//                self.isStatusBarHidden = true
                UIView.animate(withDuration: 0.2, animations: {
                    self.containerView.frame.origin.y = 0
                    self.playerViewController.miniPlayerView.alpha = 0
                    self.playerViewController.contentView.alpha = 1
                    self.tabBar.frame.origin.y = self.tabbarY + self.tabBar.frame.height
                }) { _ in
                    self.playerViewController.miniPlayerView.enableInteraction(false)
                    print("tabbar frame = \(self.tabBar.frame.height)")
                }
            }
        default:
            break
        }
    }
}

extension RootTabbarController {
    @objc private func willEnterForeground() {
        if fullPlayerPercentage < 0.5 {
            tabBar.frame.origin.y = tabbarY
        } else {
            tabBar.frame.origin.y = tabbarY + tabBar.frame.height
        }
    }
}

extension RootTabbarController {
    func configPlayerView(index: Int) {
        guard mediaServices.tracks.indices.contains(index) else {
            return
        }
        playerViewController.setupMiniPlayer(with: mediaServices.tracks[index])
        containerView.isHidden = false
    }
}

extension RootTabbarController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let recognizer = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        let velocity = recognizer.velocity(in: gestureRecognizer.view)
        return abs(velocity.y) > abs(velocity.x)
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
