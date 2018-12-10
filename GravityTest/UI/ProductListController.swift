//
//  ViewController.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import UIKit

class ProductListController: UITableViewController {

    let viewModel = ProductsListViewModel(
        networkProductSource: API(networkClient: SimpleNetworkClient()
    ))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Product List".localized
        
        setUpTableView()
        bindToViewModel()
        update()
    }
    
    func setUpTableView () {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(update), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.black
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func bindToViewModel() {
        
        viewModel.errorOccured.bind { [unowned self] in
            if !$0 { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.show(error: self.viewModel.errorText)
            })
        }
        
        viewModel.productModels.bindAndFire { [unowned self] _ in
            self.tableView.reloadData()
        }
        
        viewModel.isLoading.bindAndFire { [unowned self] in
            if ($0) {
                if (self.refreshControl?.isRefreshing != true) {
                    self.refreshControl?.programaticallyBeginRefreshing(in: self.tableView)
                }
            } else {
                if (self.refreshControl?.isRefreshing != false) { self.refreshControl?.endRefreshing() }
            }
        }
    }
    
    @objc func update() {
        viewModel.fetchProducts()
    }
    
    func show(error : String?) {
        var msg = "Unknown error".localized
        if let e = error, e.count > 0 {
            msg = e
        }
        let alert = UIAlertController(title: "Error".localized, message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func openItem(at indexPath : IndexPath) {
        let vm = viewModel.productViewModel(at: indexPath)
        let mapController = ProductOnMapController()
        mapController.productViewModel = vm
        self.navigationController?.pushViewController(mapController, animated: true)
    }
    
}

/*:
 UITableViewDelegate and DataSource
 */
extension ProductListController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.openItem(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = viewModel.productViewModel(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.configure(with: vm)
        
        return cell
    }
}
