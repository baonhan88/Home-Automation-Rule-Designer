//
//  DataManager.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 25/01/2018.
//  Copyright © 2018 SLab. All rights reserved.
//

import Foundation

class DataManager: NSObject {
        
    public static func saveRule(rule: Rule) {
        let defaults = UserDefaults.standard
        var ruleList = defaults.array(forKey: kRuleListKey) as? [String] ?? [String]()
        if ruleList.count == 0 {
            // rule list is empty, just insert new rule
            ruleList.append(rule.toJsonString())
        } else {
            var index = 0
            // if rule is exist -> update
            for ruleString in ruleList {
                // convert rule string to object
                let ruleObject = Rule(json: ruleString)
                if ruleObject.name == rule.name {
                    // update rule
                    ruleList.remove(at: index)
                    break
                }
                
                index += 1
            }
            
            // else just insert
            ruleList.append(rule.toJsonString())
        }
        
        // save latest ruleList
        defaults.set(ruleList, forKey: kRuleListKey)
    }
    
    public static func updateRuleList(ruleList: [Rule]) {
        var ruleStringList: [String] = []
        
        for rule in ruleList {
            ruleStringList.append(rule.toJsonString())
        }
        
        // save new rule list to UserDefault
        let defaults = UserDefaults.standard
        defaults.set(ruleStringList, forKey: kRuleListKey)
    }
    
    public static func getRuleList() -> [String]? {
        let defaults = UserDefaults.standard
        return defaults.stringArray(forKey: kRuleListKey)
    }
}
