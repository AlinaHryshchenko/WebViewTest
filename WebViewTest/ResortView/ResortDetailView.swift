//
//  ResortDetailView.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 15/03/2025.
//

import Foundation
import SwiftUI

struct ResortDetailView: View {
    @ObservedObject private var viewModel: ResortViewModel
    
    // MARK: - Initialization
    init(viewModel: ResortViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.resort.name)
                .font(.largeTitle)
            Text(viewModel.resort.country)
                .font(.title2)
            Text(viewModel.resort.description)
                .font(.body)
            Text("Runs: \(viewModel.resort.runs)")
                .font(.body)
            Text("Price: $\(viewModel.resort.price)")
                .font(.body)
            Text("Elevation: \(viewModel.resort.elevation)m")
                .font(.body)
            Text("Snow Depth: \(viewModel.resort.snowDepth)cm")
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.resort.name)
    }
}
