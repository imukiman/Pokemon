//
//  DrawStat.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/14/22.
//

import UIKit
class DrawStat: UIView{
    var stat: Double = 0
    var colorS: UIColor = .clear
    var dem : Double = 0{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.06) {
                self.draw1()
            }
        }
    }
    init(frame: CGRect, stat: Double, colorS: UIColor) {
        super.init(frame: frame)
        self.stat = stat
        self.colorS = colorS
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.draw1()
        }
    }
    func draw1(){
        self.layer.sublayers = nil
        let long : Double = dem/150 >= 1 ? Double(self.frame.width) : dem/150 * Double(self.frame.width)

        let shapeLayer1 = CAShapeLayer()
        let gradien = CAGradientLayer()
        gradien.frame = self.bounds
        gradien.colors = [colorS.withAlphaComponent(CGFloat(0.4)).cgColor, colorS.cgColor]
        gradien.startPoint = CGPoint(x: 0, y: 0)
        gradien.endPoint = CGPoint(x: 1, y: 0)
        
        let path1 = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: CGFloat(long), height: self.frame.height), cornerRadius: self.frame.height/2)
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        gradien.mask = shapeLayer1
        
        self.layer.addSublayer(gradien)
        
        if dem < stat{
            if dem + 5 >= stat{
                dem = stat
            }
            else{
                dem += 5
            }
        }
    }
}
extension Double{
    func changeC() -> CGColor{
        if self <= 60{
            return #colorLiteral(red: 1, green: 0.3789357543, blue: 0.3493673205, alpha: 1).cgColor
        }
        else{
            if self >= 120{
                return #colorLiteral(red: 0.1648741961, green: 0.7939251065, blue: 0.2529242337, alpha: 1).cgColor
            }
            else{
                return #colorLiteral(red: 0.9986867309, green: 0.7574073672, blue: 0.1866791546, alpha: 1).cgColor
            }
        }
    }
}
