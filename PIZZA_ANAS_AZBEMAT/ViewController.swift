//
//  ViewController.swift
//  PIZZA_ANAS_AZBEMAT
//
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
        
    // MARK: DataSource
    
    var theOriginalPizza = Pizza(name: "The Original", description: "Pepperoni, cheese, green onions. Served with extra tomato sauce and three types of cheese.", sizeWithPrice: baseSizeWithPrice)
    
    var spicyPulledPorkPizza = Pizza(name: "Spicy Pulled Pork Pizza ", description: "Slow-roasted pulled pork with a special spicy and smoky BBQ pizza sauce.", sizeWithPrice: baseSizeWithPrice)

    var vegetarianFiestaPizza = Pizza(name: "Vegetarian Fiesta Pizza ", description: "Roasted red peppers, caramelized onions, sundried organic tomatoes, feta, and spinach, on a thin crust with pesto sauce.", sizeWithPrice: baseSizeWithPrice)

    var pizzaMenu = [Pizza]()
    
    
    // MARK: variables to store selected pizza
    
    // with default values
    var selectedPizzaIndex:Int = 0
    var selectedSize:String = "Medium"
    var selectedQuantity:Int = 1
    
    
    // MARK: Outlets
    
    @IBOutlet weak var pizzaPickerView: UIPickerView!
    @IBOutlet weak var txtVwDescription: UITextView!
    @IBOutlet weak var segmentPizzaSize: UISegmentedControl!
    @IBOutlet weak var lblPizzaQuantity: UILabel!
    @IBOutlet weak var stepperPizzaQuanity: UIStepper!
    
    // MARK: PickerView Func
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pizzaMenu.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pizzaMenu[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtVwDescription.text = "\(pizzaMenu[row].description)"
        
        // store the selected pizza info
        selectedPizzaIndex = row
    }
    
    // MARK: Actions
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        // store the selected pizza size
        switch(segmentPizzaSize.selectedSegmentIndex){
        case 0:
            selectedSize = "Small"
            break
        case 1:
            selectedSize = "Medium"
            break
        case 2:
            selectedSize = "Large"
            break
        default:
            selectedSize = "Medium"
            break
        }
    
    }
    
    @IBAction func stepperChanged(_ sender: Any) {
        let quantityWithoutDecimal = String(format: "%.0f", stepperPizzaQuanity.value)
        
        // update UI text - quantity
        lblPizzaQuantity.text = String(quantityWithoutDecimal)
        
        // store the selected pizza quantity
        selectedQuantity = Int(lblPizzaQuantity.text!)!
    }
    
    @IBAction func startOverPressed(_ sender: Any) {
        
        // reset the data
        
        selectedPizzaIndex = 0
        selectedSize = "Medium"
        selectedQuantity = 1
        
        // reset the UI
        
        pizzaPickerView.selectRow(0, inComponent: 0, animated: true)   // Original -> [0]
        txtVwDescription.text = pizzaMenu[0].description
        
        segmentPizzaSize.selectedSegmentIndex = 1    // Medium - > [1]
        
        lblPizzaQuantity.text = String("1")
        stepperPizzaQuanity.value = 1.0
        
    }
    
    @IBAction func placeOrderBtnPressed(_ sender: Any) {
        
        // Display an alert box
        
        let box = UIAlertController(title: "Are you sure you are ready to place this order?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        box.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        box.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            // get screen 2 (Receipt)
            
            guard let screen2 = self.storyboard?.instantiateViewController(identifier: "screen2Receipt") as? Screen2ViewController else {
                        print("Cannot find a screen with an id of screen2Receipt")
                        return
            }
            
            // send data to screen 2 (Receipt)
            
            screen2.size = self.selectedSize
            screen2.quantity = self.selectedQuantity
            switch(self.selectedPizzaIndex){
            case 0:
                screen2.pizza = self.theOriginalPizza
                break
            case 1:
                screen2.pizza = self.spicyPulledPorkPizza
                break
            case 2:
                screen2.pizza = self.vegetarianFiestaPizza
                break
            default:
                screen2.pizza = self.theOriginalPizza
                break
                
            }
            
            // navigate to screen 2 (Receipt)
            
            self.show(screen2, sender: self)
        }))

        self.present(box, animated: true)
        
    }
    
    // MARK: viewDIdLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create the pizza menu
        
        pizzaMenu.append(theOriginalPizza);
        pizzaMenu.append(spicyPulledPorkPizza);
        pizzaMenu.append(vegetarianFiestaPizza);
        
        self.pizzaPickerView.delegate = self
        self.pizzaPickerView.dataSource = self

        
    }
    
}

