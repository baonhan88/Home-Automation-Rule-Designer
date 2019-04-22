//
//  RuleThenActionPropertyCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleThenActionPropertyCellDelegate {
    func handleTapOnChooseTypeButton(property: Property)
    func handleTapOnRemovePropertyButton(property: Property)
}

class RuleThenActionPropertyCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var chooseTypeButton: UIButton!
    
    var currentProperty: Property?
    
    var delegate: RuleThenActionPropertyCellDelegate?
    
    func initView(property: Property) {
        self.currentProperty = property
        
        nameTextField.text = property.name
        valueTextField.text = property.value
        if property.type != "" {
            chooseTypeButton.setTitle(property.type, for: UIControlState.normal)
        } else {
            chooseTypeButton.setTitle("Choose Type", for: UIControlState.normal)
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
    
    @IBAction func chooseTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseTypeButton(property: currentProperty!)
    }
    
    @IBAction func removePropertyButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnRemovePropertyButton(property: currentProperty!)
    }
    
    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        currentProperty?.name = sender.text!
    }
    
    @IBAction func valueTextFieldDidChange(_ sender: UITextField) {
        currentProperty?.value = sender.text!
    }
}
