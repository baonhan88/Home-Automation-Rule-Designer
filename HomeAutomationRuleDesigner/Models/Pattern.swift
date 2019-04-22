//
//  Pattern.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit
import EVReflection

class Pattern: EVObject {
    var id: String = ""
    var binding: String = ""
    var objectType: String = ""
    var expressionConstraintList: [ExpressionConstraint] = []
}
