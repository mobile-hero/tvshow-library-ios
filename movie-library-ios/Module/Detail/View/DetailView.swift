//
//  DetailView.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                if presenter.loadingState {
                    Text("Loading...")
                    ActivityIndicator()
                } else if presenter.detailMovie != nil {
                    let detail = presenter.detailMovie!
                    WebImage(url: URL(string: detail.image))
                        .placeholder {
                            Rectangle().foregroundColor(.gray)
                        }
                        .indicator(.activity)
                        .frame(width: .infinity, height: 150, alignment: .center)
                        .scaledToFit()
                    Text(detail.name)
                    Text("S\(detail.season)-E\(detail.number)").fontWeight(.bold)
                    Rectangle().foregroundColor(.clear).frame(height: 10)
                    Text(detail.summary)
                } else {
                    Text(presenter.errorMessage)
                }
            }
            .padding(10)
        }
        .onAppear {
            self.presenter.getDetail()
        }.navigationBarTitle(
            Text("Detail"),
            displayMode: .automatic
        )
    }
}
