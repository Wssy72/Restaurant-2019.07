//
//  MenuItemDetailViewController.swift
//  Restaurant 2019.07
//
//  Created by Denis Bystruev on 05/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    // MARK: IB Outlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailTextLabel: UILabel!
    @IBOutlet var addToOrderButton: UIButton!
    
    // MARK: - Properties
    var menuItem: MenuItem!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        addToOrderButton.layer.cornerRadius = 10
    }
    
    // MARK: - UI Methods
    func updateUI() {
        navigationItem.title = menuItem.formattedPrice
        titleLabel.text = menuItem.name
        detailTextLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    // MARK: - IB Actions
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 3, y: 3)
            sender.transform = CGAffineTransform.identity
        }
        MenuController.shared.order.menuItems.append(menuItem)
    }
}
