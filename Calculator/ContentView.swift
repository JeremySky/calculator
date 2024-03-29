//
//  ContentView.swift
//  Calculator
//
//  Created by Jeremy Manlangit on 5/19/23.
//

import SwiftUI

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
    case multiply = "x"
    case divide = "/"
    case equal = "="
    case decimal = "."
    case clear = "ac"
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}
 
enum Calculation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Calculation = .none
    
    let buttons: [[CalcButton]] = [
        
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
         
    ]
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                //Text
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100 ))
                        .foregroundColor(.white)
                }
                .padding( )
                //Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }) {
                                Text(item.rawValue )
                                    .font(.system(size: 42))
                                    .frame(width: self.buttonWidth(item: item ), height: self.buttonHeight(item: item) )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                currentOperation = .add
                runningNumber += Int(self.value) ?? 0
            } else if button == .subtract {
                currentOperation = .subtract
                runningNumber += Int(self.value) ?? 0
            } else if button == .multiply {
                currentOperation = .multiply
                runningNumber += Int(self.value) ?? 0
            } else if button == .divide {
                currentOperation = .divide
                runningNumber += Int(self.value) ?? 0
            } else if button == .equal {
                let runningValue = runningNumber
                let currentValue = Int(value) ?? 0
                
                switch currentOperation {
                case .add: value = "\(runningValue + currentValue)"
                case .subtract: value = "\(runningValue - currentValue)"
                case .multiply: value = "\(runningValue * currentValue)"
                case .divide: value = "\(runningValue / currentValue)"
                case .none: break
                }
                
                runningNumber = 0
            }
            if button != .equal {
                value = "0"
            }
                
        case .clear:
            value = "0"
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
    
    func buttonHeight(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
