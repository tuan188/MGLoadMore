//
//  ProductCell.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

final class ProductCell: UITableViewCell, NibReusable {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(_ viewModel: ProductViewModel?) {
        nameLabel.text = viewModel?.name
        priceLabel.text = viewModel?.price
    }
}
