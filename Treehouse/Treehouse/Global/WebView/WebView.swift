//
//  WebView.swift
//  Treehouse
//
//  Created by 윤영서 on 8/1/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let path: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Keychain에서 토큰 가져오기
        guard let accessToken = KeychainHelper.shared.load(for: Config.accessTokenKey) else {
            print("Access token not found")
            return
        }
        
        // URL 생성
        guard let url = URL(string: Config.webFrontURL + path) else {
            print("Invalid URL")
            return
        }
        
        // URLRequest 생성 및 Authorization 헤더 설정
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // WebView에 요청 로드
        uiView.load(request)
    }
}
