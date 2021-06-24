//
//  HomeTableViewController.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/24/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let category = ["business","entertainment","general","health","science","sports","technology"]
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCell, for: indexPath) as! CategoryTableViewCell
        cell.categoryImage.image = UIImage(named: category[indexPath.row])
        cell.titleLabel.text = category[indexPath.row].uppercased()
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: K.segueSource, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SourceTableViewController{
            let destinationVC = segue.destination as! SourceTableViewController
            destinationVC.categoryValue = category[index]
        }
    }
}
