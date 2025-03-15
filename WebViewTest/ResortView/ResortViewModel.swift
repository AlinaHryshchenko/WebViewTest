//
//  ResortViewModel.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 15/03/2025.
//

import Foundation
import SwiftUI

protocol ResortViewModelProtocol: ObservableObject  {
    var resort: Resort { get }
}

final class ResortViewModel: ResortViewModelProtocol {
    @Published var resort: Resort
    
    private let coordinator: ResortCoordinatorProtocol
    
    // MARK: - Initialization
    init(coordinator: ResortCoordinatorProtocol, resort: Resort) {
        self.coordinator = coordinator
        self.resort = resort
    }
    
    
}


