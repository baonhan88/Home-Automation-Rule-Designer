//
//  RuleListCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 25/01/2018.
//  Copyright © 2018 SLab. All rights reserved.
//

import UIKit

class RuleListCell: UITableViewCell {

    @IBOutlet weak var ruleNameLabel: UILabel!
    
    func initView(ruleName: String) {
        ruleNameLabel.text = ruleName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
