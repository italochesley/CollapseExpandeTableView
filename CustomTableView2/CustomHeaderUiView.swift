//
//  CustomHeaderUiView.swift
//  CustomTableView2
//
//  Created by Italo Chesley on 6/13/16.
//  Copyright © 2016 Italo Chesley. All rights reserved.
//

import UIKit

class CustomHeaderUiView: UITableViewHeaderFooterView {

    
    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
