//
//  TokenEditView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI

struct TokenEditView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(60)
                    .background(LinearGradient.mint)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.horizontal, 60)
        }
    }
}

struct TokenEditView_Previews: PreviewProvider {
    static var previews: some View {
        TokenEditView()
    }
}
