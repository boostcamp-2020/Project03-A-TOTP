//
//  SearchBarView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

struct SearchBarView: View {

    // MARK: Property
    
    @EnvironmentObject var viewModel: AnyViewModel<MainState, MainInput>
    @State var searchText = ""
    
    // MARK: Body

    var body: some View {
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
                                endSearch()
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                )
                .onChange(of: searchText) { _ in
                    search(text: searchText)
                }
                .padding(.horizontal, 12)
                .onTapGesture {
                    search(text: searchText)
                }

            if viewModel.state.isSearching {
                // 취소 버튼
                Button(action: {
                    endSearch()
                    hideKeyboard()
                }, label: {
                    Text("취소")
                        .foregroundColor(.black)
                })
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }

}

private extension SearchBarView {
    
    func search(text: String) {
        withAnimation {
            viewModel.trigger(.startSearch(text))
        }
    }
    
    func endSearch() {
        withAnimation {
            viewModel.trigger(.endSearch)
        }
        searchText = viewModel.state.searchText
    }
    
}
