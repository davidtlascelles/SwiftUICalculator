//
//  ContentView.swift
//  Calculator Assignment
//
//  Created by David Lascelles on 9/3/20.
//  Copyright © 2020 David Lascelles. All rights reserved.
//


import SwiftUI
let SIZE = CGFloat(75)

struct ContentView: View {
    var body: some View {
        VStack() {
            HStack(spacing: 0) {
                VStack{
                    Button(action: {
                        print("Clear pressed")
                    }){
                        Text("C")
                        .font(.system(size: 30))
                        .frame(width: 75, height: 75)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(Circle())
                    }.buttonStyle(PlainButtonStyle())
                }.frame(width: SIZE, height: SIZE)

                VStack{
                    Button(action: {
                        print("Sign Change Pressed")
                    }){
                        Image(systemName: "plus.slash.minus")
                        .font(.system(size: 30))
                        .frame(width: 75, height: 75)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(Circle())
                    }.buttonStyle(PlainButtonStyle())
                }.frame(width: SIZE, height: SIZE)
                
                VStack{
                    Button(action: {
                        print("Percent Pressed")
                    }){
                        Image(systemName: "percent")
                        .font(.system(size: 30))
                        .frame(width: 75, height: 75)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(Circle())
                    }.buttonStyle(PlainButtonStyle())
                }.frame(width: SIZE, height: SIZE)
                
                VStack{
                    Button(action: {
                        print("Divide Pressed")
                    }){
                        Image(systemName: "divide")
                        .font(.system(size: 30))
                        .frame(width: 75, height: 75)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                        .clipShape(Circle())
                    }.buttonStyle(PlainButtonStyle())
                }.frame(width: SIZE, height: SIZE)
            }

            HStack() {
                Button(action: {
                    print("7 pressed")
                }) {
                    Text("7")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("8 pressed")
                }) {
                    Text("8")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("9 pressed")
                }) {
                    Text("9")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("Multiply pressed")
                }) {
                    Image(systemName: "multiply")
                        .imageScale(.large)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
            }
            
            HStack() {
                Button(action: {
                    print("4 pressed")
                }) {
                    Text("4")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("5 pressed")
                }) {
                    Text("5")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("6 pressed")
                }) {
                    Text("6")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("Minus pressed")
                }) {
                    Image(systemName: "minus")
                        .imageScale(.large)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
            }
            
            HStack() {
                Button(action: {
                    print("1 pressed")
                }) {
                    Text("1")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("2 pressed")
                }) {
                    Text("2")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("3 pressed")
                }) {
                    Text("3")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
                
                Button(action: {
                    print("Plus pressed")
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
            }
            
            HStack() {
                Button(action: {
                    print("0 pressed")
                }) {
                    Text("0                       ")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .frame(width: 106, height: 53, alignment: .center)
                        .cornerRadius(40)
                }
                .frame(width: 114.0, height: 53.0)
                
                Button(action: {
                    print("Period pressed")
                }) {
                    Text(".")
                        .font(.headline)
                        .imageScale(.large)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(Circle().size(CGSize(width: 50, height: 50)))
                }
                .frame(width: 53.0, height: 53.0, alignment: .center)
                
                Button(action: {
                    print("Equals pressed")
                }) {
                    Image(systemName: "equal")
                        .imageScale(.large)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 53.0, height: 53.0)
            }

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
