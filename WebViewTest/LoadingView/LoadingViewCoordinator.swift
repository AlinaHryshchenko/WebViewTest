//
//  LoadingViewCoordinator.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation
import SwiftUI

protocol LoadingViewCoordinatorProtocol {
    func startWebViewFlow()
    func startDataListFlow()
}

final class LoadingViewCoordinator: LoadingViewCoordinatorProtocol {
    var mainCoordinator: MainCoordinatorProtocol
    
    // MARK: - Initialization
    init(mainCoordinator: MainCoordinatorProtocol) {
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let viewModel = LoadingViewModel(coordinator: self)
        let view = LoadingView(viewModel: viewModel)
        let host = UIHostingController(rootView: view)
        
        mainCoordinator.setRootController(host)
    }
    
    func startWebViewFlow() {
        mainCoordinator.startWebViewFlow()
    }
    
    func startDataListFlow() {
        mainCoordinator.startDataListFlow()
    }
}

