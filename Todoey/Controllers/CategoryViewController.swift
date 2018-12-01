//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vuesol on 12/1/18.
//  Copyright © 2018 Vuesol. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class CategoryViewController: UITableViewController {
var textField = UITextField()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category] ()
    override func viewDidLoad() {
        super.viewDidLoad()
     loadCategories()
    }
        
        // MARK: -tableView dATA sOURCEmETHODS
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
        }
        
        override   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: " CategoryCell ", for: indexPath)
            
            cell.textLabel?.text = categories [indexPath.row].name
            
            return cell
        }
        
        //mARK: - TABLEVIEW dELEGATE methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems ", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathsForSelectedRows {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
        
        //mark :-- Data MANIPULATIVE METHODS
    func saveCategories() {
        do{
            try context.save()
            
        } catch {
            print ("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    func loadCategories () {
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories =  try context.fetch(request)
        } catch {
            print ("error loading categories\(error)")
            tableView.reloadData()
            
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {   
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle:.alert)
         let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category (context: self.context)
            newCategory.name = self.textField.text!
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        alert.addTextField { (  field) in
           field.placeholder = "create new item"
            self.textField = field
        
    }
        alert.addAction(action)
        present(alert, animated:  true, completion: nil)
   
    
}
}
