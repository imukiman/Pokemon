//
//  TypesViewController.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/16/22.
//

import UIKit

class TypesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var collectionView1: UICollectionView!
    
    var types: [String] = [ "Bug","Dark","Dragon","Electric","Fairy","Fighting","Fire","Flying","Ghost","Grass","Ground","Ice","Normal","Poison","Psychic","Rock","Steel","Water", "All"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Types"
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView1.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(types[indexPath.item], forKey: "aaa")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTypes", for: indexPath)as! TypesCollectionViewCell
        cells.lblTypes.text = types[indexPath.item]
        cells.imgTypes.image = UIImage(named: types[indexPath.item].lowercased())
        return cells
    }
    
    

}
