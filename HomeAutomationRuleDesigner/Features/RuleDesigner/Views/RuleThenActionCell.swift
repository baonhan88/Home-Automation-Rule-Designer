//
//  RuleThenActionCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleThenActionCellDelegate {
    func handleTapOnChooseTypeButton(rhs: RHS)
    func handleTapOnAddPropertyButton(rhs: RHS)
    func handleTapOnRemoveActionButton(rhs: RHS)
    func handleTapOnChooseObjectTypeButton(rhs: RHS)
}

class RuleThenActionCell: UITableViewCell {

    @IBOutlet weak var chooseTypeButton: UIButton!
    @IBOutlet weak var addPropertyButton: UIButton!
    @IBOutlet weak var chooseObjectTypeButton: UIButton!
    
    @IBOutlet weak var bindingTextField: UITextField!
    
    var delegate: RuleThenActionCellDelegate?
    
    var currentRHS: RHS?
    
    func initView(rhs: RHS) {
        self.currentRHS = rhs
        
        chooseObjectTypeButton.isHidden = true
        bindingTextField.isHidden = false
        
        if rhs.type != "" {
            if rhs.type == kActionTypeModify || rhs.type == kActionTypeInsert {
                addPropertyButton.isHidden = false
            } else {
                addPropertyButton.isHidden = true
            }
            if rhs.type == kActionTypeInsert {
                bindingTextField.isHidden = true
                chooseObjectTypeButton.isHidden = false
                
                if rhs.objectType != "" {
                    chooseObjectTypeButton.setTitle(rhs.objectType, for: UIControlState.normal)
                } else {
                    chooseObjectTypeButton.setTitle("Choose Object Type", for: UIControlState.normal)
                }
            }
            chooseTypeButton.setTitle(rhs.type, for: UIControlState.normal)
        } else {
            chooseTypeButton.setTitle("Choose Action Type", for: UIControlState.normal)
        }
        
        bindingTextField.text = rhs.binding
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func chooseTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseTypeButton(rhs: currentRHS!)
    }
    
    @IBAction func addPropertyButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnAddPropertyButton(rhs: currentRHS!)
    }
    
    @IBAction func removeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnRemoveActionButton(rhs: currentRHS!)
    }
    
    @IBAction func chooseObjectTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseObjectTypeButton(rhs: currentRHS!)
    }
    
    @IBAction func bindingTextFieldDidChange(_ sender: UITextField) {
        currentRHS?.binding = sender.text!
    }
}
