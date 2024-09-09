//
//  WebView.swift
//  Treehouse
//
//  Created by 윤영서 on 8/1/24.
//

import SwiftUI
import WebKit

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    var isLoading: Binding<Bool>
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web Request 요청 완료")
        isLoading.wrappedValue = false
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Web Request 요청 시작")
        isLoading.wrappedValue = true
    }
}

struct WebView: UIViewRepresentable {
    @Binding var url: String
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url), url != uiView.url {
            uiView.load(URLRequest(url: url))
        }
    }
    
    func makeCoordinator() -> WebViewNavigationDelegate {
        WebViewNavigationDelegate(isLoading: $isLoading)
    }
}
