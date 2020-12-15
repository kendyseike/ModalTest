//
//  ViewController.swift
//  ModalTest
//
//  Created by Kendy Nagao on 15/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //function to call modalView
    func showModal(model: ModalViewModel) {
        let modalViewController = ModalViewInitializer.makeModal(model: model)
        modalViewController.modalTransitionStyle = .crossDissolve
        modalViewController.modalPresentationStyle = .overFullScreen
        present(modalViewController, animated: true)
    }
    
    @IBAction func openModal(_ sender: Any) {
        showModal(model: ModalViewModel(templateId: "123", unitId: "456"))
    }
    
}

