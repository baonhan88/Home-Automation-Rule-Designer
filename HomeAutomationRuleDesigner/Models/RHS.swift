//
//  RHS.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit
import EVReflection

class RHS: EVObject {
    var type: String = ""
    var binding: String = ""
    var propertyList: [Property] = []
    
    // for insert
    var objectType: String =  ""
}
