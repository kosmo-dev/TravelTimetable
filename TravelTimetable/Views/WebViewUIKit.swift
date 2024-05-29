//
//  WebViewUIKit.swift
//  TravelTimetable
//
//  Created by Vadim on 29.05.2024.
//

import Foundation
import SwiftUI
import WebKit

struct WebView {
    let url: URL
}

extension WebView: UIViewRepresentable {
    public class Coordinator: NSObject, WKNavigationDelegate {
        let url: URL
        
        init(url: URL) {
            self.url = url
        }
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(url: url)
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
