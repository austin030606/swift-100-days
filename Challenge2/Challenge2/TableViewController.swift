//
//  TableViewController.swift
//  Challenge2
//
//  Created by Austin Chiu on 2023/2/12.
//

import UIKit

class TableViewController: UITableViewController {
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restart))
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = shoppingList[indexPath.row]

        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter Product Name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addTextField()
        
        ac.textFields?[0].placeholder = "Name"
        ac.textFields?[1].placeholder = "Count"
        
        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let name = ac?.textFields?[0].text,
                  let count = ac?.textFields?[1].text else { return }
            self?.add(name, count)
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    func add(_ product: String, _ count: String) {
        if product.count == 0 || count == "0" || count.count == 0 {
            return
        } else if Int(count) == nil {
            let ac = UIAlertController(title: "Please enter a valid number", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Dissmis", style: .default))
            present(ac, animated: true)
            return
        }
        shoppingList.insert(product + " x\(count)", at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func restart() {
        let ac = UIAlertController(title: "Are you sure you want to clear your list?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        ac.addAction(UIAlertAction(title: "Yes", style: .default){ [weak self] action in
            self?.shoppingList.removeAll()
            self?.tableView?.reloadData()
        })
        
        present(ac, animated: true)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
