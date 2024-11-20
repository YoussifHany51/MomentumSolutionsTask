//
//  CompetitionsTableViewCell.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 20/11/2024.
//

import UIKit

class CompetitionsTableViewCell: UITableViewCell {

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avaiSeasonLabel: UILabel!
    @IBOutlet weak var currMatchDayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
