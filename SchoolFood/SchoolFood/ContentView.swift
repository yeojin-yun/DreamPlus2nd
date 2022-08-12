//
//  ContentView.swift
//  SchoolFood
//
//  Created by 순진이 on 2022/08/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                MenuView(memuImage: "specailmari", menuTitle: "스페셜마리", menuPrice: "7,500")
                    .navigationTitle("School Food")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                print("충전")
                            } label: {
                                Text("충전")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print("결제")
                            } label: {
                                Text("결제")
                            }
                            
                        }
                    }
                
            }
        }
    }
}

struct MenuView: View {
    var memuImage: String
    var menuTitle: String
    var menuPrice: String
    
    var body: some View {
        HStack {
            Image(memuImage)
            VStack {
                Text(menuTitle)
                Text(menuPrice)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
