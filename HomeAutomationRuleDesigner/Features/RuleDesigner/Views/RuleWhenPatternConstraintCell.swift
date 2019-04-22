//
//  RuleWhenPatternConstraintCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleWhenPatternConstraintCellDelegate {
    func handleTapOnChoosePropertyButton(expressionConstraint: ExpressionConstraint, currentObjectType: String)
    func handleTapOnChooseOperatorButton(expressionConstraint: ExpressionConstraint)
    func handleTapOnChoosePropertyValueTypeButton(expressionConstraint: ExpressionConstraint)
    func handleTapOnRemoveConstraintButton(expressionConstraint: ExpressionConstraint)
}

class RuleWhenPatternConstraintCell: UITableViewCell {

    @IBOutlet weak var bindingTextField: UITextField!
    @IBOutlet weak var propertyValueTextField: UITextField!
    
    @IBOutlet weak var choosePropertyButton: UIButton!
    @IBOutlet weak var chooseOperatorButton: UIButton!
    
    var expressionConstraint: ExpressionConstraint?
    var currentObjectType: String?
    
    var delegate: RuleWhenPatternConstraintCellDelegate?
    
    func initView(expressionConstraint: ExpressionConstraint, objectType: String) {
        self.expressionConstraint = expressionConstraint
        self.currentObjectType = objectType
        
   
        if expressionConstraint.propertyName != "" {
            choosePropertyButton.setTitle(expressionConstraint.propertyName, for: UIControlState.normal)
        } else {
            choosePropertyButton.setTitle("Choose Property", for: UIControlState.normal)
        }
        if expressionConstraint.operator != "" {
            chooseOperatorButton.setTitle(expressionConstraint.operator, for: UIControlState.normal)
        } else {
            chooseOperatorButton.setTitle("Choose Operator", for: UIControlState.normal)
        }
        bindingTextField.text = expressionConstraint.binding
        propertyValueTextField.text = expressionConstraint.propertyValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func choosePropertyButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChoosePropertyButton(expressionConstraint: expressionConstraint!, currentObjectType: currentObjectType!)
    }
    
    @IBAction func chooseOperatorButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseOperatorButton(expressionConstraint: expressionConstraint!)
    }
    
    @IBAction func removeConstraintButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnRemoveConstraintButton(expressionConstraint: expressionConstraint!)
    }
    
    @IBAction func bindingTextFieldDidChange(_ sender: UITextField) {
        self.expressionConstraint?.binding = sender.text!
    }
    
    @IBAction func propertyValueTextFieldDidChange(_ sender: UITextField) {
        self.expressionConstraint?.propertyValue = sender.text!
    }
}
