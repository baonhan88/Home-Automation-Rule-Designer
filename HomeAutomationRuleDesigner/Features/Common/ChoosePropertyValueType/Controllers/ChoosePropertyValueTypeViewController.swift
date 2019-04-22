//
//  ChoosePropertyValueTypeViewController.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol ChoosePropertyValueTypeViewControllerDelegate {
    func handleChoosePropertyType(expressionConstraint: ExpressionConstraint)
    func handleChoosePropertyType(property: Property)
}

class ChoosePropertyValueTypeViewController: UITableViewController {
    
    var propertyTypeList: [String] = []
    var currentConstraint: ExpressionConstraint?
    var currentProperty: Property?
    
    var isFromLHS = false
    
    var delegate: ChoosePropertyValueTypeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        propertyTypeList = kPropertyTypeList
        
        initNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initNavigationBar() {
        // init done icon
        let doneButton   = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked(barButton:)))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneButtonClicked(barButton: UIBarButtonItem) {
        if isFromLHS {
            if currentConstraint?.propertyType == "" {
                return
            }
            
            delegate?.handleChoosePropertyType(expressionConstraint: currentConstraint!)
        } else {
            if currentProperty?.type == "" {
                return
            }
            
            delegate?.handleChoosePropertyType(property: currentProperty!)
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyTypeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoosePropertyValueTypeCell", for: indexPath)
        
        cell.textLabel?.text = propertyTypeList[indexPath.row]
        
        if isFromLHS {
            if propertyTypeList[indexPath.row] == currentConstraint?.propertyType {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
        } else {
            if propertyTypeList[indexPath.row] == currentProperty?.type {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromLHS {
            currentConstraint?.propertyType = propertyTypeList[indexPath.row]
        } else {
            currentProperty?.type = propertyTypeList[indexPath.row]
        }
        
        tableView.reloadData()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
