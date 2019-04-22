//
//  RuleThenCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleThenCellDelegate {
    func handleTapOnActionButton()
}

class RuleThenCell: UITableViewCell {

    @IBOutlet weak var addActionButton: UIButton!
    
    var delegate: RuleThenCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addActionButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnActionButton()
    }
}
