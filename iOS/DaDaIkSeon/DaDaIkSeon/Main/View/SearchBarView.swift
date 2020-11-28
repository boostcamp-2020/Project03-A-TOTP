//
//  SearchBarView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

//import SwiftUI
//
//struct SearchBarView: View {
//
//    // MARK: ViewModel
//    @ObservedObject var viewModel: AnyViewModel<MainState, MainInput>
//
//    init(service: MainServiceable, searchText: String, isSearching: Bool) {
//        viewModel = AnyViewModel(MainViewModel(service: service))
//    }
//
//    // MARK: Body
//
//    var body: some View {
//        HStack {
//            TextField("검색", text: $searchText)
//                .padding(7)
//                .padding(.horizontal, 25)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .overlay(
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 8)
//
//                        if isSearching {
//                            // X버튼
//                            Button(action: {
//                                searchText = ""
//                            }, label: {
//                                Image(systemName: "multiply.circle.fill")
//                                    .foregroundColor(.gray)
//                                    .padding(.trailing, 8)
//                            })
//                        }
//                    }
//                )
//                .onChange(of: searchText) { _ in
//                    changeText(text: searchText)
//                }
//                .padding(.horizontal, 12)
//                .onTapGesture {
//                    isSearching = true
//                }
//
//            if isSearching {
//                // 취소 버튼
//                Button(action: {
//                    isSearching = false
//                    searchText = ""
//                    hideKeyboard()
//                }, label: {
//                    Text("취소")
//                        .foregroundColor(.black)
//                })
//                .padding(.trailing, 10)
//                .transition(.move(edge: .trailing))
//                .animation(.default)
//            }
//        }
//    }
//
//}
//
//private extension SearchBarView {
//    func changeText(text: String) {
//        viewModel.trigger(.search(text))
//    }
//}
