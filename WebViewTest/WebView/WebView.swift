//
//  WebView.swift
//  WebViewTest
//
//  Created by Alina Hryshchenko on 14/03/2025.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    let url: URL
    
    // MARK: - Create WKWebView
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        viewModel.webView = webView
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // MARK: - Create Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.viewModel.isLoading = false
            }
        }
        
        // MARK: - Intercept Payment URLs
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                let paymentKeywords = ["payment", "paypal", "stripe", "checkout", "creditcard"]
                let paymentDomains = ["paypal.com", "stripe.com", "braintreegateway.com"]
                
                let containsPaymentKeyword = paymentKeywords.contains { keyword in
                    url.absoluteString.lowercased().contains(keyword)
                }
                
                let isPaymentDomain = paymentDomains.contains { domain in
                    url.host?.contains(domain) == true
                }
                
                if containsPaymentKeyword || isPaymentDomain {
                    print("The payment fee revealed: \(url)")
                    
                    decisionHandler(.cancel)
                    
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
}

