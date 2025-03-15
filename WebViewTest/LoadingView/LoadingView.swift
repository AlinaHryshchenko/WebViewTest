//
//  LoadingView.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation
import SwiftUI

import SwiftUI

struct LoadingView<ViewModel: LoadingViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    // MARK: - Initialization
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Image("LoadViewImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if viewModel.isLoading {
                    ProgressView(value: viewModel.progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(height: 8)
                        .background(Color.black)
                        .accentColor(.blue)
                        .padding(.horizontal, 40)
                    
                    Text("Loading...")
                        .foregroundColor(.white)
                        .padding(.top, 20)
                } else {
                    if viewModel.showButtons {
                        Button(action: {
                            viewModel.startWebViewFlow()
                        }) {
                            Text("Open Web View")
                                .padding()
                                .background(Color.secondary)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            viewModel.startDataListFlow()
                        }) {
                            Text("Open data list")
                                .padding()
                                .background(Color.secondary)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.startLoadingAnimation()
            }
            
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Access Denied"),
                    message: Text("You must be in Canada to access this content."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    LoadingView(viewModel: LoadingViewModel(
        coordinator: LoadingViewCoordinator(
            mainCoordinator: MainCoordinator(
                rootNavigationController: UINavigationController()
            ))))
}

