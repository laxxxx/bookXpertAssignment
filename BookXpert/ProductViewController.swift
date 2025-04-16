//
//  ProductViewController.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        viewModel.reloadUI = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchProducts()
    }
}

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(170)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }

        let product = viewModel.product(at: indexPath.row)
        cell.id.text = "id - \(product.id)"
        cell.name.text = "name -\(product.name)"
        cell.data.text = product.data?.map { "\($0.key): \($0.value.description)" }.joined(separator: "\n") ?? "No Data"
        return cell
    }
}
