//
//  FirstViewController.swift
//  ToDoList
//
//  Created by TIP QC on 02/08/2017.
//  Copyright © 2017 TIPQC. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  //ITEM COUNT
        return items.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {  //ITEM BY INDEX
        let cell = UITableViewCell (style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let itemObjects = UserDefaults.standard.object(forKey: "items")
        if let tempItems = itemObjects as? [String] {
            items = tempItems
        }
        table.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let itemObjects = UserDefaults.standard.object(forKey: "items")
        if let tempItems = itemObjects as? [String] {
            items = tempItems
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) { //EDITING CELL
        if editingStyle == UITableViewCellEditingStyle.delete {
            deleteTaskDialog(dialogTitle: "Warning!", dialogMsg: "Are you sure you want to delete this task?", index: indexPath.row)
        }
    }
    
    func deleteTaskDialog(dialogTitle: String, dialogMsg: String, index: Int) {
        let alert = UIAlertController(title: dialogTitle, message: dialogMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { _ in self.deleteTask(index: index) }))
        alert.addAction(UIAlertAction(title: "Cancel", style:UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteTask(index: Int) {
        items.remove(at: index)
        table.reloadData()
        UserDefaults.standard.set(items, forKey: "items")
        showMsgDialog(dialogMsg: "Task has been deleted", dialogTitle: "Task Deleted")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMsgDialog(dialogMsg: String, dialogTitle: String) {
        let alert = UIAlertController(title: dialogTitle, message: dialogMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

