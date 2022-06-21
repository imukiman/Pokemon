//
//  MainCollectionViewController.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/14/22.
//

import UIKit

class MainCollectionViewController: UIViewController {
    
    @IBOutlet weak var stackVMainC: UIStackView!
    @IBOutlet weak var imgMainC: UIImageView!
    @IBOutlet weak var viewImage: UIView!


    @IBOutlet var lblStatC: [UILabel]!
    
    @IBOutlet var lblSCollection: [UILabel]!
    
    @IBOutlet var viewStatC: [UIView]!
    
    @IBOutlet weak var lblNumber: UILabel!
    var detailC : Pokemon1?
    
    @IBOutlet weak var lblNameMainC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detail = detailC else{
            return
        }
        setUpView(po: detail)
        createStack(po: detail)
        createLblStat(po: detail)
    }
    
    func  createLblStat(po: Pokemon1){
        
        for i in lblSCollection{
            i.textColor = po.type[0].changeC()
        }
        
        lblNumber.text = "#" + po.id.change()
        
        let avg = (po.base.hp + po.base.attack + po.base.defense + po.base.spAttack + po.base.spDefense + po.base.speed)/6
        var arrayStat: [Int] = []
        arrayStat.append(po.base.hp)
        arrayStat.append(po.base.attack)
        arrayStat.append(po.base.defense)
        arrayStat.append(po.base.spAttack)
        arrayStat.append(po.base.spDefense)
        arrayStat.append(po.base.speed)
        arrayStat.append(avg)
        
        for i in 0..<lblStatC.count{
            lblStatC[i].text = String(arrayStat[i])
            lblStatC[i].textColor = .gray
        }
        
        for i in 0..<viewStatC.count{
            let viewS = DrawStat(frame: viewStatC[i].bounds, stat: Double(arrayStat[i]), colorS: po.type[0].changeC())
            viewStatC[i].addSubview(viewS)
        }
    }
    
    func setUpView(po: Pokemon1){
        
        imgMainC.image = UIImage(named: (po.id.change()))
        lblNameMainC.text = po.name.english
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.maxX*3, height: 200)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.colors = [po.type[0].changeC().withAlphaComponent(CGFloat(0.6)).cgColor, po.type[0].changeC().cgColor]
        viewImage.layer.addSublayer(gradient)

    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true)
    }
    func createStack(po: Pokemon1){
        let j = po.type.count
        let pointX = stackVMainC.frame.width/2 - CGFloat(50*j) - CGFloat(5*(j-1))
        for i in 0..<po.type.count{
            let lbl = UILabel()
            let img = UIImageView()
            lbl.frame = CGRect(x: Int(pointX)+120*i, y: 0, width: 110, height: 30)
            img.frame = CGRect(x: 2, y: 5, width: 20, height: 20)
            img.image = UIImage(named: po.type[i].lowercased())
            lbl.text = po.type[i]
            lbl.textColor = .white
            lbl.font = UIFont.boldSystemFont(ofSize: 18)
            lbl.layer.cornerRadius = 15
            lbl.layer.masksToBounds = true
            lbl.textAlignment = .center
            lbl.backgroundColor = po.type[i].changeC()
            lbl.addSubview(img)
            stackVMainC.addSubview(lbl)
        }
    }
}
