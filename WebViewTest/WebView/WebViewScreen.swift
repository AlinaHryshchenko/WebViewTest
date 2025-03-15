//
//  WebViewScreen.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import Foundation
import SwiftUI

struct WebViewScreen: View {
    @ObservedObject var viewModel: WebViewModel
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showActionSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isButtonsVisible = true
    
    let url: URL
    
    var body: some View {
        VStack {
            WebView(viewModel: viewModel, url: url)
                .opacity(viewModel.isLoading ? 0 : 1)
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }

            if isButtonsVisible {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.goBack()
                    }) {
                        Image(systemName: "arrow.left")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button(action: {
                        showActionSheet = true
                    }) {
                        Image(systemName: "photo")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.goForward()
                    }) {
                        Image(systemName: "arrow.right")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(.vertical, 20)
                .background(Color.black.edgesIgnoringSafeArea(.bottom)) 
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Choose a photo source"),
                buttons: [
                    .default(Text("Camera"), action: {
                        sourceType = .camera
                        showImagePicker = true
                    }),
                    .default(Text("Gallery"), action: {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    }),
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
            isButtonsVisible = true
        }) {
            ImagePicker(image: $selectedImage, sourceType: sourceType)
                .onAppear {
                    isButtonsVisible = false
                }
        }
        .onAppear {
            viewModel.load(url)
        }
    }
}

