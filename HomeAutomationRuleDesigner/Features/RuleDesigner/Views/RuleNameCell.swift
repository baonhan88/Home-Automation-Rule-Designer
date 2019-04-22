//
//  RuleNameCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleNameCellDelegate {
    func handleUpdateRuleName(text: String)
}

class RuleNameCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UITextField!
    
    var delegate: RuleNameCellDelegate?
    
    func initView(ruleName: String) {
        nameLabel.text = ruleName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        delegate?.handleUpdateRuleName(text: sender.text!)

    }
    
    
}
