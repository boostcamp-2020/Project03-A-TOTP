//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = TokenListViewModel()
    @State var searchText: String = ""
    
    init() {
        viewModel.fetchTokens()
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                
                Button(action: {
                    // 내 정보 페이지 띄우는 곳
                }, label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                        .padding(.leading, 4)
                    
                })
                
                Spacer()
                
                Button(action: {
                    // Edit Mode로 전환
                }, label: {
                    Text("선택")
                        .padding(.trailing, 4)
                        .foregroundColor(.black)
                })
                  
            }
            // 나아아중에 searchbar view 로 바꿔야함.
            TextField("Search", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            MainCellView()
            ScrollView {
                TokenListView(tokens: $viewModel.tokens)
            }
        }
        .padding([.top, .leading, .trailing])
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
