//
//  RuleDesignerViewController.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 28/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit
import SVProgressHUD
import CocoaAsyncSocket
import SwiftSocket

class RuleDesignerViewController: UITableViewController {
    
    var rule: Rule = Rule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register all cells
        self.tableView.register(UINib(nibName: "RuleNameCell", bundle: nil), forCellReuseIdentifier: "RuleNameCell")
        self.tableView.register(UINib(nibName: "RuleWhenCell", bundle: nil), forCellReuseIdentifier: "RuleWhenCell")
        self.tableView.register(UINib(nibName: "RuleWhenPatternCell", bundle: nil), forCellReuseIdentifier: "RuleWhenPatternCell")
        self.tableView.register(UINib(nibName: "RuleWhenPatternConstraintCell", bundle: nil), forCellReuseIdentifier: "RuleWhenPatternConstraintCell")
        self.tableView.register(UINib(nibName: "RuleWhenConditionalElementCell", bundle: nil), forCellReuseIdentifier: "RuleWhenConditionalElementCell")
        self.tableView.register(UINib(nibName: "RuleThenCell", bundle: nil), forCellReuseIdentifier: "RuleThenCell")
        self.tableView.register(UINib(nibName: "RuleThenActionCell", bundle: nil), forCellReuseIdentifier: "RuleThenActionCell")
        self.tableView.register(UINib(nibName: "RuleThenActionPropertyCell", bundle: nil), forCellReuseIdentifier: "RuleThenActionPropertyCell")

        // init navigation bar
        initNavigationBar()
        
        // init rule for test
//        let ec1: ExpressionConstraint = ExpressionConstraint()
//        ec1.propertyName = "isOn"
//        ec1.operator = "=="
//        ec1.propertyValue = "false"
//        ec1.propertyType = "boolean"
//        
//        let p1: Pattern = Pattern()
//        p1.id = "1"
//        p1.binding = "$light"
//        p1.objectType = "Light"
//        p1.expressionConstraintList = [ec1]
//        
//        let ec2: ExpressionConstraint = ExpressionConstraint()
//        ec2.propertyName = "type"
//        ec2.operator = "=="
//        ec2.propertyValue = "Father"
//        ec2.propertyType = "string"
//        
//        let p2: Pattern = Pattern()
//        p2.id = "2"
//        p2.binding = "$familyMember"
//        p2.objectType = "FamilyMember"
//        p2.expressionConstraintList = [ec2]
//        
//        let ce1: ConditionalElement = ConditionalElement()
//        ce1.type = "and"
//        ce1.patternIdList = ["1","2"]
//        
//        let lhs: LHS = LHS()
//        lhs.patternList = [p1, p2]
//        lhs.conditionalElementList = [ce1]
//        
//        let property1: Property = Property()
//        property1.name = "isOn"
//        property1.type = "boolean"
//        property1.value = "true"
//        
//        let rhs: RHS = RHS()
//        rhs.binding = "$light"
//        rhs.type = "modify"
//        rhs.propertyList = [property1]
        
//        rule.name = "Turn on/off light"
//        rule.lhs = lhs
//        rule.rhsList = [rhs]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initNavigationBar() {
        self.title = "Rule Designer"
        
        // init cloud icon
        let sendImage = UIImage.init(named: "icon_send")!
        let jsonImage = UIImage.init(named: "icon_json")!
        let duplicationImage = UIImage.init(named: "icon_duplication")!
        
        let sendButton   = UIBarButtonItem(image: sendImage,  style: .plain, target: self, action: #selector(sendButtonClicked(barButton:)))
        let seeJSONformatButton   = UIBarButtonItem(image: jsonImage,  style: .plain, target: self, action: #selector(seeJSONformatButtonClicked(barButton:)))
        let duplicateRuleButton   = UIBarButtonItem(image: duplicationImage,  style: .plain, target: self, action: #selector(duplicateRuleButtonClicked(barButton:)))
        
        navigationItem.rightBarButtonItems = [sendButton, seeJSONformatButton, duplicateRuleButton]
    }
    
    func sendButtonClicked(barButton: UIBarButtonItem) {
        dLog(message: "rule json = " + rule.toJsonString())
        
        // save rule
        DataManager.saveRule(rule: rule)
        
        // send to Android to update KnowledgeBase
        sendRuleSocketData()
    }
    
    func seeJSONformatButtonClicked(barButton: UIBarButtonItem) {
        let jsonData: Data = rule.toJsonString().data(using: String.Encoding.utf8)! as Data
        
        //2. convert JSON data to JSON object
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            
            //3. convert back to JSON data by setting .PrettyPrinted option
            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            
            //4. convert NSData back to NSString (use NSString init for convenience), later you can convert to String.
            let prettyPrintedJson = String(data: prettyJsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            
//            showAlertWithMessage(message: prettyPrintedJson, controller: self)
            
            // go to Show JSON VC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let showJSONVC = storyboard.instantiateViewController(withIdentifier: "ShowJSONViewController") as? ShowJSONViewController
            showJSONVC?.jsonString = prettyPrintedJson
            self.navigationController?.pushViewController(showJSONVC!, animated: true)

        } catch {
            dLog(message: error.localizedDescription)
        }
        
    }
    
    func duplicateRuleButtonClicked(barButton: UIBarButtonItem) {
        // change rule name
        rule.name = rule.name + " 1"
        
        dLog(message: "duplicate rule with json = " + rule.toJsonString())
        
        // save rule
        DataManager.saveRule(rule: rule)
    }
    
    func showAlertWithMessage(message: String, controller: UIViewController, completion:(() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: "JSON Format",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertActionStyle.default,
                                      handler: { (alert) in
                                        
                                        if completion != nil {
                                            completion!()
                                        }
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func sendRuleSocketData() {
        let socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        do {
            try socket.connect(toHost: kSocketServerHost, onPort: UInt16(kSocketServerPort))
        } catch {
            dLog(message: error.localizedDescription)
        }
    }
}

extension RuleDesignerViewController: GCDAsyncSocketDelegate {
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        let data: Data = rule.toJsonString().data(using: String.Encoding.utf8)! as Data
        sock.write(data as Data, withTimeout: 1.0, tag: 0)
    }
}

// MARK: - GCDAsyncUdpSocketDelegate

// handle all socket events
//extension RuleDesignerViewController: GCDAsyncUdpSocketDelegate {
//    
//    func udpSocket(_ sock: GCDAsyncUdpSocket, didConnectToAddress address: Data) {
//        dLog(message: "didConnectToAddress")
//    }
//    
//    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
//        dLog(message: "didNotConnect \(String(describing: error))")
//    }
//    
//    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
//        dLog(message: "didSendDataWithTag")
//    }
//    
//    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotSendDataWithTag tag: Int, dueToError error: Error?) {
//        dLog(message: "didNotSendDataWithTag")
//    }
//    
//    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
//        dLog(message: "didReceiveData")
//        
////        var host: NSString?
////        var port1: UInt16 = 0
////        GCDAsyncUdpSocket.getHost(&host, port: &port1, fromAddress: address)
////        
////        //        dLog(message: "From \(host!)")
////        
////        let gotData: NSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
////        print(gotData)
////        let device = parseResponseData(data: gotData as String, host: host! as String)
////        if device != nil {
////            didReceiveResponseFromDevice(localDevice: device!)
////        }
//    }
//    
////    fileprivate func didReceiveResponseFromDevice(localDevice: Device) {
////        var isShouldRefresh = false
////        var index = 0
////        
////        for device in deviceList as! [Device] {
////            if device.pinCode == localDevice.pinCode {
////                if device.isLocalOnline == false {
////                    device.isLocalOnline = true
////                    isShouldRefresh = true
////                    
////                    //                    self.deviceList.replaceObject(at: index, with: device)
////                    dLog(message: "found local device with pinCode = " + device.pinCode)
////                }
////            }
////            index += 1
////        }
////        
////        if isShouldRefresh && loadingData == false {
////            dLog(message: "reload table")
////            
////            // reload data
////            self.tableView.reloadData()
////        }
////    }
//}


// MARK: - Handle Events

extension RuleDesignerViewController {
    
   
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension RuleDesignerViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 3
        
        // for lhs
        count += rule.lhs.patternList.count
        
        for pattern in rule.lhs.patternList {
            count += pattern.expressionConstraintList.count
        }
        
        count += rule.lhs.conditionalElementList.count
        
        // for rhs
        count += rule.rhs.count
        
        for rhs in rule.rhs {
            count += rhs.propertyList.count
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (rule.lhs.conditionalElementList.count > 0) {
            var conditionalElementRowIndex: Int = 2
            
            for pattern in rule.lhs.patternList {
                conditionalElementRowIndex += 1
                conditionalElementRowIndex += pattern.expressionConstraintList.count
            }
            
            var count: Int = -1
            for conditionalElement in rule.lhs.conditionalElementList {
                count += 1
                if conditionalElement.type == "accumulate" && indexPath.row == (conditionalElementRowIndex + count) {
                    return 164
                }
            }
        }
        
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var count: Int = 1
        
        if indexPath.row == 0 { // for Rule Name Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "RuleNameCell") as? RuleNameCell
            cell?.initView(ruleName: rule.name)
            cell?.delegate = self
            
            return cell!

        }
        if indexPath.row == 1 { // for When Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "RuleWhenCell") as? RuleWhenCell
            cell?.delegate = self
            
            return cell!

        }
        // for LHS
        // for Pattern Cell
        for pattern in rule.lhs.patternList {
            count += 1
            if indexPath.row == count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RuleWhenPatternCell") as? RuleWhenPatternCell
                cell?.initView(pattern: pattern)
                cell?.delegate = self
                
                return cell!
            }
            
            for expressionConstraint in pattern.expressionConstraintList {
                count += 1
                if indexPath.row == count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RuleWhenPatternConstraintCell") as? RuleWhenPatternConstraintCell
                    cell?.initView(expressionConstraint: expressionConstraint, objectType: pattern.objectType)
                    cell?.delegate = self
                    
                    return cell!
                }
            }
        }
        // for Conditional Element Cell
        for conditionalElement in rule.lhs.conditionalElementList {
            count += 1
            if indexPath.row == count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RuleWhenConditionalElementCell") as? RuleWhenConditionalElementCell
                cell?.initView(conditionalElement: conditionalElement)
                cell?.delegate = self
                
                return cell!
            }
        }
        
        // for RHS
        count += 1
        if indexPath.row == count { // for Then Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "RuleThenCell") as? RuleThenCell
            cell?.delegate = self
            
            return cell!
        }
        // for Action Cell
        for rhs in rule.rhs {
            count += 1
            if indexPath.row == count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RuleThenActionCell") as? RuleThenActionCell
                cell?.initView(rhs: rhs)
                cell?.delegate = self
                
                return cell!
            }
            
            for property in rhs.propertyList {
                count += 1
                if indexPath.row == count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RuleThenActionPropertyCell") as? RuleThenActionPropertyCell
                    cell?.initView(property: property)
                    cell?.delegate = self
                    
                    return cell!
                }
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RuleNameCell") as? RuleNameCell

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastElement = (playList.count) - 1
//        if indexPath.row == lastElement && loadingData == false {
//            loadMoreData()
//        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.tableView.deselectRow(at: indexPath, animated: true)
//        
//        ControllerManager.goToPlayListDetailScreen(playList: playList[indexPath.row] as! PlayList, controller: self)
    }
}

extension RuleDesignerViewController: RuleNameCellDelegate {
    
    func handleUpdateRuleName(text: String) {
        rule.name = text
    }
}

extension RuleDesignerViewController: RuleWhenCellDelegate {
    
    func handleTapOnAddPatternButton() {
        // insert new Pattern cell
        let pattern: Pattern = Pattern()
        rule.lhs.patternList.append(pattern)
        
        self.tableView.reloadData()
    }
    
    func handleTapOnAddConditionalElementButton() {
        // insert new Conditional Element cell
        let conditionalElement: ConditionalElement = ConditionalElement()
        rule.lhs.conditionalElementList.append(conditionalElement)
        
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: RuleWhenPatternCellDelegate {
    
    func handleTapOnChooseObjectTypeButton(pattern: Pattern) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseObjectTypeVC = storyboard.instantiateViewController(withIdentifier: "ChooseObjectTypeController") as? ChooseObjectTypeController
        chooseObjectTypeVC?.currentPattern = pattern
        chooseObjectTypeVC?.delegate = self
        self.navigationController?.pushViewController(chooseObjectTypeVC!, animated: true)
    }
    
    func handleTapOnAddConstraintButton(pattern: Pattern) {
        // insert new Constraint cell
        let constraint: ExpressionConstraint = ExpressionConstraint()
        pattern.expressionConstraintList.append(constraint)
        
        self.tableView.reloadData()
    }
    
    func handleTapOnRemoveConstraintButton(pattern: Pattern) {
        // remove Pattern cell
        var count = 0
        for tmpPattern in rule.lhs.patternList {
            if pattern == tmpPattern {
                rule.lhs.patternList.remove(at: count)
                break
            }
            
            count += 1
        }
        
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseObjectTypeControllerDelegate {
    
    func handleChooseObjectType(pattern: Pattern) {
        self.tableView.reloadData()
    }
    
    func handleChooseObjectType(rhs: RHS) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: RuleWhenPatternConstraintCellDelegate {
    
    func handleTapOnChoosePropertyButton(expressionConstraint: ExpressionConstraint, currentObjectType: String) {
        // go to Choose Property VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseObjectPropertyVC = storyboard.instantiateViewController(withIdentifier: "ChooseObjectPropertyController") as? ChooseObjectPropertyController
        chooseObjectPropertyVC?.currentConstraint = expressionConstraint
        chooseObjectPropertyVC?.currentObjectType = currentObjectType
        chooseObjectPropertyVC?.delegate = self
        self.navigationController?.pushViewController(chooseObjectPropertyVC!, animated: true)
    }
    
    func handleTapOnChooseOperatorButton(expressionConstraint: ExpressionConstraint) {
        // go to Choose Operator VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseOperatorVC = storyboard.instantiateViewController(withIdentifier: "ChooseOperatorViewController") as? ChooseOperatorViewController
        chooseOperatorVC?.currentConstraint = expressionConstraint
        chooseOperatorVC?.delegate = self
        self.navigationController?.pushViewController(chooseOperatorVC!, animated: true)
    }
    
    func handleTapOnChoosePropertyValueTypeButton(expressionConstraint: ExpressionConstraint) {
        // go to Choose Property Value Type VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let choosePropertyTypeVC = storyboard.instantiateViewController(withIdentifier: "ChoosePropertyValueTypeViewController") as? ChoosePropertyValueTypeViewController
        choosePropertyTypeVC?.currentConstraint = expressionConstraint
        choosePropertyTypeVC?.isFromLHS = true
        choosePropertyTypeVC?.delegate = self
        self.navigationController?.pushViewController(choosePropertyTypeVC!, animated: true)
    }
    
    func handleTapOnRemoveConstraintButton(expressionConstraint: ExpressionConstraint) {
        // remove ExpressionConstraint cell
        var count = 0
        for tmpPattern in rule.lhs.patternList {
            for tmpConstraint in tmpPattern.expressionConstraintList {
                if expressionConstraint == tmpConstraint {
                    tmpPattern.expressionConstraintList.remove(at: count)
                    break
                }
                
                count += 1
            }
        }
        
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseObjectPropertyControllerDelegate {
    func handleChooseObjectProperty(constraint: ExpressionConstraint) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseOperatorViewControllerDelegate {
    
    func handleChooseOperator(expressionConstraint: ExpressionConstraint) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChoosePropertyValueTypeViewControllerDelegate {
    
    func handleChoosePropertyType(expressionConstraint: ExpressionConstraint) {
        self.tableView.reloadData()
    }
    
    func handleChoosePropertyType(property: Property) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: RuleWhenConditionalElementCellDelegate {
    
    func handleTapOnRemoveConditionalElementButton(conditionalElement: ConditionalElement) {
        // remove ConditionalElement cell
        var count = 0
        for tmpCE in rule.lhs.conditionalElementList {
            if conditionalElement == tmpCE {
                rule.lhs.conditionalElementList.remove(at: count)
                break
            }
            
            count += 1
        }
        
        self.tableView.reloadData()
    }

    
    func handleTapOnChooseTypeButton(conditionalElement: ConditionalElement) {
        // go to Choose Property Value Type VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseConditionalElementTypeVC = storyboard.instantiateViewController(withIdentifier: "ChooseConditionalElementTypeViewController") as? ChooseConditionalElementTypeViewController
        chooseConditionalElementTypeVC?.currentConditionalElement = conditionalElement
        chooseConditionalElementTypeVC?.delegate = self
        self.navigationController?.pushViewController(chooseConditionalElementTypeVC!, animated: true)
    }
    
    func handleTapOnChoosePatternIdListButton(conditionalElement: ConditionalElement) {
        // go to Choose Pattern Id List VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let choosePatternIdListVC = storyboard.instantiateViewController(withIdentifier: "ChoosePatternIdListViewController") as? ChoosePatternIdListViewController
        choosePatternIdListVC?.currentConditionalElement = conditionalElement
        
        var patternIdList: [String] = []
        for pattern in rule.lhs.patternList {
            patternIdList.append(pattern.id)
        }
        choosePatternIdListVC?.patternIdList = patternIdList
        choosePatternIdListVC?.delegate = self
        self.navigationController?.pushViewController(choosePatternIdListVC!, animated: true)
    }
    
    func handleTapOnChooseResultTypeButton(conditionalElement: ConditionalElement) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseResultTypeVC = storyboard.instantiateViewController(withIdentifier: "ChooseAccumulateResultTypeViewController") as? ChooseAccumulateResultTypeViewController
        chooseResultTypeVC?.currentConditionalElement = conditionalElement
        chooseResultTypeVC?.delegate = self
        self.navigationController?.pushViewController(chooseResultTypeVC!, animated: true)
    }
    
    func handleTapOnChooseOperatorButton(conditionalElement: ConditionalElement) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseOperatorVC = storyboard.instantiateViewController(withIdentifier: "ChooseAccumulateResultOperatorViewController") as? ChooseAccumulateResultOperatorViewController
        chooseOperatorVC?.currentConditionalElement = conditionalElement
        chooseOperatorVC?.delegate = self
        self.navigationController?.pushViewController(chooseOperatorVC!, animated: true)
    }
    
    func handleTapOnChooseWindowTypeButton(conditionalElement: ConditionalElement) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseWindowTypeVC = storyboard.instantiateViewController(withIdentifier: "ChooseAccumulateWindowTypeViewController") as? ChooseAccumulateWindowTypeViewController
        chooseWindowTypeVC?.currentConditionalElement = conditionalElement
        chooseWindowTypeVC?.delegate = self
        self.navigationController?.pushViewController(chooseWindowTypeVC!, animated: true)
    }
    
    func handleTapOnChooseCalculateTypeButton(conditionalElement: ConditionalElement) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseCalculateTypeVC = storyboard.instantiateViewController(withIdentifier: "ChooseAccumulateCalculateTypeViewController") as? ChooseAccumulateCalculateTypeViewController
        chooseCalculateTypeVC?.currentConditionalElement = conditionalElement
        chooseCalculateTypeVC?.delegate = self
        self.navigationController?.pushViewController(chooseCalculateTypeVC!, animated: true)

    }
}

extension RuleDesignerViewController: ChooseAccumulateCalculateTypeViewControllerDelegate {
    
    func handleChooseAccumulateCalculateType(conditionalElement: ConditionalElement) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseAccumulateWindowTypeViewControllerDelegate {
    
    func handleChooseAccumulateWindowType(conditionalElement: ConditionalElement) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseAccumulateResultOperatorViewControllerDelegate {
    
    func handleChooseAccumulateResultOperator(conditionalElement: ConditionalElement) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseAccumulateResultTypeViewControllerDelegate {
    
    func handleChooseAccumulateResultType(conditionalElement: ConditionalElement) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChoosePatternIdListViewControllerDelegate {
    
    func handleChoosePatternIdList(conditionalElement: ConditionalElement) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseConditionalElementTypeViewControllerDelegate {
    
    func handleChooseConditionalElementType(conditionalElement: ConditionalElement) {
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: RuleThenCellDelegate {
    
    func handleTapOnActionButton() {
        // insert Action cell
        let rhs: RHS = RHS()
        rule.rhs.append(rhs)
        
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: RuleThenActionCellDelegate {
    
    func handleTapOnChooseTypeButton(rhs: RHS) {
        // go to Choose Property Value Type VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseActionTypeVC = storyboard.instantiateViewController(withIdentifier: "ChooseActionTypeViewController") as? ChooseActionTypeViewController
        chooseActionTypeVC?.currentRHS = rhs
        chooseActionTypeVC?.delegate = self
        self.navigationController?.pushViewController(chooseActionTypeVC!, animated: true)
    }
    
    func handleTapOnAddPropertyButton(rhs: RHS) {
        // insert new Property Cell
        let property: Property = Property()
        rhs.propertyList.append(property)
        
        self.tableView.reloadData()
    }
    
    func handleTapOnRemoveActionButton(rhs: RHS) {
        // remove Action cell
        var count = 0
        for tmpRHS in rule.rhs {
            if rhs == tmpRHS {
                rule.rhs.remove(at: count)
                break
            }
            
            count += 1
        }
        
        self.tableView.reloadData()
    }
    
    func handleTapOnChooseObjectTypeButton(rhs: RHS) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseObjectTypeVC = storyboard.instantiateViewController(withIdentifier: "ChooseObjectTypeController") as? ChooseObjectTypeController
        chooseObjectTypeVC?.currentRHS = rhs
        chooseObjectTypeVC?.isFromRHS = true
        chooseObjectTypeVC?.delegate = self
        self.navigationController?.pushViewController(chooseObjectTypeVC!, animated: true)
    }
}

extension RuleDesignerViewController: RuleThenActionPropertyCellDelegate {
    
    func handleTapOnChooseTypeButton(property: Property) {
        // go to Choose Property Value Type VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let choosePropertyTypeVC = storyboard.instantiateViewController(withIdentifier: "ChoosePropertyValueTypeViewController") as? ChoosePropertyValueTypeViewController
        choosePropertyTypeVC?.currentProperty = property
        choosePropertyTypeVC?.isFromLHS = false
        choosePropertyTypeVC?.delegate = self
        self.navigationController?.pushViewController(choosePropertyTypeVC!, animated: true)
    }
    
    func handleTapOnRemovePropertyButton(property: Property) {
        // remove Property cell
        var count = 0
        for tmpRHS in rule.rhs {
            for tmpProperty in tmpRHS.propertyList {
                if property == tmpProperty {
                    tmpRHS.propertyList.remove(at: count)
                    break
                }
                
                count += 1
            }
        }
        
        self.tableView.reloadData()
    }
}

extension RuleDesignerViewController: ChooseActionTypeViewControllerDelegate {
    
    func handleChooseActionType(rhs: RHS) {
        self.tableView.reloadData()
    }
}
