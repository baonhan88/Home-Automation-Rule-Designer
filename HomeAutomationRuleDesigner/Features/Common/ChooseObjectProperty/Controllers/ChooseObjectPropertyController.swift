//
//  ChooseObjectPropertyController.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 29/11/2017.
//  Copyright © 2017 SLab. All rights reserved.
//

import UIKit

protocol ChooseObjectPropertyControllerDelegate {
    func handleChooseObjectProperty(constraint: ExpressionConstraint)
}

class ChooseObjectPropertyController: UITableViewController {
    
    var objectPropertyList: [String] = []
    var currentObjectType: String?
    var currentConstraint: ExpressionConstraint?
    
    var delegate: ChooseObjectPropertyControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if currentObjectType == "Light" {
            objectPropertyList = kLightPropertyList
        } else if (currentObjectType == "TemperatureSensor") {
            objectPropertyList = kTemperatureSensorPropertyList
        } else if (currentObjectType == "HumiditySensor") {
            objectPropertyList = kHumiditySensorPropertyList
        } else if (currentObjectType == "Room") {
            objectPropertyList = kRoomPropertyList
        } else if (currentObjectType == "FamilyMember") {
            objectPropertyList = kFamilyMemberPropertyList
        } else if (currentObjectType == "Camera") {
            objectPropertyList = kCameraPropertyList
        } else if (currentObjectType == "CameraOld") {
            objectPropertyList = kCameraOldPropertyList
        } else if (currentObjectType == "DataMiningThermostat") {
            objectPropertyList = kDataMiningThermostatPropertyList
        } else if (currentObjectType == "Thermostat") {
            objectPropertyList = kThermostatPropertyList
        } else if (currentObjectType == "Alarm") {
            objectPropertyList = kAlarmPropertyList
        } else if (currentObjectType == "MotionSensor") {
            objectPropertyList = kMotionSensorPropertyList
        }
        
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
    
    fileprivate func getPropertyTypeByPropertyName(propertyName: String) -> String {
        var i = 0
        
        for tmpPropertyName in objectPropertyList {
            if tmpPropertyName == propertyName {
                let propertyTypeList = getPropertyTypeList()
                if propertyTypeList.count > 0 {
                    return propertyTypeList[i]
                } else {
                    break
                }
            }
            
            i += 1
        }
        
        return ""
    }
    
    fileprivate func getPropertyTypeList() -> [String] {
        if currentObjectType == "Light" {
            return kLightPropertyTypeList
        } else if (currentObjectType == "TemperatureSensor") {
            return kTemperatureSensorPropertyTypeList
        } else if (currentObjectType == "HumiditySensor") {
            return kHumiditySensorPropertyTypeList
        } else if (currentObjectType == "Room") {
            return kRoomPropertyTypeList
        } else if (currentObjectType == "FamilyMember") {
            return kFamilyMemberPropertyTypeList
        } else if (currentObjectType == "Camera") {
            return kCameraPropertyTypeList
        } else if (currentObjectType == "CameraOld") {
            return kCameraOldPropertyTypeList
        } else if (currentObjectType == "DataMiningThermostat") {
            return kDataMiningThermostatPropertyTypeList
        } else if (currentObjectType == "Thermostat") {
            return kThermostatPropertyTypeList;
        } else if (currentObjectType == "Alarm") {
            return kAlarmPropertyTypeList
        }else if (currentObjectType == "MotionSensor") {
            return kMotionSensorPropertyTypeList
        }
        
        return []
    }
    
    func doneButtonClicked(barButton: UIBarButtonItem) {
        if currentConstraint?.propertyName == "" {
            return
        }
        
        delegate?.handleChooseObjectProperty(constraint: currentConstraint!)
        
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectPropertyList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseObjectPropertyCell", for: indexPath)

        cell.textLabel?.text = objectPropertyList[indexPath.row]
        if objectPropertyList[indexPath.row] == currentConstraint?.propertyName {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentConstraint?.propertyName = objectPropertyList[indexPath.row]
        currentConstraint?.propertyType = getPropertyTypeByPropertyName(propertyName: (currentConstraint?.propertyName)!)
        
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
