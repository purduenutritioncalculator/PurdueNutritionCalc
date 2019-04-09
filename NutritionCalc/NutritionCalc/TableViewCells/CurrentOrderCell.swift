//
//  CurrentOrderCell.swift
//  NutritionCalc
//
//  Created by Anderson David on 4/9/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class CurrentOrderCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var nutritionDesc: UILabel!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var subtractQuantityButton: UIButton!
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var servingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
