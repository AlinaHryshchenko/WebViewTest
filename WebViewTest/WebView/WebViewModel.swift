//
//  WebViewModel.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//
import Combine
import Foundation
import WebKit

protocol WebViewModelProtocol: ObservableObject  {
    var isLoading: Bool { get }
    func goBack()
    func goForward()
    func closeWebView()
    func load(_ url: URL) 
}

class WebViewModel: NSObject, ObservableObject {
    @Published var isLoading: Bool = true
    @Published var webView: WKWebView = WKWebView()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    override init() {
        super.init()
        self.setupWebView()
    }
    
    // MARK: - Setup WebView
    private func setupWebView() {
        webView.navigationDelegate = self
    }
    
    // MARK: - WebView Navigation Methods
    func load(_ url: URL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    
    func goBack() {
        webView.goBack()
    }
    
    func goForward() {
        webView.goForward()
    }
}

// MARK: - WKNavigationDelegate
extension WebViewModel: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.isLoading = true
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
