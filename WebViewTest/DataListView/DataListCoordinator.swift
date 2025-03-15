//
//  DataListCoordinator.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//


import Foundation
import SwiftUI

protocol DataListCoordinatorProtocol {
    func showResortDetail(_ resort: Resort)
}

final class DataListCoordinator: DataListCoordinatorProtocol {
    var mainCoordinator: MainCoordinatorProtocol
    
    // MARK: - Initialization
    init(mainCoordinator: MainCoordinatorProtocol) {
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let viewModel = DataListViewModel(coordinator: self)
        let view = DataListView(viewModel: viewModel)
        let host = UIHostingController(rootView: view)
        mainCoordinator.pushViewController(host)
    }
    
    func showResortDetail(_ resort: Resort) {
        mainCoordinator.startResortDetailFlow(with: resort)
    }
}

