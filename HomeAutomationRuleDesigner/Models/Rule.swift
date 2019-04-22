//
//  Rule.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit
import EVReflection

class Rule: EVObject {
    var target: String = kTargetRule
    var commandType: String = kCommandTypeInsert
    var name: String = ""
    var lhs:  LHS = LHS()
    var rhs: [RHS] = []
}
