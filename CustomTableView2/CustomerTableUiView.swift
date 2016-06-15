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
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
//        let color = self.backgroundColor
        super.setSelected(selected, animated: animated)
        
//        self.backgroundColor = color
        // Configure the view for the selected state
    }


}
