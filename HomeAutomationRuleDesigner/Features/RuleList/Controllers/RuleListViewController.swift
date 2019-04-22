//
//  RuleListViewController.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 25/01/2018.
//  Copyright © 2018 SLab. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

class RuleListViewController: UITableViewController {
        
    var ruleList: [Rule] = []
    
    var ruleToDelete: Rule?
    
    var isDeleteAllRule = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(UINib(nibName: "RuleListCell", bundle: nil), forCellReuseIdentifier: "RuleListCell")
        
        initNavigationBar()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func reloadData() {
        guard let ruleStringList = DataManager.getRuleList() else {
            dLog(message: "rule list is empty")
            return
        }
        
        // clear all old data
        ruleList.removeAll()
        
        for ruleString in ruleStringList {
            // convert from json string to rule object
            let rule = Rule(json: ruleString)
            
            ruleList.append(rule)
        }
        
        tableView.reloadData()
    }
    
    fileprivate func initNavigationBar() {
        self.title = "Rule List"
        
        // adding Add Rule Button
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked(barButton:)))
        
        // adding Remove all rules Button
        let removeAllRuleImage = UIImage.init(named: "icon_remove_all_rule")!
        let removeAllRuleButton   = UIBarButtonItem(image: removeAllRuleImage,  style: .plain, target: self, action: #selector(removeAllRuleButtonClicked(barButton:)))
        
        self.navigationItem.leftBarButtonItems = [addButton, removeAllRuleButton]
    }
    
    func addButtonClicked(barButton: UIBarButtonItem) {
        // go to Rule Designer
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RuleDesignerViewController") as! RuleDesignerViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func removeAllRuleButtonClicked(barButton: UIBarButtonItem) {
        // go to Rule Designer
        dLog(message: "removeAllRuleButtonClicked")
        isDeleteAllRule = true;
        
        sendRuleSocketData()
    }
}

// MARK: - Table view data source

extension RuleListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ruleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RuleListCell") as? RuleListCell
        
        let rule = ruleList[indexPath.row]
        cell?.initView(ruleName: rule.name)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to Rule Editor screen
        
        let rule = ruleList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RuleDesignerViewController") as! RuleDesignerViewController
        vc.rule = rule
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // send data to Android to delete rule
            ruleToDelete = ruleList[indexPath.row]
            ruleToDelete?.commandType = kCommandTypeDelete
            
            isDeleteAllRule = false
            sendRuleSocketData()
            
            // update data source
            ruleList.remove(at: indexPath.row)
            
            DataManager.updateRuleList(ruleList: ruleList)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func sendRuleSocketData() {
        let socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        do {
            try socket.connect(toHost: kSocketServerHost, onPort: UInt16(kSocketServerPort))
        } catch {
            dLog(message: error.localizedDescription)
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension RuleListViewController: GCDAsyncSocketDelegate {
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        if isDeleteAllRule {
            let rule = Rule.init()
            rule.target = kTargetRule
            rule.commandType = kCommandTypeDeleteAll
            
            let data: Data = rule.toJsonString().data(using: String.Encoding.utf8)! as Data
            sock.write(data as Data, withTimeout: 1.0, tag: 0)
        } else {
            let data: Data = ruleToDelete!.toJsonString().data(using: String.Encoding.utf8)! as Data
            sock.write(data as Data, withTimeout: 1.0, tag: 0)
        }
    }
}
