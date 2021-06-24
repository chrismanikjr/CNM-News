//
//  SourceTableViewController.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/24/21.
//

import UIKit

class SourceTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var categoryValue: String?
    var apiKey = "&apiKey=0f76de8e3dab42ce85863ca9685e58cd"
    var url = "https://newsapi.org/v2/sources?category="
    
    var finalURL: String{
        return url + categoryValue! + apiKey
    }
    
    var index = 0
    var sourceArray = [SourceModel]()
    
    var filterData: [SourceModel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search News Sources"
        print(finalURL)
        performRequest(urlString: finalURL)
        filterData = sourceArray
    }
    
    
    // MARK: - fetch data
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.showToast(message: error!.localizedDescription)
                }
                if let safeData = data{
                    self.parseJSON(from: safeData)
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(from data: Data){
        sourceArray = []
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Sources.self, from: data)
            for index in 0...(decodedData.sources.count - 1){
                let id = decodedData.sources[index].id
                let name = decodedData.sources[index].name
                let description = decodedData.sources[index].description
                let source = SourceModel(id: id, name: name, desc: description)
                self.sourceArray.append(source)
            }
            DispatchQueue.main.async {
                self.filterData = self.sourceArray
                self.tableView.reloadData()
            }
        }catch{
            print(error)
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.sourceCell, for: indexPath) as! SourcesTableViewCell
        cell.configureSource(source: filterData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: K.segueArticle, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ArticleViewController{
            let destinationVC = segue.destination as! ArticleViewController
            destinationVC.source = filterData[index].id
        }
    }
}
// MARK: - Search Bar Delegate
extension SourceTableViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchText == ""{
            filterData = sourceArray
        }else{
            for data in sourceArray{
                if data.name.lowercased().contains(searchText.lowercased()){
                    filterData.append(data)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterData = sourceArray
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        tableView.reloadData()
    }
}
