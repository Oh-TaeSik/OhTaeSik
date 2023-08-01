//
//  FoodSearchView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct FoodSearchView: View {
    let array = [
        "김서근", "포뇨", "하울", "소피아", "캐시퍼", "소스케",
        "치히로", "하쿠", "가오나시", "제니바", "카브", "마르클",
        "토토로", "사츠키", "지브리", "스튜디오", "캐릭터"
    ]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                FoodSearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                List {
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in
                        HStack {
                            Text(searchText)
                            Text(searchText)
                        }
                    }.padding(5)
                }
                .listStyle(PlainListStyle())
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationBarTitle("무엇을 드셨나요")
            .font(.system(size: 25, weight: .semibold))
                        
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSearchView()
    }
}
 
 
//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
