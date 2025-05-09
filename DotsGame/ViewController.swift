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
    
    @IBOutlet weak var turnlabel: UILabel!
    
    var redTurn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewArray()
        updatePlayer()
        // Do any additional setup after loading the view.
    }
    var views: [[gameSegment]] = [[]]

    func buildViewArray() {
        
        var buttonCounter: Int = 0
        var iRow: Int = 0
        var iColumn: Int = 0
        views = Array(repeating: Array(repeating: gameSegment(), count: 6), count: 7)
        iRow = 0
        // add all buttons to the array
        for case let horizontalStackView as UIStackView in verticalStack.arrangedSubviews {
            iColumn = 0
            for case let currentView as UIView in horizontalStackView.arrangedSubviews {
                views[iRow][iColumn].body = currentView
                views[iRow][iColumn].body.backgroundColor = UIColor.lightGray
                
                for subview in views[iRow][iColumn].body.subviews {
                    if subview is UIButton {
                        buttonCounter += 1
                        if buttonCounter == 1 {
                            views[iRow][iColumn].leftButton = subview as! UIButton
                            views[iRow][iColumn].leftButton.addTarget(self, action: "leftButtonPressed:", for: .touchUpInside)
                            views[iRow][iColumn].leftButton.configuration?.background.backgroundColor = UIColor.white
                        } else if buttonCounter == 2 {
                            views[iRow][iColumn].rightButton = subview as! UIButton
                            views[iRow][iColumn].rightButton.addTarget(self, action: "rightButtonPressed:", for: .touchUpInside)
                            views[iRow][iColumn].rightButton.configuration?.background.backgroundColor = UIColor.white
                        } else if buttonCounter == 3 {
                            views[iRow][iColumn].topButton = subview as! UIButton
                            views[iRow][iColumn].topButton.addTarget(self, action: "topButtonPressed:", for: .touchUpInside)
                            views[iRow][iColumn].topButton.configuration?.background.backgroundColor = UIColor.white
                        } else if buttonCounter == 4 {
                            views[iRow][iColumn].bottomButton = subview as! UIButton
                            views[iRow][iColumn].bottomButton.addTarget(self, action: "bottomButtonPressed:", for: .touchUpInside)
                            views[iRow][iColumn].bottomButton.configuration?.background.backgroundColor = UIColor.white
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
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        
        var madeABox: Bool = false
        print("left")
        let location = identifyButton(sender)
        print(location.row, location.column)
        
        views[location.row][location.column].leftButton.configuration?.background.backgroundColor = UIColor.black
        views[location.row][location.column].leftButton.isEnabled = false

        
        if location.column > 0 {
            views[location.row][location.column - 1].rightButton.configuration?.background.backgroundColor = UIColor.black
            views[location.row][location.column - 1].rightButton.isEnabled = false
        }
        
        if checkForBox (views[location.row][location.column]) {
            print("Made a box")
            madeABox = true
            if redTurn {
                views[location.row][location.column].body.backgroundColor = UIColor.red
            } else {
                views[location.row][location.column].body.backgroundColor = UIColor.blue
            }
            
        }
        
        if location.column > 0 && checkForBox(views[location.row][location.column - 1]) {
            madeABox = true
            if redTurn {
                views[location.row][location.column - 1].body.backgroundColor = UIColor.red
            } else {
                views[location.row][location.column - 1].body.backgroundColor = UIColor.blue
            }
        } 
        
        if !madeABox {
            redTurn = !redTurn
            updatePlayer()
        } else {
            if !checkForWinner() {
                updatePlayer()
            }
        }
        
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        print("right")
        var madeABox: Bool = false
        
        let location = identifyButton(sender)
        print(location.row, location.column)
        
        views[location.row][location.column].rightButton.configuration?.background.backgroundColor = UIColor.black
        views[location.row][location.column].rightButton.isEnabled = false
        
        if location.column < views[location.row].count - 1 {
            views[location.row][location.column + 1].leftButton.configuration?.background.backgroundColor = UIColor.black
            views[location.row][location.column + 1].leftButton.isEnabled = false
        }
        
        if checkForBox (views[location.row][location.column]) {
            print("Made a box")
            madeABox = true
            if redTurn {
                views[location.row][location.column].body.backgroundColor = UIColor.red
            } else {
                views[location.row][location.column].body.backgroundColor = UIColor.blue
            }
        }
        if location.column < views[location.row].count - 1 && checkForBox(views[location.row][location.column + 1]) {
            madeABox = true
            if redTurn {
                views[location.row][location.column + 1].body.backgroundColor = UIColor.red
            } else {
                views[location.row][location.column + 1].body.backgroundColor = UIColor.blue
            }
        }
        
        if !madeABox {
            redTurn = !redTurn
            updatePlayer()
        } else {
            if !checkForWinner() {
                updatePlayer()
            }
        }
    }
    @IBAction func topButtonPressed(_ sender: UIButton) {
        print("top")
        var madeABox: Bool = false
        let location = identifyButton(sender)
        print(location.row, location.column)
        
        views[location.row][location.column].topButton.configuration?.background.backgroundColor = UIColor.black
        views[location.row][location.column].topButton.isEnabled = false
        
        
        if location.row > 0 {
            views[location.row - 1][location.column].bottomButton.configuration?.background.backgroundColor = UIColor.black
            views[location.row - 1][location.column].bottomButton.isEnabled = false
        }
        
        if checkForBox (views[location.row][location.column]) {
            print("Made a box")
            madeABox = true
            if redTurn {
                views[location.row][location.column].body.backgroundColor = UIColor.red
            } else {
                views[location.row][location.column].body.backgroundColor = UIColor.blue
            }
        }
        
        if location.row > 0 && checkForBox(views[location.row - 1][location.column]) {
            madeABox = true
            if redTurn {
                views[location.row - 1][location.column].body.backgroundColor = UIColor.red
            } else {
                views[location.row - 1][location.column].body.backgroundColor = UIColor.blue
            }
        }
        
        if !madeABox {
            redTurn = !redTurn
            updatePlayer()
        } else {
            if !checkForWinner() {
                updatePlayer()
            }
        }
        
    }
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        print("bottom")
        var madeABox: Bool = false
        let location = identifyButton(sender)
        print(location.row, location.column)
        
        views[location.row][location.column].bottomButton.configuration?.background.backgroundColor = UIColor.black
        views[location.row][location.column].bottomButton.isEnabled = false
        
        if location.row < views.count - 1 {
            views[location.row + 1][location.column].topButton.configuration?.background.backgroundColor = UIColor.black
            views[location.row + 1][location.column].topButton.isEnabled = false
        }
        
        if checkForBox (views[location.row][location.column]) {
            print("Made a box")
            madeABox = true
            if redTurn {
                views[location.row][location.column].body.backgroundColor = UIColor.red
            } else {
                views[location.row][location.column].body.backgroundColor = UIColor.blue
            }
        }
        if location.row < views.count - 1 && checkForBox(views[location.row + 1][location.column]) {
            madeABox = true
            if redTurn {
                views[location.row + 1][location.column].body.backgroundColor = UIColor.red
            } else {
                views[location.row + 1][location.column].body.backgroundColor = UIColor.blue
            }
        }
        if !madeABox {
            redTurn = !redTurn
            updatePlayer()
        } else {
            if !checkForWinner() {
                updatePlayer()
            }
        }
    }
    
    func identifyButton(_ button: UIButton) -> (row: Int, column: Int) {
        
       for i in 0...views.count - 1 {
            for j in 0...views[i].count - 1 {
                if button == views[i][j].leftButton || button == views[i][j].rightButton || button == views[i][j].topButton || button == views[i][j].bottomButton{
                    return (row: i, column: j)
                }
            }
        }
        return (row: 100, column: 100)
    }
    
    func checkForBox(_ currentBox: gameSegment) -> Bool {
        if currentBox.bottomButton.configuration?.background.backgroundColor == currentBox.topButton.configuration?.background.backgroundColor && currentBox.bottomButton.configuration?.background.backgroundColor == currentBox.leftButton.configuration?.background.backgroundColor && currentBox.bottomButton.configuration?.background.backgroundColor == currentBox.rightButton.configuration?.background.backgroundColor {
                return true
        } else {
            return false
        }
    }
    
    func updatePlayer() {
        if redTurn {
            turnlabel.text = "Red turn"
        } else {
            turnlabel.text = "Blue turn"
        }
    }
    
    func checkForWinner() -> Bool {
        var redCount: Int = 0
        var blueCount: Int = 0
        for row in views {
            for view in row {
                if view.body.backgroundColor == UIColor.lightGray {
                    return false
                } else if view.body.backgroundColor == UIColor.blue {
                    blueCount += 1
                } else if view.body.backgroundColor == UIColor.red {
                    redCount += 1
                }
            }
        }
        if redCount > blueCount {
            turnlabel.text = "Red wins!"
        } else {
            turnlabel.text = "Blue wins!"
        }
        return true
    }
}

