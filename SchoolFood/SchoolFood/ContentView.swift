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
                MenuView(memuImage: "specailmari", menuTitle: "스페셜마리", menuPrice: "7,500원")
                MenuView(memuImage: "bibimbap", menuTitle: "불맛 중화비빔밥", menuPrice: "8,500원")
                MenuView(memuImage: "jjolmyeon", menuTitle: "어간장 육감쫄면", menuPrice: "8,000원")
                MenuView(memuImage: "tteokbokki", menuTitle: "의성 마늘떡볶이", menuPrice: "9,000원")
                    .padding()
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

struct MenuView: View {
    var memuImage: String
    var menuTitle: String
    var menuPrice: String
//    var menuCount: String = "0개"
    @State var count = 0
    
    var body: some View {
        HStack {
            Image(memuImage)
                .resizable()
                .padding()
                .frame(width: 120.0, height: 120.0)
            VStack(alignment: .leading, spacing: 0.0) {
                Text(menuTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(menuPrice)
                    .fontWeight(.light)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
            }
            Stepper("\(count)개",value: $count)
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
        }
        .position(.init(x: 280, y: 0))
        .padding(.top)
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
