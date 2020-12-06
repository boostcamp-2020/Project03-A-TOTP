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
                        searchImage
                        if viewModel.state.isSearching {
                            xButton
                        }
                    }
                )
                .padding(.horizontal, 12)
                .onChange(of: searchText) { _ in
                    search(text: searchText)
                }

            if viewModel.state.isSearching {
                cancelButton
            }
        }
        .padding(.top, 12)
    }

}

// MARK: SubViews

private extension SearchBarView {
    
    var searchImage: some View {
        Image.search
            .foregroundColor(.gray)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
    }
    
    var cancelButton: some View {
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
    
    var xButton: some View {
        Button(action: {
            freshSearchBar()
        }, label: {
            Image.cancel
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        })
    }
    
}

// MARK: Methods

private extension SearchBarView {
    
    func changeSearchState(changed: Bool) {
        withAnimation {
            if changed {
                viewModel.trigger(.serchInput(.startSearch))
            } else {
                viewModel.trigger(.serchInput(.endSearch))
                freshSearchBar()
            }
        }
    }
    
    func search(text: String) {
        if !viewModel.state.isSearching { return }
        withAnimation {
            viewModel.trigger(.serchInput(.search(text)))
        }
    }
    
    func endSearch() {
        withAnimation {
            viewModel.trigger(.serchInput(.endSearch))
        }
    }
    
    func freshSearchBar() {
        searchText = ""
    }
    
}
