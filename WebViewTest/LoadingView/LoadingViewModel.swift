//
//  LoadingViewModel.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation
import Combine

protocol LoadingViewModelProtocol: ObservableObject {
    var progress: Double { get }
    var isLoading: Bool { get }
    var showButtons: Bool { get }
    var isCanada: Bool { get }
    var showAlert: Bool { get set }
    func startWebViewFlow()
    func startDataListFlow()
    func startLoadingAnimation()
    func checkIfUserIsInCanada()
}

final class LoadingViewModel: LoadingViewModelProtocol {
    @Published var progress: Double = 0.0
    @Published var isLoading: Bool = true
    @Published var showButtons: Bool = false
    @Published var isCanada: Bool = false
    @Published var showAlert: Bool = false
    
    private let coordinator: LoadingViewCoordinatorProtocol
    private var timer: Timer?
    
    // MARK: - Initialization
    init(coordinator: LoadingViewCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - Flow Actions
    func startWebViewFlow() {
        if isCanada {
            coordinator.startWebViewFlow()
        } else {
            showAlert = true
        }
    }
    
    func startDataListFlow() {
        coordinator.startDataListFlow()
    }
    
    // MARK: - Loading Animation
    func startLoadingAnimation() {
        let duration = 3.0
        let steps = 100
        let increment = 1.0 / Double(steps)
        let interval = duration / Double(steps)
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
                self.progress = min(self.progress + increment, 1.0)
            
            
            if self.progress >= 1.0 {
                timer.invalidate()
                self.isLoading = false
                self.showButtons = true
                self.checkIfUserIsInCanada()
            }
        }
    }
    
    // MARK: - IP Location Check
    func checkIfUserIsInCanada() {
            let url = URL(string: "https://ipinfo.io/json")!
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching IP location: \(String(describing: error))")
                    return
                }
                
                do {
                    let json = try JSONDecoder().decode(IPInfoResponse.self, from: data)
                    if json.country == "CA" {
                        DispatchQueue.main.async {
                            self?.isCanada = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.isCanada = false
                        }
                    }
                } catch {
                    print("Error parsing IP geolocation data: \(error)")
                }
            }
            
            task.resume()
        }
    
    // MARK: - Deinitialization
    deinit {
        timer?.invalidate()
    }
}
