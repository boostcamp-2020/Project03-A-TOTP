//
//  HeaderView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: ViewModel
    
    @ObservedObject var viewModel: AnyViewModel<MainState, MainInput>
    @State var showingAlert: Bool = false
    var count: Int {
        viewModel.state.selectedCount
//        viewModel.state.selectedTokens
//            .filter { ( key, _ ) in
//                viewModel.state.selectedTokens[key] == true
//            }.count
    }
    
    // MARK: Body
    
    var body: some View {
        HStack {
            if viewModel.state.checkBoxMode {
                deleteButton
                    .frame(height: 25)
                    .foregroundColor(.black)
                    .padding(.leading, 4)
                Spacer()
                cancelButton
            } else {
                settingButton
                    .frame(height: 25)
                    .foregroundColor(.black)
                    .padding(.leading, 4)
                Spacer()
                selectButton
            }
        }
        .padding([.leading, .trailing], 16)
    }
    
    // MARK: 삭제, 세팅 버튼
    
    var deleteButton: some View {
        Button(action: {
            showingAlert = true
        }, label: {
            Text(count == 0 ? "" : "\(count)개 삭제")
        })
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("TOTP 토큰 삭제"),
                message: Text("선택한 \(count)개의 토큰을 삭제하시려구요?"),
                primaryButton: .destructive(
                    Text("응"), action: {
                        withAnimation {
                            viewModel.trigger(.deleteSelectedTokens)
                        }}),
                secondaryButton: .cancel(Text("좀 더 생각을..")))
        }
    }
    
    var settingButton: some View {
        Button(action: {
            viewModel.trigger(.startSetting)
        }, label: {
            Image.person.resizable()
                .frame(width: 25)
        })
    }
    
    // MARK: 취소 선택 버튼
    
    var cancelButton: some View {
        Button(action: {
            viewModel.trigger(.hideCheckBox)
        }, label: {
            Text("취소")
                .padding(.trailing, 4)
                .foregroundColor(.black)
        })
    }
    
    var selectButton: some View {
        Button(action: {
            viewModel.trigger(.showCheckBox)
        }, label: {
            Text("선택")
                .padding(.trailing, 4)
                .foregroundColor(.black)
        })
    }
    
}

struct HeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        HeaderView(viewModel: AnyViewModel(MainViewModel(service: TokenService())))
    }
    
}
