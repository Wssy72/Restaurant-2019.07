//
//  CategoryTableViewController.swift
//  Restaurant 2019.07
//
//  Created by Denis Bystruev on 05/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: Propeties
    let cellManager = CellManager()
    var categories = [String]()

    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuController.shared.fetchCategories { categories in
            guard let categories = categories else { return }
            self.updateUI(with: categories)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "MenuSegue" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let destination = segue.destination as! MenuTableViewController
        destination.category = categories[indexPath.row]
    }
    
    // MARK: - UI Methods
    func updateUI(with categories: [String]) {
        self.categories = categories
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension CategoryTableViewController /*: UITableViewDataSource */ {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        cellManager.configure(cell, with: categories[indexPath.row])
        return cell
    }
}
