//
//  ContentView.swift
//  SchoolFood
//
//  Created by 순진이 on 2022/08/11.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var moneyToPay: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    MenuView(memuImage: "specailmari", menuTitle: "스페셜마리", menuPrice: "7,500원")
                    MenuView(memuImage: "bibimbap", menuTitle: "불맛 중화비빔밥", menuPrice: "8,500원")
                    MenuView(memuImage: "jjolmyeon", menuTitle: "어간장 육감쫄면", menuPrice: "8,000원")
                    MenuView(memuImage: "tteokbokki", menuTitle: "의성 마늘떡볶이", menuPrice: "9,000원")
                        
                }.padding(.trailing)
                OrderVeiw()
                Button("초기화") {
                    print("버튼이 눌림")
                }
                .padding(.top)
            }
            
            .navigationTitle("School Food")

            .toolbar {
            
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("충전")
                        showAlert.toggle()
                    } label: {
                        Text("충전")
                    }
                    .alert("지갑 충전", isPresented: $showAlert) {
                        TextField("충전할 금액을 입력하세요", text: $moneyToPay)
                        Button("충전") {}
                    } message: {
                        Text("얼마를 충전할까요?")
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

struct MenuView: View {
    
    var memuImage: String
    var menuTitle: String
    @State var menuPrice: String

    
    @State var count = 0
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(memuImage)
                .resizable()
                .padding()
                .frame(width: 110.0, height: 110.0)
            VStack(alignment: .leading, spacing: 0.0) {
                Text(menuTitle)
                    
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                Text(String(menuPrice))
                    
                    .fontWeight(.light)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
            }.background(.yellow)
            .position(x: 40, y: 10)
            Stepper("\(count)개", value: $count, in: 0...100, onEditingChanged: {_ in
                print(count)
            })
                .padding(.leading, -6.0)
                .fixedSize()
        }
    }
    
    
}

struct OrderVeiw: View {
    var myMoney: String = "0원"
    var payMoney: String = "0원"
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("내 지갑:")
                Text(myMoney)
            }
            HStack {
                Text("최종 결제금액:")
                Text(payMoney)
            }
            .padding(.top)
            
        }
        .position(x: 280, y: 0)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
