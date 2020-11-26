//
//  TokenEditView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI

struct TokenEditView: View {
    
    @State var isEditing = false
    @State var text = ""
    @State private var segmentedMode = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(minWidth: 20,
                           maxWidth: 80,
                           minHeight: 20,
                           maxHeight: 80)
                    .padding(60)
                    .background(LinearGradient.mint)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                
                TextField("토큰 이름을 입력하세요", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "pencil.and.outline")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        }
                    )
                    .padding(.top, 20)
                    .padding(.bottom, -8)
                    .padding(.horizontal, 60)
                    .animation(.default)
                
                Divider()
                    .padding(.horizontal, 60)
                
                Spacer()
                
                Picker(selection: $segmentedMode, label: Text("mode")) {
                    Text("색상").tag(0)
                    Text("아이콘").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 60)
                
                Spacer()
                
                segmentedMode == 0 ? PaletteView() : nil
                segmentedMode == 1 ? IconView() : nil
                
                Spacer()
            }
            
        }
    }
}

struct IconView: View {

    private var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(1...15, id: \.self) { _ in
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 35, height: 35, alignment: .center)
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
    }

}

struct PaletteView: View {

    private var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(1...6, id: \.self) { _ in
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 55, height: 55, alignment: .center)
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
    }
    
}

struct TokenEditView_Previews: PreviewProvider {
    static var previews: some View {
        TokenEditView()
    }
}
