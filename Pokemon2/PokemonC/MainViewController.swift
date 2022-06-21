//
//  MainViewController.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/14/22.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    var widthCell = CGFloat()

    @IBOutlet weak var btTypes: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let urlC = "https://api.jsonbin.io/b/622c2ffba703bb67492999c4"
    var pokemonAllC = [Pokemon1]()
    var pokemonAllT = [Pokemon1]()
    var pokemonAllS = [Pokemon1]()
    var types:String? = UserDefaults.standard.string(forKey: "aaa")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        widthCell = self.view.frame.width/3 - 10
        if types == nil{
            types = "All"
            UserDefaults.standard.set(types, forKey: "aaa")
        }
        navigationItem.title = "PokeDex"

        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        loadJsonC()
    }
    
    func loadJsonC(){
        URLSession.shared.dataTask(with: URL(string: urlC)!) { [self] (data, reponse, error) in
            if error == nil{
                do{
                    let result = try JSONDecoder().decode([Pokemon1].self, from: data!)
                    self.pokemonAllC = result
                    if types == "All"{
                        self.pokemonAllT = self.pokemonAllC
                    }
                    else{
                        let type1 = self.pokemonAllC.filter { (pk) -> Bool in
                            return pk.type.joined(separator: ",").lowercased().contains((types?.lowercased())!)
                        }
                        self.pokemonAllT = type1
                    }
                    
                    self.pokemonAllS = self.pokemonAllT
                    DispatchQueue.main.async {
                        
                        self.collectionView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reload")
        guard let types = UserDefaults.standard.string(forKey: "aaa")else{
            return
        }
        if types == "All"{
            pokemonAllT = pokemonAllC
            pokemonAllS = pokemonAllT
        }
        else{
            let pk = pokemonAllC.filter { (pk) -> Bool in
                return pk.type.joined(separator: ",").lowercased().contains(types.lowercased())
            }
            pokemonAllT = pk
            pokemonAllS = pokemonAllT
        }
        btTypes.setImage(UIImage(named: types.lowercased()), for: .normal)
        searchBar.searchTextField.text = ""
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCell, height: widthCell)
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonAllS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as! MainCollectionViewCell
        let cell1 = pokemonAllS[indexPath.item]
        cell.lbl1Collection.text = "#"+cell1.id.change()
        cell.lbl2Collection.text = cell1.name.english
        cell.imgCollection.image = UIImage(named: cell1.id.change())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let nextSb = sb.instantiateViewController(identifier: "mainCollection")as! MainCollectionViewController
        nextSb.detailC = pokemonAllS[indexPath.item]
        self.present(nextSb, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText(searchText)
    }
  
    func searchBarText(_ text: String){
        pokemonAllS = []
        let search: [Pokemon1] = pokemonAllT.filter({ (pokemon) -> Bool in
            return pokemon.name.english.lowercased().contains(text.lowercased())
        })
        
        if searchBar.text == ""{
            pokemonAllS = pokemonAllT
        }
        else{
            pokemonAllS = search
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

extension Int{
    func change() -> String{
        return String(format: "%03d", self)
    }
}

extension String{
    func changeC() -> UIColor{
        switch self {
        case "Bug":
            return #colorLiteral(red: 0.5665972233, green: 0.7565605044, blue: 0.1735848784, alpha: 1)
        case "Dark":
            return #colorLiteral(red: 0.3540384769, green: 0.3268864155, blue: 0.4016499519, alpha: 1)
        case "Dragon":
            return #colorLiteral(red: 0.02916923165, green: 0.4278259873, blue: 0.7693730593, alpha: 1)
        case "Electric":
            return #colorLiteral(red: 0.9510678649, green: 0.8255994916, blue: 0.2318550944, alpha: 1)
        case "Fairy":
            return #colorLiteral(red: 0.9248331189, green: 0.5630199909, blue: 0.9008280635, alpha: 1)
        case "Fighting":
            return #colorLiteral(red: 0.8086045384, green: 0.2532474995, blue: 0.4134700894, alpha: 1)
        case "Fire":
            return #colorLiteral(red: 0.9999436736, green: 0.6136170626, blue: 0.3294963837, alpha: 1)
        case "Flying":
            return #colorLiteral(red: 0.5734239817, green: 0.6646226048, blue: 0.8717713952, alpha: 1)
        case "Ghost":
            return #colorLiteral(red: 0.3237785399, green: 0.4110845923, blue: 0.6737699509, alpha: 1)
        case "Grass":
            return #colorLiteral(red: 0.3872927129, green: 0.7347337604, blue: 0.3555828631, alpha: 1)
        case "Ground":
            return #colorLiteral(red: 0.7819410563, green: 0.7182949185, blue: 0.5446414351, alpha: 1)
        case "Ice":
            return #colorLiteral(red: 0.4527589679, green: 0.8095708489, blue: 0.7523676157, alpha: 1)
        case "Normal":
            return #colorLiteral(red: 0.5668130517, green: 0.6004849076, blue: 0.6305238008, alpha: 1)
        case "Poison":
            return #colorLiteral(red: 0.6724099517, green: 0.4171051979, blue: 0.7857961059, alpha: 1)
        case "Psychic":
            return #colorLiteral(red: 0.977222383, green: 0.44356668, blue: 0.4645978212, alpha: 1)
        case "Rock":
            return #colorLiteral(red: 0.8489226699, green: 0.4618632793, blue: 0.2683558762, alpha: 1)
        case "Steel":
            return #colorLiteral(red: 0.3524813652, green: 0.5565565228, blue: 0.6320964098, alpha: 1)
        case "Water":
            return #colorLiteral(red: 0.3037801385, green: 0.5639193058, blue: 0.8373667598, alpha: 1)
        default:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
}

