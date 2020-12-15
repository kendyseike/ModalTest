//
//  ModalView.swift
//  ModalTest
//
//  Created by Kendy Nagao on 15/12/20.
//

import UIKit

class ModalCustomView: UIView {
    var model: ModalViewModel?
    var parent: UIView?
    
    private lazy var backgroundView: UIView = { return UIView(frame: .zero) }()
    private lazy var modalView: UIView = { return UIView(frame: .zero) }()
    private lazy var labelTest: UILabel = { return UILabel(frame: .zero) }()
    
    convenience init(model: ModalViewModel, parent: UIView) {
        self.init()
        setupViewComponents(model: model, parent: parent)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    private func setupViewComponents(model: ModalViewModel, parent: UIView) {
        
        self.model = model
        self.parent = parent
        
        buildView()
    }
    
    //MARK: view setup methods
    
    private func buildView() {
        setupViewHierarchy()
        configureViews()
    }
    
    private func setupViewHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(modalView)
        modalView.addSubview(labelTest)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        modalView.translatesAutoresizingMaskIntoConstraints = false
        labelTest.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            widthAnchor.constraint(equalToConstant: parent?.frame.size.width ?? 320),
            heightAnchor.constraint(equalToConstant: parent?.frame.size.height ?? 568),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        backgroundView.addConstraints([
            modalView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            modalView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20),
            modalView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            modalView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20)
        ])
        
        modalView.addConstraints([
            labelTest.centerYAnchor.constraint(equalTo: modalView.centerYAnchor),
            labelTest.centerXAnchor.constraint(equalTo: modalView.centerXAnchor)
        ])
    }
    
    private func configureViews() {
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        modalView.backgroundColor = UIColor.white
        labelTest.numberOfLines = 0
        labelTest.text = "teste"
    }
}
