//
//  CellControllerTableViewCell.swift
//  MCU
//
//  Created by mazen moataz on 07/12/2021.
//

import UIKit

class CellControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var charImage: UIImageView!
    
    @IBOutlet var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
