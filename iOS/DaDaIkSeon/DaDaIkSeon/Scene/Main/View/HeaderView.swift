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
    @ObservedObject var linkManager: MainLinkManager
    // MARK: Property
    
    @State private var showingAlert: Bool = false
    
    private var count: Int {
        viewModel.state.selectedCount
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
                title: Text("선택한 \(count)개의 토큰을 삭제"),
                message: Text("토큰을 삭제해도 2단계 인증 사용이 중지 되지 않습니다. 삭제하기 전에 2단계 인증 사용을 중지하거나 비밀번호를 생성할 수 있는 대체 수단을 마련하세요."),
                primaryButton: .destructive(
                    Text("삭제"), action: {
                        withAnimation {
                            viewModel.trigger(.checkBoxInput(.deleteSelectedTokens))
                        }}),
                secondaryButton: .cancel(Text("취소")))
        }
    }
    
    var settingButton: some View {
        Button(action: {
            linkManager.change(.setting)
        }, label: {
            Image.person.resizable()
                .frame(width: 25)
        })
        .foregroundColor(.black)
    }
    
    // MARK: 취소 선택 버튼
    
    var cancelButton: some View {
        Button(action: {
            withAnimation {
                viewModel.trigger(.checkBoxInput(.hideCheckBox))
            }
        }, label: {
            Text("취소")
                .padding(.trailing, 4)
                .foregroundColor(.black)
        })
    }
    
    var selectButton: some View {
        Button(action: {
            withAnimation {
                viewModel.trigger(.checkBoxInput(.showCheckBox))
            }
        }, label: {
            Text("선택")
                .padding(.trailing, 4)
                .foregroundColor(.black)
        })
    }
    
}

//struct HeaderView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        HeaderView(viewModel: AnyViewModel(MainViewModel(service: TokenService(StorageManager()))))
//    }
//    
//}
