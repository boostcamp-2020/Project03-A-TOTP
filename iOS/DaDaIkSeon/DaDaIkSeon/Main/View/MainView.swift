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
    var searchText: String
    var isSearching: Bool
}

enum MainInput {
    case startSearch(_ text: String)
    case endSearch
}

struct MainView: View {
    
    // MARK: Property
    
    @ObservedObject var viewModel: AnyViewModel<MainState, MainInput>
    @State var searchText = ""
    
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
                
                viewModel.state.isSearching ? nil : HeaderView()
                
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

                                if viewModel.state.isSearching {
                                    // X버튼
                                    Button(action: {
                                        viewModel.trigger(.endSearch)
                                        searchText = viewModel.state.searchText
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    })
                                }
                            }
                        )
                        .onChange(of: searchText) { _ in
                            viewModel.trigger(.startSearch(searchText))
                        }
                        .padding(.horizontal, 12)
                        .onTapGesture {
                            viewModel.trigger(.startSearch(searchText))
                        }

                    if viewModel.state.isSearching {
                        // 취소 버튼
                        Button(action: {
                            viewModel.trigger(.endSearch)
                            searchText = viewModel.state.searchText
                            hideKeyboard()
                        }, label: {
                            Text("취소")
                                .foregroundColor(.black)
                        })
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                    }
                }
                
                viewModel.state.isSearching ? nil : MainCellView()
                    .padding(.bottom, -6)
                
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 12) {
                        ForEach(viewModel.state.filteredTokens) { token in
                            TokenCellView(viewModel: TokenViewModel(token: token))
                        }
                        viewModel.state.isSearching  ? nil : NavigationLink(
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
        viewModel.trigger(.startSearch(text))
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        let service = MainService()
        MainView(service: service)
    }

}
