//
//  LoadingTableViewCell.swift
//  SQLiteTest
//
//  Created by Naw Su Su Nyein on 17/12/2023.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var activitorIndicator : UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
