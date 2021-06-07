//
//  ContentView.swift
//  Calculator Assignment
//
//  Created by David Lascelles on 9/3/20.
//  Copyright © 2020 David Lascelles. All rights reserved.
//


import SwiftUI
let PADDING_SIZE = CGFloat(90)
let CIRCLE_SIZE = CGFloat(80)

let lightGray = Color(red: 165 / 255, green: 165 / 255, blue: 165 / 255)
let darkGray = Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255)

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

// Environment Object

class CalculatorEnvironment: ObservableObject {
    @Published var display = "0"
    let MAX_SIZE = 999999999
    let MIN_SIZE = 0.00000001
    var display_num = 0.0

    var intMode = true
    var canConcatinate = true
    
    var operation_queue = [String]()
    
    
    func buttonInput(calculatorButton: String){
        switch calculatorButton {
        case "clear":
            display_num = 0
            intMode = true
            operation_queue.removeAll()
            self.display = displayNumber()
        case "period":
            if canConcatinate == false {
                display_num = 0
                canConcatinate = true
            }
            self.display = displayNumber() + "."
            intMode = false
        case "sign":
            display_num = display_num * -1.0
            self.display = displayNumber()
        case "percent":
            operation_queue.append(displayNumber())
            operation_queue.append("multiply")
            operation_queue.append(String(100))
            calculateResult()
            self.display = displayNumber() + "%"
        case "divide":
            operation_queue.append(displayNumber())
            operation_queue.append(calculatorButton)
            canConcatinate = false
        case "multiply":
            operation_queue.append(displayNumber())
            operation_queue.append(calculatorButton)
            canConcatinate = false
        case "minus":
            operation_queue.append(displayNumber())
            operation_queue.append(calculatorButton)
            canConcatinate = false
        case "plus":
            operation_queue.append(displayNumber())
            operation_queue.append(calculatorButton)
            canConcatinate = false
        case "equal":
            if operation_queue.count == 2 {
                operation_queue.append(displayNumber())
                calculateResult()
                canConcatinate = false
            }
        default:
            numberConcatenator(num: Int(calculatorButton)!)
            canConcatinate = true
        }
    }
    
    func calculateResult() {
        let operandA = Double(operation_queue[0])!
        let operandB = Double(operation_queue[2])!
        
        if operation_queue[1] == "divide" && operandB == 0 {
            self.display = "Error"
        } else {
            display_num = operation(op: operation_queue[1], operandA: operandA, operandB: operandB)
            self.display = displayNumber()
        }
        for _ in 1...3 {
            operation_queue.remove(at: 0)
        }
    }
    
    func displayNumber() -> String {
        // If the number is an integer, display an integer
        
        if display_num.truncatingRemainder(dividingBy: 1) == 0 {
            if display_num.doubleCount() > 9 {
                return display_num.sciIntNotation()
            }
            return String(Int(display_num))
        }
        // Otherwise round to 8 decimal places
        display_num = round(100000000*display_num)/100000000
        return String(display_num)
    }
    
    func numberConcatenator(num: Int) {
        if display_num.doubleCount() >= 9 {
            canConcatinate = false
        }
        if canConcatinate == true {
            if intMode == true {
                if display_num > 0 {
                    display_num = display_num * 10 + Double(num)
                } else {
                    display_num = display_num * 10 + Double(num)
                }
                self.display = displayNumber()
            } else {
                var decimal_places = display_num.decimalCount()
                if display_num == 0 {
                    decimal_places = 1
                }
                if display_num >= 0 && decimal_places < 9 {
                    display_num = display_num + (Double(num) *
                                                    pow(0.1, Double(decimal_places)))
                } else if display_num < 0 && decimal_places < 9 {
                    display_num = display_num - (Double(num) *
                                                    pow(0.1, Double(decimal_places)))
                }
            }
            self.display = displayNumber()
        } else {
            display_num = Double(num)
            self.display = displayNumber()
            canConcatinate = true
        }
    }
    
    func operation(op: String, operandA: Double, operandB: Double) -> Double {
        var result: Double
        switch op {
        case "plus":
            result = operandA + operandB
        case "minus":
            result = operandA - operandB
        case "multiply":
            result = operandA * operandB
        case "divide":
            result = operandA / operandB
        default:
            result = 0
        }
        return result
    }
}

extension Double {
    func decimalCount() -> Int {
        if self == Double(Int(self)) {
            return 1
        }
        let integerCount = String(Int(self)).count
        return String(Double(self)).count - integerCount
    }
    func doubleCount() -> Int {
        let integerCount = String(Int(self)).count
        let decimalCount = String(Double(self)).count - integerCount
        return integerCount + decimalCount - 2
    }
    func sciIntNotation() -> String {
        let integerCount = String(Int(self)).count
        let num = self / pow(10.0, Double(integerCount - 1))
        let exp = Double(integerCount - 1)
        var exp_count = exp.doubleCount()
        if exp_count > 5 {
            exp_count = 5
        }
        let allowed_digits = 7 - exp_count
        let format_string = "%." + String(allowed_digits) + "f"

        return String(format: format_string, num) + "e" + String(Int(exp))
    }
}

struct ContentView: View {
    @EnvironmentObject var env: CalculatorEnvironment
    
    var body: some View {
        ZStack(){
            Color.black
                .ignoresSafeArea()
            VStack{
                VStack(alignment: .leading){
                    Spacer()
                    Text(env.display)
                        .font(.system(size: 100))
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                    .frame(width: UIScreen.screenWidth - (PADDING_SIZE - CIRCLE_SIZE) * 2, alignment: .trailing)
                
                HStack(spacing: 0) {
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "clear")
                        }){
                            Text("C")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(lightGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "sign")
                        }){
                            Image(systemName: "plus.slash.minus")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(lightGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "percent")
                        }){
                            Image(systemName: "percent")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(lightGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "divide")
                        }){
                            Image(systemName: "divide")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                }
                
                HStack(spacing: 0) {
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "7")
                        }){
                            Text("7")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "8")
                        }){
                            Text("8")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "9")
                        }){
                            Text("9")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "multiply")
                        }){
                            Image(systemName: "multiply")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                }
                
                HStack(spacing: 0) {
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "4")
                        }){
                            Text("4")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "5")
                        }){
                            Text("5")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "6")
                        }){
                            Text("6")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "minus")
                        }){
                            Image(systemName: "minus")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                }
                
                HStack(spacing: 0) {
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "1")
                        }){
                            Text("1")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "2")
                        }){
                            Text("2")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "3")
                        }){
                            Text("3")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "plus")
                        }){
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                }
                
                HStack(spacing: 0) {
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "0")
                        }){
                            Text("0")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE * 2 + (PADDING_SIZE - CIRCLE_SIZE), height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE * 2, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "period")
                        }){
                            Text(".")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(darkGray)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                    
                    VStack{
                        Button(action: {
                            self.env.buttonInput(calculatorButton: "equal")
                        }){
                            Image(systemName: "equal")
                                .font(.system(size: 30))
                                .frame(width: CIRCLE_SIZE, height: CIRCLE_SIZE)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    }.frame(width: PADDING_SIZE, height: PADDING_SIZE)
                }
                    .padding(.bottom, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CalculatorEnvironment())
    }
}
