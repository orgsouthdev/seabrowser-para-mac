import SwiftUI
import WebKit

@main
struct SimpleBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var webViewManager = WebViewManager()

    var body: some View {
        VStack {
            // Botones
            HStack {
                Button("Back") {
                    webViewManager.webView?.goBack()
                }
                .padding()

                Button("Reload") {
                    webViewManager.webView?.reload()
                }
                .padding()

                Button("Forward") {
                    webViewManager.webView?.goForward()
                }
                .padding()
            }
            // URL Text Field y Botón Go
            HStack {
                TextField("Enter URL", text: $webViewManager.urlString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Go") {
                    webViewManager.loadURL()
                }
                .padding()
            }

            // WebView
            WebView(webView: webViewManager.webView)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .padding()
    }
}

class WebViewManager: ObservableObject {
    @Published var urlString = "https://www.google.com"
    var webView: WKWebView?

    init() {
        self.webView = WKWebView()
        self.loadURL()
    }

    func loadURL() {
        guard let url = URL(string: urlString) else { return }
        webView?.load(URLRequest(url: url))
    }
}

struct WebView: NSViewRepresentable {
    let webView: WKWebView?

    func makeNSView(context: Context) -> WKWebView {
        return webView ?? WKWebView()
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // No necesitamos actualizar la vista
    }
}
