//
//  Scene.swift
//  myNews
//
//  Created by kennyS on 12/16/19.
//  Copyright © 2019 kennyS. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case splash
    case tabbar
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .splash:
            let viewModel = SplashViewModel()
            let splashController = SplashController.instantiate(withViewModel: viewModel)
            return .root(splashController)
        case .tabbar:
            let rootTabbarController = RootTabbarController.instantiate()
            
            let homeViewModel = HomeViewModel()
            let homeViewController = HomeViewController.instantiate(withViewModel: homeViewModel)
            let homeNavController = UINavigationController(rootViewController: homeViewController)
            let homeTabbarItem = RAMAnimatedTabBarItem(
                title: nil,
                image: UIImage(named: "home - default_Normal"),
                selectedImage: UIImage(named: "home - active_Normal")?.withRenderingMode(.alwaysTemplate).withTintColor(.white))
            homeTabbarItem.animation = RAMBounceAnimation()
            homeNavController.tabBarItem = homeTabbarItem
            
            let categoryViewModel = CategoryViewModel()
            let categoryController = CategoryViewController.instantiate(withViewModel: categoryViewModel)
            let categoryNavController = UINavigationController(rootViewController: categoryController)
            let categoryTabbarItem = RAMAnimatedTabBarItem(
                title: nil,
                image: UIImage(named: "market - default_Normal"),
                selectedImage: UIImage(named: "markets - active_Normal")?.withRenderingMode(.alwaysTemplate).withTintColor(.white))
            categoryTabbarItem.animation = RAMBounceAnimation()
            categoryNavController.tabBarItem = categoryTabbarItem
            
            let searchViewModel = SearchViewModel()
            let searchViewController = SearchViewController.instantiate(withViewModel: searchViewModel)
            let searchNavController = UINavigationController(rootViewController: searchViewController)
            let searchTabbarItem = RAMAnimatedTabBarItem(
                title: nil,
                image: UIImage(named: "searchDefault_Normal"),
                selectedImage: UIImage(named: "searchActive_Normal")?.withRenderingMode(.alwaysTemplate).withTintColor(.white))
            searchTabbarItem.animation = RAMBounceAnimation()
            searchNavController.tabBarItem = searchTabbarItem
            
            let myPageViewModel = MyPageViewModel()
            let myPageController = MyPageController.instantiate(withViewModel: myPageViewModel)
            let myPageNavController = UINavigationController(rootViewController: myPageController)
            let myPageTabbarItem = RAMAnimatedTabBarItem(
                title: nil,
                image: UIImage(named: "menu - default_Normal"),
                selectedImage: UIImage(named: "menu - active_Normal")?.withRenderingMode(.alwaysTemplate).withTintColor(.white))
            myPageTabbarItem.animation = RAMBounceAnimation()
            myPageNavController.tabBarItem = myPageTabbarItem
            
            rootTabbarController.setViewControllers([homeNavController, categoryNavController, searchNavController, myPageNavController], animated: true)
            return .tabBar(rootTabbarController)
        }
    }
}
