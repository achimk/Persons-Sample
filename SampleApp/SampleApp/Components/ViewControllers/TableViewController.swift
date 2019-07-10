//
//  TableViewController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: ViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    private let keyboardController = ScrollViewKeyboardController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareTableView()
    }
    
    private func prepareView() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
        }
    }
    
    private func prepareTableView() {
        keyboardController.scrollView = tableView
        Theme.TableView.apply(to: tableView)

        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(tableView)
    }
}
