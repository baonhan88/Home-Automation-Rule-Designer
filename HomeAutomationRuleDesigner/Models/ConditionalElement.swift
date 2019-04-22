//
//  ConditionalElement.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit
import EVReflection

class ConditionalElement: EVObject {
    var type: String = ""
    var patternIdList: [String] = []
    
    // using for exist and forall, but have not implemented yet
    var conditionalElementList: [ConditionalElement] = []
    
    /*** BEGIN - using for accumulate ***/
    var binding: String = "";
    var resultType: String = "";
    var resultOperator: String = "";
    var resultValue: String = "";
    
    var windowType: String = "";
    var windowValue: String = "";
    
    var calculateType: String = "";
    var calculateValue: String = "";
    /*** END - using for accumulate ***/

}
