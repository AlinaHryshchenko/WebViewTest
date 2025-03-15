//
//  ResortCoordinator.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 15/03/2025.
//

import Foundation
import SwiftUI

protocol ResortCoordinatorProtocol {
    func start(with resort: Resort)
}

final class ResortCoordinator: ResortCoordinatorProtocol {
    var mainCoordinator: MainCoordinatorProtocol
    
    // MARK: - Initialization
    init(mainCoordinator: MainCoordinatorProtocol) {
        self.mainCoordinator = mainCoordinator
    }
    
    func start(with resort: Resort) {
        let viewModel = ResortViewModel(coordinator: self, resort: resort)
        let view = ResortDetailView(viewModel: viewModel)
        let host = UIHostingController(rootView: view)        
        mainCoordinator.pushViewController(host)
    }
    
}

