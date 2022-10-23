//
//  CustomEmptyView.swift
//  MealsApps
//
//  Created by Ari Supriatna on 08/09/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct CustomEmptyView: View {
    var image: String
    var title: String
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .foregroundColor(.orange)
                .frame(width: 70)
            
            Text(title)
                .font(.system(.body, design: .rounded))
        }
    }
}
