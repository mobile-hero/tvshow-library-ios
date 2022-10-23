//
//  AboutView.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 23/10/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("profile")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .scaledToFit()
            Text("Muhammad Ikhsan")
                .font(Font.title)
                .foregroundColor(.indigo)
            Text("TO DARE IS TO DO")
                .bold()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
