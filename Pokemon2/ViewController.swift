//
//  ViewController.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/11/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonAll : [Pokemon] = []
    var pokemonSearch : [Pokemon] = []
    
    let linkJson: String = "https://api.jsonbin.io/b/6218ae0224f17933e49f2447/4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "PoKéDex"
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        loadJson(url: linkJson)
        // Do any additional setup after loading the view.
    }
    
    func loadJson(url: String){
        URLSession.shared.dataTask(with: URL(string: url)!){(data, response,error) in
            if error == nil{
                do{
                    let json = try JSONDecoder().decode([Pokemon].self, from: data!.parseData(removeString: "null,")!)
                    self.pokemonAll = json
                    DispatchQueue.main.async {
                        self.pokemonSearch = self.pokemonAll
                        self.tableView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail") as! DetailTableViewCell
        let indexCell = pokemonSearch[indexPath.row]
        cell.lbl1D.text = indexCell.name.capitalized
        cell.textFD.text = indexCell.welcomeDescription
        cell.imgD.image = UIImage(named: "all")
        cell.lbl2D.layer.cornerRadius = cell.lbl2D.frame.size.height/2
        cell.lbl2D.text = indexCell.type
        cell.lbl2D.layer.masksToBounds = true
        cell.lbl2D.backgroundColor = indexCell.type.colorD
        ImageServices.downloadImage(withURL: URL(string: indexCell.imageURL)!) { (image) in
            cell.imgD.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonSearch = []
        if (searchBar.text == ""){
            pokemonSearch = pokemonAll
        }
        else{
            for i in pokemonAll{
                if(i.name.lowercased().contains(searchText.lowercased())){
                    pokemonSearch.append(i)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }


}

extension Data {
   func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}

extension String{
    var colorD: UIColor{
        switch self {
        case "fire": return .systemRed
        case "poison": return .systemGreen
        case "water": return .systemBlue
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemTeal
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
}

