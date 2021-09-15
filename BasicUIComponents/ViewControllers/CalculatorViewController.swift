//
//  CalculatorViewController.swift
//  BasicUIComponents
//
//  Created by Semih Emre ÜNLÜ on 11.09.2021.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var screenNumber : Double = 0
    var previousNumber : Double = 0
    var mathOperation=false
    var operation=0
    
    //@IBOutlet var digitButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private var isTyping: Bool = false
    
    @IBAction func digitButtonTapped(_ sender: UIButton) {
        let digit = String(sender.tag)
        let displayText = resultLabel.text ?? ""
        
        if isTyping {
            if mathOperation {
                resultLabel.text = digit
                mathOperation = false
            }
            else {
                resultLabel.text = displayText + digit
            }
            
        } else {
            resultLabel.text = digit
            isTyping.toggle()
        }
        screenNumber = Double(resultLabel.text!)!
    }
    
    class OperationCalculation {
        let opr :Int
        let previousNum, numberOnScr: Double
            
        init(opr:Int, previousNum : Double, numberOnScr : Double) {
            self.opr = opr
            self.previousNum = previousNum
            self.numberOnScr = numberOnScr
        }
        
        func makeCalculation() ->String{
            switch opr {
            case 11:
                return String(previousNum * numberOnScr)
            case 12:
                return String(previousNum - numberOnScr)
            case 13:
                return String(previousNum + numberOnScr)
            case 14:
                return String(previousNum / numberOnScr)
            default:
                return ""
            }
        }
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
                
        let digit = sender.tag
        let value = NSString(string: resultLabel.text ?? "0").doubleValue
        
        if resultLabel.text != "" && sender.tag != 15 && sender.tag != 16 {

            previousNumber = value
            
            switch digit {
            case 10:
                resultLabel.text = String(sqrt(value))
            case 11:
                resultLabel.text = "x";
            case 12:
                resultLabel.text = "-";
            case 13:
                resultLabel.text = "+";
            case 14:
                resultLabel.text = "/";
            default:
                break
            }
            
           operation = sender.tag

           mathOperation = true;
        }
        else if sender.tag == 15{
        
            let operationCalculation = OperationCalculation(opr:operation, previousNum : previousNumber, numberOnScr : screenNumber)
            
            resultLabel.text = operationCalculation.makeCalculation()
            
        } else if sender.tag == 16{

            resultLabel.text = "0"
            previousNumber = 0;
            screenNumber = 0;
            operation = 0;
            isTyping.toggle()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
