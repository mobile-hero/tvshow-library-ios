//
//  ShowCell.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 23/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowCell: View {
    
    var show: TvShowModel
    @State private var imgSize = CGSize.zero
    @State private var width = 0.0
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            let width = (UIScreen.main.bounds.width - 10) / 2
            let height = width / 2 * 3
            WebImage(url: URL(string: show.image))
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .frame(maxWidth: width, minHeight: height, maxHeight: height, alignment: .center)
                .clipped()
            VStack(alignment: .leading) {
                Text(show.showName)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(UIColor.darkGray))
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 3, trailing: 8))
                Text(show.name.trimmingCharacters(in: .whitespacesAndNewlines))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
            }
            .frame(minHeight: 70)
        }
    }
}
