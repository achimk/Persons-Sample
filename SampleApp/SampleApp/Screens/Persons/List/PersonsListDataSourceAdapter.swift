//
//  PersonsListDataSourceAdapter.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import PersonsFeature

final class PersonsListDataSourceAdapter: NSObject {
    
    private var items: PersonItemsViewData = []
    private var reloadData: () -> () = { }
    
    func setup(with tableView: UITableView) {
        tableView.register(cellType: SubtitleTableViewCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        reloadData = { tableView.reloadData() }
    }
    
    func update(with viewData: PersonItemsViewData) {
        self.items = viewData
        reloadData()
    }
}

extension PersonsListDataSourceAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        item(at: indexPath).handler?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

extension PersonsListDataSourceAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SubtitleTableViewCell.self)
        let item = self.item(at: indexPath)
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.description
        return cell
    }
}

extension PersonsListDataSourceAdapter {
    
    func item(at indexPath: IndexPath) -> PersonItemViewData {
        return items[indexPath.row]
    }
}
