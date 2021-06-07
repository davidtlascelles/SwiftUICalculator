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
    var operand = 0.0
    var operand2 = 0.0
    var concatenationMode = true
    var canConcatinate = true
    
    
    func buttonInput(calculatorButton: String){
        switch calculatorButton {
        case "clear":
            operand = 0
            concatenationMode = true
            self.display = displayNumber()
        case "sign":
            operand *= -1
            self.display = displayNumber()
        case "percent":
            operand *= 100
            self.display = displayNumber() + "%"
        case "divide":
            operation(op: calculatorButton)
        case "multiply":
            operation(op: calculatorButton)
        case "minus":
            operation(op: calculatorButton)
        case "plus":
            operation(op: calculatorButton)
        case "period":
            self.display = displayNumber() + "."
            concatenationMode = false
        case "equal":
            operation(op: calculatorButton)
        default:
            operation(op: calculatorButton)
            numberConcatenator(num: Int(calculatorButton)!)
        }
    }
    
    func displayNumber() -> String {
        if concatenationMode == true {
            let val = Int(display_num)
            return String(val)
        }
        return String(display_num)
    }
    
    func numberConcatenator(num: Int) {
        if canConcatinate == true {
            if concatenationMode == true {
                if display_num > 0 {
                    display_num = display_num * 10 + Double(num)
                } else {
                    display_num = display_num * 10 + Double(num)
                }
                self.display = displayNumber()
            } else {
                if display_num > 0 {
                    display_num = display_num + Double(num) * 0.1
                } else {
                    display_num = display_num - Double(num) * 0.1
                }
                self.display = displayNumber()
            }
        } else {
            display_num = Double(num)
            self.display = displayNumber()
            canConcatinate = true
        }
    }
    func operation(op: String) {
            switch op {
            case "plus":
                display_num = operand + operand2
            case "minus":
                display_num = operand2 - operand
            case "multiply":
                display_num = operand2 * operand
            case "divide":
                display_num = operand2 / operand
            default:
                display_num = 0.0
                concatenationMode = true
                canConcatinate = false
            }
            self.display = displayNumber()
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
