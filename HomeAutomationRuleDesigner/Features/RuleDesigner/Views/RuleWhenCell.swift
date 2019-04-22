//
//  RuleWhenCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleWhenCellDelegate {
    func handleTapOnAddPatternButton()
    func handleTapOnAddConditionalElementButton()
}

class RuleWhenCell: UITableViewCell {

    @IBOutlet weak var addPatternButton: UIButton!
    @IBOutlet weak var addConditionalElementButton: UIButton!
    
    var delegate: RuleWhenCellDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addPatternButtonClicked(_ sender: Any) {
        delegate?.handleTapOnAddPatternButton()
    }
    
    @IBAction func addConditionalElementButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnAddConditionalElementButton()
    }
    
}
