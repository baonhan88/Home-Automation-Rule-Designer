//
//  ChoosePatternIdListViewController.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 30/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol ChoosePatternIdListViewControllerDelegate {
    func handleChoosePatternIdList(conditionalElement: ConditionalElement)
}

class ChoosePatternIdListViewController: UITableViewController {
    
    var patternIdList: [String] = []
    var currentConditionalElement: ConditionalElement?
    
    var delegate: ChoosePatternIdListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        if currentConditionalElement?.patternIdList.count == 0 {
            return
        }
        
        delegate?.handleChoosePatternIdList(conditionalElement: currentConditionalElement!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patternIdList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoosePatternIdListCell", for: indexPath)
        
        cell.textLabel?.text = patternIdList[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.none
        for id in (currentConditionalElement?.patternIdList)! {
            if patternIdList[indexPath.row] == id {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choseId = patternIdList[indexPath.row]
        
        var isExist = false
        var count = 0
        for id in (currentConditionalElement?.patternIdList)! {
            if id == choseId {
                isExist = true
                currentConditionalElement?.patternIdList.remove(at: count)
                break
            }
            count += 1
        }
        
        if !isExist {
            currentConditionalElement?.patternIdList.append(choseId)
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

