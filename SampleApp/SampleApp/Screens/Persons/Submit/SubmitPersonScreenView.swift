//
//  SubmitPersonScreenView.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import AdaptersCore
import PersonsFeature

final class SubmitPersonScreenView: ViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    
    private let keyboardController = ScrollViewKeyboardController()
    private let components = SubmitPersonScreenViewComponents()
    
    var module: PersonFormModule!
    
    weak var delegate: SubmitPersonScreenViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareStackView()
        module.attach(ui: self, wireframe: self)
    }
    
    private func prepareView() {
        keyboardController.scrollView = scrollView
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
        }
    }
    
    private func prepareStackView() {
        
        stackView.addArrangedSubview(components.name)
        
        stackView.addArrangedSubview(components.surname)
        
        stackView.addArrangedSubview(components.email)
        
        stackView.addArrangedSubview(components.age)
        
        stackView.addArrangedSubview(components.website)
        
        stackView.addWhiteSpace(width: 20)
        
        stackView.addArrangedSubview(components.submit)
    }
}

extension SubmitPersonScreenView: PersonFormUserInterface {
    
    func present(viewData: PersonFormViewData) {
        components.update(with: viewData)
    }
    
    func present(error viewData: ErrorViewData) {
        AlertController(viewData).show()
    }
    
    func presentProgress() {
        ProgressHUD.show(on: view)
    }
    
    func dismissProgress() {
        ProgressHUD.hide(from: view)
    }
}

extension SubmitPersonScreenView: PersonFormWireframe {
    
    func submitedPerson(with context: PersonContext) {
        delegate?.submitPersonScreen(self, didSubmit: context)
    }
}
