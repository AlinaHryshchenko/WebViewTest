//
//  DataListView.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation
import SwiftUI

struct DataListView<ViewModel: DataListViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    // MARK: - Initialization
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.resorts) { resort in
            Button(action: {
                viewModel.showResortDetail(resort)
            }) {
                HStack {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            .rect(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Resorts")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Resorts")
                    .font(.system(size: 32, weight: .bold))
            }
        }
    }
}

#Preview {
    DataListView(viewModel: DataListViewModel(
        coordinator: DataListCoordinator(
            mainCoordinator: MainCoordinator(
                rootNavigationController: UINavigationController()))))
}




