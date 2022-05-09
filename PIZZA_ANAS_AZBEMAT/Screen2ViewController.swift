//
//  Screen2ViewController.swift
//  PIZZA_ANAS_AZBEMAT
//
//

import UIKit

class Screen2ViewController: UIViewController {

    // Receiving variable with default values [from screen1]
    
    var size:String = ""
    var quantity:Int = 0
    var pizza:Pizza = Pizza(name: "N/A", description: "N/A", sizeWithPrice: [:])
    var subTotal:Double = 0.0
    var tax:Double = 0.0
    var total:Double = 0.0
    
    
    // Outlets
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Update UI text
        lblName.text = pizza.name
        lblSize.text = size
        lblQuantity.text = String(quantity)
        
        // calculate subtotal
        subTotal = Double(quantity) * pizza.sizeWithPrice[size]!
        lblSubtotal.text = String(subTotal)
        
        // calculate the tax amount
        tax = subTotal * 0.13
        lblTax.text = String(tax)
        
        // calculate total
        total = subTotal - tax
        lblTotal.text = String(total)
        
    }

}
