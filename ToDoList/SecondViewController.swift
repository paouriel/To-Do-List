//
//  SecondViewController.swift
//  ToDoList
//
//  Created by TIP QC on 02/08/2017.
//  Copyright © 2017 TIPQC. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    //var firstVC: FirstViewController = FirstViewController(nibName: nil, bundle: nil)

    @IBOutlet weak var newTaskField: UITextField!
    @IBAction func addNewTask(_ sender: Any) {
        let itemObjects = UserDefaults.standard.object(forKey: "items")
        var items:[String]
        
        if(newTaskField.text != "") {
            if let tempItems = itemObjects as? [String] {
                items = tempItems
                items.append(newTaskField.text!)
            } else {
                items = [newTaskField.text!]
            }

            //firstVC.table.reloadData()
            UserDefaults.standard.set(items, forKey: "items")
            newTaskField.text = ""
            showMsgDialog(dialogMsg: "A new task has been added!", dialogTitle: "Success")
        } else {
            showMsgDialog(dialogMsg: "Please enter a new task", dialogTitle: "Empty Field")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func showMsgDialog(dialogMsg: String, dialogTitle: String) {
        let alert = UIAlertController(title: dialogTitle, message: dialogMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.newTaskField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

