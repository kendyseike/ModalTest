//
//  ModalProtocol.swift
//  ModalTest
//
//  Created by Kendy Nagao on 15/12/20.
//

import UIKit

public protocol HasModalView {
    associatedtype ModalView: UIView
}

extension HasModalView where Self: UIViewController {
    public var modalView: ModalView {
        guard let modalView = view as? ModalView else {
            fatalError("o tipo esperado é \(ModalView.self) mas o parâmetro passado foi \(type(of: view))")
        }
        return modalView
    }
}
