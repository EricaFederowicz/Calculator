//
//  ContentView.swift
//  Calculator
//
//  Created by Erica Federowicz on 21/02/24.
//

import SwiftUI

// an enum defines a common type for a group of related values.
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    // defines the color of each set of buttons
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            // Colors on the format #E6A4B4 are used that way.
            return Color(red: 0xE6 / 255, green: 0xA4 / 255, blue: 0xB4 / 255)
        case .clear, .negative, .percent:
            //C7DCA7
            return Color(red: 0xC7 / 255, green: 0xDC / 255, blue: 0xA7 / 255)
        default:
            //F6D6E3
            return Color(red: 0xF6 / 255, green: 0xD6 / 255, blue: 0xE3 / 255)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    // the @State configures a variable that can be changed during execution
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    // array of the buttons
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            //F3EEEA. Defines the color of the screen and ignores the safe borders
            Color(red: 0xF3 / 255, green: 0xEE / 255, blue: 0xEA / 255).ignoresSafeArea(.all)
            
            VStack {
                // the Spacer() adds a space on the screen, in this case, pushing things bellow.
                Spacer()
                // Text display area.
                HStack {
                    Spacer()
                    Text(value)
                        .foregroundColor(Color.gray)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Buttons area
                // this loop iterates over the rows of the array of buttons
                ForEach(buttons, id: \.self) {row in
                    // the HStack creates a horizontal stack of buttons within each row, spacing 12 points between each button.
                    HStack(spacing: 12) {
                        // this loop iterates over each button on the current row
                        ForEach(row, id: \.self) {item in Button(action: {
                            self.didTap(button: item)
                        }, label: {
                            // the Text(item.rawValue) displays the string representation of the button (item).
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight())
                            // the .background sets the color using what we specified before.
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonWidth(item: item)/2)
                        })
                        }
                    }
                    // used for a little space between the buttons.
                    .padding(.bottom, 3)
                }
            }
        }
    }
    // function to specify the action in case a button is pressed.
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}


#Preview {
    ContentView()
}
