//
//  ModalView.swift
//  ModalTest
//
//  Created by Kendy Nagao on 15/12/20.
//

import UIKit
import WebKit

class ModalCustomView: UIView, WKScriptMessageHandler {
    var model: ModalViewModel?
    var parent: UIViewController?
    
    private lazy var backgroundView: UIView = { return UIView(frame: .zero) }()
    private lazy var modalView: UIView = { return UIView(frame: .zero) }()
    private var webView: WKWebView?
    
    convenience init(model: ModalViewModel, parent: UIViewController) {
        self.init()
        setupViewComponents(model: model, parent: parent)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    private func setupViewComponents(model: ModalViewModel, parent: UIViewController) {
        
        self.model = model
        self.parent = parent
        
        setWebView()
        buildView()
    }
    
    //MARK: set webview and return it
    private func setWebView() {
        
        
        let config = WKWebViewConfiguration()
        config.userContentController = setActionsForButtons()
        webView = WKWebView(frame: .zero, configuration: config)
    }
    
    private func setActionsForButtons() -> WKUserContentController {
        let source = "  document.getElementById('close-submit-button').addEventListener('click', function() { window.webkit.messageHandlers.iosListener.postMessage('closeModal'); });                document.getElementsByClassName('call-to-action')[0].addEventListener('click', function() { window.webkit.messageHandlers.iosListener.postMessage(document.getElementsByClassName('call-to-action')[0].getAttribute('data-url-ios')); });"
        
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        let userController = WKUserContentController()
        userController.addUserScript(script)
        userController.add(self, name: "iosListener")
        
        return userController
    }
    
    //MARK: view setup methods
    
    private func buildView() {
        setupViewHierarchy()
        configureViews()
        configureWebView()
    }
    
    private func setupViewHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(modalView)
        
        guard let webView = webView else { return }
        modalView.addSubview(webView)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        modalView.translatesAutoresizingMaskIntoConstraints = false
        webView?.translatesAutoresizingMaskIntoConstraints = false
        
        let parentView = parent?.view
        
        addConstraints([
            widthAnchor.constraint(equalToConstant: parentView?.frame.size.width ?? 320),
            heightAnchor.constraint(equalToConstant: parentView?.frame.size.height ?? 568),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        backgroundView.addConstraints([
            modalView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            modalView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20),
            modalView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            modalView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20)
        ])
        
        guard let webView = webView else { return }
        modalView.addConstraints([
            webView.topAnchor.constraint(equalTo: modalView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: modalView.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: modalView.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: modalView.leadingAnchor)
        ])
    }
    
    private func configureWebView() {
        let url = Bundle.main.url(forResource: "templateMobileInAppJS", withExtension: "html")
        let request = NSURLRequest(url: url!)
        webView?.load(request as URLRequest)
    }
    
    private func configureViews() {
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        modalView.backgroundColor = UIColor.white
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let message = message.body as? String
        if message == "closeModal" {
            parent?.dismiss(animated: true, completion: nil)
        } else {
            print("URL = \(message)")
        }
    }
}
