//
//  ModalViewController.swift
//  ModalTest
//
//  Created by Kendy Nagao on 15/12/20.
//

import UIKit

final class ModalViewController: UIViewController, HasModalView {
    typealias ModalView = ModalCustomView
    
    var model: ModalViewModel?
    
    convenience init(model: ModalViewModel) {
        self.init()
        
        self.model = model
    }
    
    override func loadView() {
        super.loadView()
        
        guard let model = model else { return }
        
        let modalCustomView = ModalView(model: model, parent: self.view)
        
        self.view = modalCustomView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}
