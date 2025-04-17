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
        tableView.separatorColor = .clear
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
        return 170
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let p = viewModel.product(at: indexPath.row)
        cell.id.text   = "ID   - \(p.id)"
        cell.name.text = "Name - \(p.name)"
        cell.data.text = p.data?
            .map { "\($0.key): \($0.value.description)" }
            .joined(separator: "\n") ?? "No Data"
        
        return cell
    }
    
    // Swipe actions
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }
            // 1) Remove from VM
            let deleted = self.viewModel.products.remove(at: indexPath.row)
            // 2) Animate row deletion
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // 3) Show toast
            
            self.showNotificationBanner(title: "BookXpert", message: "Item has been deleted “\(deleted.name)", icon: UIImage(named: "logo"))
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
