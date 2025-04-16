//
//  ProductTableViewCell.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var data: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
