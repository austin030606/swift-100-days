//
//  TableViewCell.swift
//  Challenge1
//
//  Created by Austin Chiu on 2023/2/2.
//

import UIKit

class TTableViewCell: UITableViewCell {
    @IBOutlet var Country: UILabel!
    @IBOutlet var flagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
