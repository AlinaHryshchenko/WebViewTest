//
//  MainCoordinator.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation
import SwiftUI


protocol MainCoordinatorProtocol {
    func setRootController(_ controller: UIViewController)
    func pushViewController(_ controller: UIViewController)
    func startLoadingViewFlow()
    func startWebViewFlow()
    func startDataListFlow()
    func startResortDetailFlow(with resort: Resort)
    func popViewController()
}

final class MainCoordinator: MainCoordinatorProtocol {
    var rootNavigationController: UINavigationController
   
    // MARK: - Initialization
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    // MARK: - Start
    func start() {
        let loadingViewCoordinator = LoadingViewCoordinator(mainCoordinator: self)
        let loadingViewModel = LoadingViewModel(coordinator: loadingViewCoordinator)
        let view = LoadingView(viewModel: loadingViewModel)
        let splashViewController = UIHostingController(rootView: view)
        rootNavigationController.viewControllers = [splashViewController]
    }
    
    func startLoadingViewFlow() {
        let loadingViewCoordinator = LoadingViewCoordinator(mainCoordinator: self)
        loadingViewCoordinator.start()
    }
    
    func startWebViewFlow() {
        let webViewCoordinator = WebViewCoordinator(mainCoordinator: self)
        let url = URL(string: "https://onlywinapp.space/CgnV6V99")!
        webViewCoordinator.start(with: url)
    }
    
    func startDataListFlow() {
        let dataListCoordinator = DataListCoordinator(mainCoordinator: self)
        dataListCoordinator.start()
    }
    
    func startResortDetailFlow(with resort: Resort) {
        let resortCoordinator = ResortCoordinator(mainCoordinator: self)
        resortCoordinator.start(with: resort)
    }
    
    func setRootController(_ controller: UIViewController) {
        rootNavigationController.viewControllers = [controller]
    }
    
    func pushViewController(_ controller: UIViewController) {
        rootNavigationController.pushViewController(controller, animated: true)
    }
    
    func popViewController() {
        rootNavigationController.popToRootViewController(animated: true)
    }
    
}
