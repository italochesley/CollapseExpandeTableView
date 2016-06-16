//
//  CustomerTableUiView.swift
//  CustomTableView2
//
//  Created by Italo Chesley on 6/13/16.
//  Copyright © 2016 Italo Chesley. All rights reserved.
//

import UIKit

class CustomerTableUiView: UITableViewCell {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
