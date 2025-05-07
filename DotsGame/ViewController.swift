//
//  ViewController.swift
//  DotsGame
//
//  Created by Krause, Matthew on 5/2/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var templateView: UIView!
    
    @IBOutlet weak var verticalStack: UIStackView!
    
    @IBOutlet weak var templateLeftButton: UIButton!
    
    @IBOutlet weak var templateRightButton: UIButton!
    
    @IBOutlet weak var templateTopButton: UIButton!
    
    @IBOutlet weak var templateBottomButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewArray()
        // Do any additional setup after loading the view.
    }
    var views: [[gameSegment]] = [[]]

    func buildViewArray() {
        
        var buttonCounter: Int = 0
        var iRow: Int = 0
        var iColumn: Int = 0
        views = Array(repeating: Array(repeating: gameSegment(), count: 5), count: 5)
        iRow = 0
        // add all buttons to the array
        for case let horizontalStackView as UIStackView in verticalStack.arrangedSubviews {
            iColumn = 0
            for case let currentView as UIView in horizontalStackView.arrangedSubviews {
                views[iRow][iColumn].body = currentView
                
                
                for subview in views[iRow][iColumn].body.subviews {
                    if subview is UIButton {
                        buttonCounter += 1
                        if buttonCounter == 1 {
                            views[iRow][iColumn].leftButton = subview as! UIButton
                            views[iRow][iColumn].leftButton.configuration?.background.backgroundColor = UIColor.blue
                        } else if buttonCounter == 2 {
                            views[iRow][iColumn].rightButton = subview as! UIButton
                            views[iRow][iColumn].rightButton.configuration?.background.backgroundColor = UIColor.red
                        } else if buttonCounter == 3 {
                            views[iRow][iColumn].topButton = subview as! UIButton
                            views[iRow][iColumn].topButton.configuration?.background.backgroundColor = UIColor.green
                        } else if buttonCounter == 4 {
                            views[iRow][iColumn].bottomButton = subview as! UIButton
                            views[iRow][iColumn].bottomButton.configuration?.background.backgroundColor = UIColor.magenta
                        } else {
                            print("Something went wrong")
                        }
                        print("Found a button!")
                    } else {
                        print("Found something else")
                    }
                }
                
                iColumn += 1
                print("Next view!")
                buttonCounter = 0
                
            }
            iRow += 1
        }
        
        print("Got the views!")
        // add buttonPressed action to all buttons
        

    }
}

