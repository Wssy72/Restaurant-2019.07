//
//  CellManager.swift
//  Restaurant 2019.07
//
//  Created by Denis Bystruev on 09/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class CellManager {
    var delegate: Reloadable?
    
    func configure(_ cell: UITableViewCell, with category: String) {
        cell.textLabel?.text = category.capitalized
    }
    
    func configure(_ cell: UITableViewCell, with menuItem: MenuItem) {
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = menuItem.formattedPrice
        MenuController.shared.fetchImage(url: menuItem.imageURL) { image in
            DispatchQueue.main.async {
                cell.imageView?.image = image
                self.delegate?.reloadData()
            }
        }
    }
}
