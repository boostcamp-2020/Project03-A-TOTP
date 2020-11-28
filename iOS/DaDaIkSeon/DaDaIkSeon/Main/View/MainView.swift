//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainState {
    var service: MainServiceable
    var filteredTokens: [Token]
}

enum MainInput {
    case search(_ text: String)
}

struct MainView: View {
    
    // MARK: Property
    
    @ObservedObject var viewModel: AnyViewModel<MainState, MainInput>
    @State var isShowing = false
    @State var searchText = ""
    @State var isSearching = false
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    // MARK: Initialization
    
    init(service: MainServiceable) {
        viewModel = AnyViewModel(MainViewModel(service: service))
    }
    
    // MARK: Body
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 12) {
                
                isSearching ? nil : HeaderView()
                
                HStack {
                    TextField("검색", text: $searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)

                                if isSearching {
                                    // X버튼
                                    Button(action: {
                                        searchText = ""
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    })
                                }
                            }
                        )
                        .onChange(of: searchText) { _ in
                            changeText(text: searchText)
                        }
                        .padding(.horizontal, 12)
                        .onTapGesture {
                            isSearching = true
                        }

                    if isSearching {
                        // 취소 버튼
                        Button(action: {
                            isSearching = false
                            searchText = ""
                            hideKeyboard()
                        }, label: {
                            Text("취소")
                                .foregroundColor(.black)
                        })
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                    }
                }
                
                isSearching ? nil : MainCellView()
                    .padding(.bottom, -6)
                
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 12) {
                        ForEach(viewModel.state.filteredTokens) { token in
                            TokenCellView(viewModel: TokenViewModel(token: token))
                        }
                        isSearching ? nil : NavigationLink(
                            destination: QRGuideView(),
                            label: {
                                TokenAddCellView()
                            })
                            .frame(minHeight: 100)
                    }
                    .padding([.leading, .trailing, .bottom], 12)
                    .padding(.top, 6)
                }
                .navigationBarHidden(true)
            }
            
        }
    }
}

private extension MainView {
    func changeText(text: String) {
        viewModel.trigger(.search(text))
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        let service = MainService()
        MainView(service: service)
    }

}
