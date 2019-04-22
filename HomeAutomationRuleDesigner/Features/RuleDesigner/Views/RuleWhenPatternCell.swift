//
//  RuleWhenPatternCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleWhenPatternCellDelegate {
    func handleTapOnChooseObjectTypeButton(pattern: Pattern)
    func handleTapOnAddConstraintButton(pattern: Pattern)
    func handleTapOnRemoveConstraintButton(pattern: Pattern)
}

class RuleWhenPatternCell: UITableViewCell {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var bindingTextField: UITextField!
    
    @IBOutlet weak var chooseObjectTypeButton: UIButton!
    @IBOutlet weak var addConstraintButton: UIButton!
    
    var pattern: Pattern?
    
    var delegate: RuleWhenPatternCellDelegate?
    
    func initView(pattern: Pattern) {
        self.pattern = pattern
        
        idTextField.text = pattern.id
        bindingTextField.text = pattern.binding
        if pattern.objectType != "" {
            chooseObjectTypeButton.setTitle(pattern.objectType, for: UIControlState.normal)
        } else {
            chooseObjectTypeButton.setTitle("Choose Object Type", for: UIControlState.normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func chooseObjectTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseObjectTypeButton(pattern: pattern!)
    }
    
    @IBAction func addConstraintButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnAddConstraintButton(pattern: pattern!)
    }
    
    @IBAction func removeConstraintButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnRemoveConstraintButton(pattern: pattern!)
    }
    
    @IBAction func idTextFieldDidChange(_ sender: UITextField) {
        pattern?.id = sender.text!
    }
    
    @IBAction func bindingTextFieldDidChange(_ sender: UITextField) {
        pattern?.binding = sender.text!
    }
}
