//
//  WebViewCoordinator.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation
import SwiftUI

protocol WebViewCoordinatorProtocol {
    func start(with url: URL)
    func closeWebView()
}

final class WebViewCoordinator: WebViewCoordinatorProtocol {
    private var mainCoordinator: MainCoordinatorProtocol
    
    // MARK: - Initialization
    init(mainCoordinator: MainCoordinatorProtocol) {
        self.mainCoordinator = mainCoordinator
    }
    
    func start(with url: URL) {
        let viewModel = WebViewModel()
        let view = WebViewScreen(viewModel: viewModel, url: url)
        let host = UIHostingController(rootView: view)
        
        mainCoordinator.pushViewController(host)
    }
    
    func closeWebView() {
        mainCoordinator.popViewController()
    }
    
}

