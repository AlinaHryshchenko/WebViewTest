//
//  DataListViewModel.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation

protocol DataListViewModelProtocol: ObservableObject  {
    var resorts: [Resort] { get }
    func showResortDetail(_ resort: Resort)
}

final class DataListViewModel: DataListViewModelProtocol {
    private let coordinator: DataListCoordinatorProtocol
    let resorts: [Resort]
    
    // MARK: - Initialization
    init(coordinator: DataListCoordinatorProtocol) {
        self.coordinator = coordinator
        self.resorts = Bundle.main.decode("resorts.json")
    }
    
   func showResortDetail(_ resort: Resort) {
    coordinator.showResortDetail(resort) 
}
    
    
}

