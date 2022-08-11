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
                Text("school food")
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
                MenuView()
            }
        }
    }
}

struct MenuView: View {
    var body: some View {
        HStack {
            Image(systemName: "specailmari")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
