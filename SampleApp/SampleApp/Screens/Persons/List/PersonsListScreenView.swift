//
//  PersonsListScreenView.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import AdaptersCore
import PersonsFeature

final class PersonsListScreenView: TableViewController {
    
    private let dataSource = PersonsListDataSourceAdapter()
    
    var module: PersonsListModule!
    
    weak var delegate: PersonsListScreenViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareNavigationItems()
        module.attach(ui: self, wireframe: self)
    }
    
    private func prepareView() {
        title = NSLocalizedString("Persons", comment: "")
        dataSource.setup(with: tableView)
    }
    
    private func prepareNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPerson))
    }
    
    @objc private func addPerson() {
        delegate?.personsListScreenDidSelectAddPerson(self)
    }
}

extension PersonsListScreenView: PersonsListUserInterface {
    
    func present(viewData: PersonItemsViewData) {
        dataSource.update(with: viewData)
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

extension PersonsListScreenView: PersonsListWireframe {
    
    func selectedPerson(with context: PersonContext) {
        delegate?.personsListScreen(self, didSelectPerson: context)
    }
}
