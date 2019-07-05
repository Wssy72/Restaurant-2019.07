//
//  Order.swift
//  Restaurant 2019.07
//
//  Created by Denis Bystruev on 05/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
