//
//  ViewController.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/23/21.
//

import UIKit
import SafariServices
class ArticleViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var source: String?
    var apiKey = "&apiKey=0f76de8e3dab42ce85863ca9685e58cd"
    var url = "https://newsapi.org/v2/everything?sources="
    var newsArray = [ArticleModel]()
    let urlImageDefault = "https://st.depositphotos.com/1006899/3776/i/950/depositphotos_37765339-stock-photo-news.jpg"
    
    var finalURL: String{
            return url + source! + apiKey
    }
    var filterData: [ArticleModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search News Article"
        performRequest(urlString: finalURL)
        filterData = newsArray
    }
    
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
        newsArray = []
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(News.self, from: data)
            if decodedData.articles.count != 0{
                for index in 0...(decodedData.articles.count - 1){
                    let title = decodedData.articles[index].title
                    let desc = decodedData.articles[index].description
                    let datePublish = decodedData.articles[index].publishedAt
                    let urlContent = decodedData.articles[index].url
                    let urlImage = decodedData.articles[index].urlToImage ?? urlImageDefault
                    let news = ArticleModel(title: title,desc: desc, publishedAt: datePublish, url: urlContent, imageURL: urlImage)
                    self.newsArray.append(news)
                }
                DispatchQueue.main.async {
                    self.filterData = self.newsArray
                    self.tableView.reloadData()
                }
            }else{
                newsArray = []
                filterData = []
            }
            
        }catch{
            self.showToast(message: error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.listCell, for: indexPath) as! ListNewsTableViewCell
        cell.configure(news: filterData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Better using Safari Services than WebKit
        if let url = URL(string: filterData[indexPath.row].url){
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



// MARK: - Search Bar Delegate
extension ArticleViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchText == ""{
            filterData = newsArray
        }else{
            for data in newsArray{
                if data.title.lowercased().contains(searchText.lowercased()){
                    filterData.append(data)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterData = newsArray
        
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        tableView.reloadData()
    }
}

// MARK: - Download image url
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
