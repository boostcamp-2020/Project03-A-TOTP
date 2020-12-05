//
//  SearchBarView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

struct SearchBarView: View {

    // MARK: Property
    
    @ObservedObject var viewModel: AnyViewModel<MainState, MainInput>
    @State var searchText = ""
    
    // MARK: Body

    var body: some View {
        HStack {
            TextField("검색", text: $searchText, onEditingChanged: changeSearchState)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image.search
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if viewModel.state.isSearching {
                            // X버튼
                            Button(action: {
                                freshSearchBar()
                            }, label: {
                                Image.cancel
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                )
                .padding(.horizontal, 12)
                .onChange(of: searchText) { _ in
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
    
    func changeSearchState(changed: Bool) {
        withAnimation {
            changed ? viewModel.trigger(.startSearch) : viewModel.trigger(.endSearch)
        }
    }
    
    func search(text: String) {
        if !viewModel.state.isSearching { return }
        withAnimation {
            viewModel.trigger(.search(text))
        }
    }
    
    func endSearch() {
        withAnimation {
            viewModel.trigger(.endSearch)
            freshSearchBar()
        }
    }
    
    func freshSearchBar() {
        searchText = ""
    }
    
}
