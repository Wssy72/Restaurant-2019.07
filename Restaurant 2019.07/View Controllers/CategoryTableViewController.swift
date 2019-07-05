//
//  CategoryTableViewController.swift
//  Restaurant 2019.07
//
//  Created by Denis Bystruev on 05/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    let menuController = MenuController()

    override func viewDidLoad() {
        super.viewDidLoad()
        var order = Order()
        menuController.fetchCategories { categories in
            guard let categories = categories else { return }
            for category in categories {
                self.menuController.fetchMenuItems(forCategory: category, completion: { menuItems in
                    menuItems?.forEach { order.menuItems.append($0) }
                    print("\n", category)
                    print(#line, #function, menuItems ?? "nil")
                    menuItems?.forEach {
                        self.menuController.fetchImage(url: $0.imageURL, completion: { image in
                            print(#line, #function, image ?? "nil")
                        })
                    }
                })
            }
        }
        print(#line, #function, "FINISHED FINISHED FINISHED")
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.menuController.submitOrder(forMenuIDs: order.menuItems.map { $0.id }, completion: { minutes in
                print(#line, #function, "Wait time:", minutes ?? "nil")
            })
        }
    }

}
