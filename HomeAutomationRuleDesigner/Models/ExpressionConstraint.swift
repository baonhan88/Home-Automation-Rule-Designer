//
//  ExpressionConstraint.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit
import EVReflection

class ExpressionConstraint: EVObject {
    var binding: String = ""
    var propertyName: String = ""
    var propertyValue: String = ""
    var propertyType: String = ""
    var `operator`: String = ""
}
