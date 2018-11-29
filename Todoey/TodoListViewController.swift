//
//  ViewController.swift
//  Todoey
//
//  Created by Vuesol on 11/29/18.
//  Copyright © 2018 Vuesol. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
     let itemArray = ["hi you" , "how you doing", "dragons"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - tABLEVIEW dATATSOURCE Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
         cell.textLabel?.text = itemArray[indexPath.row]
        
        
        return cell
    }
   // MARK- TABLEVIEW Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print (itemArray[indexPath.row])
        if (tableView.cellForRow (at :indexPath)?.accessoryType == .checkmark) {
           tableView.cellForRow (at :indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow (at :indexPath)?.accessoryType = .checkmark
        }
        
    tableView.deselectRow (at :indexPath, animated :true ) 
    }
}
