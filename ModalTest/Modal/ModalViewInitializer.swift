//
//  ModalViewInitializer.swift
//  ModalTest
//
//  Created by Kendy Nagao on 15/12/20.
//

import UIKit

class ModalViewInitializer {
    static func makeModal(model: ModalViewModel) -> UIViewController {
        let modalViewController = ModalViewController(model: model)
        return modalViewController
    }
}
