//
//  ViewController.swift
//  Project4
//
//  Created by Austin Chiu on 2023/2/6.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var oldView: UIView!
    var progressView: UIProgressView!
    var initWebsite: Int!
    var websites: [String]!
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        view.frame = view.bounds
        webView = WKWebView(frame: CGRect( x: 0, y: 92, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 92), configuration: webConfiguration)
        webView.navigationDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(webView)
        let url = URL(string: "https://" + websites[initWebsite])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openTapped))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView,
                                      action: #selector(webView.reload))
        let goBack = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                     style: .plain,
                                     target: webView,
                                     action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"),
                                     style: .plain,
                                     target: webView,
                                     action: #selector(webView.goForward))
        toolbarItems = [progressButton, spacer, spacer, goBack, spacer, goForward, spacer, refresh]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        navigationController?.interactivePopGestureRecognizer?.isEnabled = !webView.canGoBack
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
            let ac = UIAlertController(title: "You're not allowed to visit an unverified website.", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .default))
            present(ac, animated: true)
        }
        decisionHandler(.cancel)
    }
}

