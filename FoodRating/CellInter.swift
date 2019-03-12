//
//  CellInter.swift
//  FoodRating
//
//  Created by Callum Jones on 22/02/2018.
//  Copyright © 2018 Callum Jones. All rights reserved.
//

import UIKit



// Class Controls the image that will be inserted into the table cell.

class CellInter: UITableViewCell {

    @IBOutlet weak var ImageRating: UIImageView!
    @IBOutlet weak var BusinessLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
