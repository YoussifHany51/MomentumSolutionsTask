//
//  CompetitionsDetailsTableViewCell.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 20/11/2024.
//

import UIKit

class CompetitionsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var homeShortLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var awayShortLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
