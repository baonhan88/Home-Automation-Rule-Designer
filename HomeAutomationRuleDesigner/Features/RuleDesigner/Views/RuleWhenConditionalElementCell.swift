//
//  RuleWhenConditionalElementCell.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol RuleWhenConditionalElementCellDelegate {
    func handleTapOnChooseTypeButton(conditionalElement: ConditionalElement)
    func handleTapOnChoosePatternIdListButton(conditionalElement: ConditionalElement)
    func handleTapOnRemoveConditionalElementButton(conditionalElement: ConditionalElement)
    func handleTapOnChooseResultTypeButton(conditionalElement: ConditionalElement)
    func handleTapOnChooseOperatorButton(conditionalElement: ConditionalElement)
    func handleTapOnChooseWindowTypeButton(conditionalElement: ConditionalElement)
    func handleTapOnChooseCalculateTypeButton(conditionalElement: ConditionalElement)
}

class RuleWhenConditionalElementCell: UITableViewCell {

    @IBOutlet weak var chooseTypeButton: UIButton!
    @IBOutlet weak var choosePatternIdListButton: UIButton!
    
    @IBOutlet weak var bindingTextField: UITextField!
    @IBOutlet weak var chooseResultTypeButton: UIButton!
    @IBOutlet weak var chooseOperatorButton: UIButton!
    @IBOutlet weak var resultValueTextField: UITextField!
    
    @IBOutlet weak var chooseWindowTypeButton: UIButton!
    @IBOutlet weak var windowValueTextField: UITextField!
    
    @IBOutlet weak var chooseCalculateTypeButton: UIButton!
    @IBOutlet weak var calculateValueTextField: UITextField!
    
    var currentConditionalElement: ConditionalElement?
    
    var delegate: RuleWhenConditionalElementCellDelegate?
    
    func initView(conditionalElement: ConditionalElement) {
        currentConditionalElement = conditionalElement
        
        if conditionalElement.type != "" {
            chooseTypeButton.setTitle(conditionalElement.type, for: UIControlState.normal)
        } else {
            chooseTypeButton.setTitle("Choose Type", for: UIControlState.normal)
        }
        
        var idListString = ""
        for i in 0 ..< conditionalElement.patternIdList.count {
            let id = conditionalElement.patternIdList[i]
            if i == conditionalElement.patternIdList.count-1 {
                idListString += id
            } else {
                idListString += id + ", "
            }
        }
        
        if idListString != "" {
            choosePatternIdListButton.setTitle(idListString, for: UIControlState.normal)
        } else {
            choosePatternIdListButton.setTitle("Choose Pattern Id List", for: UIControlState.normal)
        }

        
        if conditionalElement.resultType != "" {
            chooseResultTypeButton.setTitle(conditionalElement.resultType, for: UIControlState.normal)
        } else {
            chooseResultTypeButton.setTitle("Choose Result Type", for: UIControlState.normal)
        }
        
        if conditionalElement.resultOperator != "" {
            chooseOperatorButton.setTitle(conditionalElement.resultOperator, for: UIControlState.normal)
        } else {
            chooseOperatorButton.setTitle("Choose Operator", for: UIControlState.normal)
        }
        
        if conditionalElement.windowType != "" {
            chooseWindowTypeButton.setTitle(conditionalElement.windowType, for: UIControlState.normal)
        } else {
            chooseWindowTypeButton.setTitle("Choose Window Type", for: UIControlState.normal)
        }
        
        if conditionalElement.calculateType != "" {
            chooseCalculateTypeButton.setTitle(conditionalElement.calculateType, for: UIControlState.normal)
        } else {
            chooseCalculateTypeButton.setTitle("Choose Calculate Type", for: UIControlState.normal)
        }
        
        bindingTextField.text = conditionalElement.binding
        resultValueTextField.text = conditionalElement.resultValue
        windowValueTextField.text = conditionalElement.windowValue
        calculateValueTextField.text = conditionalElement.calculateValue
        
        if conditionalElement.type == "accumulate" {
            bindingTextField.isHidden = false
            chooseResultTypeButton.isHidden = false
            chooseOperatorButton.isHidden = false
            resultValueTextField.isHidden = false
            
            chooseWindowTypeButton.isHidden = false
            windowValueTextField.isHidden = false
            
            chooseCalculateTypeButton.isHidden = false
            calculateValueTextField.isHidden = false
        } else {
            bindingTextField.isHidden = true
            chooseResultTypeButton.isHidden = true
            chooseOperatorButton.isHidden = true
            resultValueTextField.isHidden = true
            
            chooseWindowTypeButton.isHidden = true
            windowValueTextField.isHidden = true
            
            chooseCalculateTypeButton.isHidden = true
            calculateValueTextField.isHidden = true
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
    
    @IBAction func bindingTextFieldDidChange(_ sender: UITextField) {
        currentConditionalElement?.binding = sender.text!
    }
    
    @IBAction func resultValueTextFieldDidChange(_ sender: UITextField) {
        currentConditionalElement?.resultValue = sender.text!
    }
    
    @IBAction func windowValueTextFieldDidChange(_ sender: UITextField) {
        currentConditionalElement?.windowValue = sender.text!
    }
    
    @IBAction func calculateValueTextFieldDidChange(_ sender: UITextField) {
        currentConditionalElement?.calculateValue = sender.text!
    }
    
    @IBAction func chooseTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseTypeButton(conditionalElement: currentConditionalElement!)
    }
    
    @IBAction func choosePatternIdListButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChoosePatternIdListButton(conditionalElement: currentConditionalElement!)
    }
    
    @IBAction func removeConditionalElementButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnRemoveConditionalElementButton(conditionalElement: currentConditionalElement!)
    }
    
    @IBAction func chooseResultTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseResultTypeButton(conditionalElement: currentConditionalElement!)
    }
    
    @IBAction func chooseOperatorButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseOperatorButton(conditionalElement: currentConditionalElement!)
    }
    
    @IBAction func chooseWindowTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseWindowTypeButton(conditionalElement: currentConditionalElement!)
    }
    
    @IBAction func chooseCalculateTypeButtonClicked(_ sender: UIButton) {
        delegate?.handleTapOnChooseCalculateTypeButton(conditionalElement: currentConditionalElement!)
    }
}
