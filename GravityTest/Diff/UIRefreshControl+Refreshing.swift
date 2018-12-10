//
//  UIRefreshControl+Refreshing.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    func programaticallyBeginRefreshing(in tableView: UITableView) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
}
