//
//  DetailView.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter
    @State var aspectRatio: Double = 0.0
    @State var imageHeight: Double = 200
    
    var body: some View {
        VStack(alignment: .center) {
            if presenter.loadingState {
                Text("Loading...")
                ActivityIndicator()
            } else if presenter.detailTvShow != nil {
                ScrollView{
                    VStack(alignment: .leading) {
                        let detail = presenter.detailTvShow!
                        ZStack(alignment: .bottomTrailing) {
                            let width = UIScreen.main.bounds.width
                            WebImage(url: URL(string: detail.imageOriginal))
                                .onSuccess(perform: { image, data, cacheType in
                                    print(image.size)
                                    self.aspectRatio = image.size.width / image.size.height
                                    self.imageHeight = width / aspectRatio
                                })
                                .resizable()
                                .placeholder {
                                    Rectangle().foregroundColor(.gray)
                                }
                                .indicator(.activity)
                                .aspectRatio(aspectRatio, contentMode: .fit)
                                .frame(width: width, height: imageHeight, alignment: .center)
                                .clipped()
                            let isFavorite = presenter.isFavorite
                            Button(isFavorite ? "Remove Favorite" : "Add Favorite") {
                                if isFavorite {
                                    presenter.removeFavorite()
                                } else {
                                    presenter.addFavorite()
                                }
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(isFavorite ? Color.red : Color.green)
                            .clipShape(Capsule())
                            .padding(10)
                            
                        }
                        .padding(.bottom, 5)
                        VStack(alignment: .leading) {
                            Text(detail.showName)
                                .font(Font.system(size: 16))
                                .foregroundColor(.gray)
                            Text(detail.name)
                                .font(Font.system(size: 25))
                            Text("S\(detail.season)-E\(detail.number)")
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                            Divider()
                                .padding(.vertical, 10)
                            Text(AttributedString(detail.formattedSummary!))
                        }
                        .padding(.horizontal, 8)
                    }
                    .padding(.vertical, 10)
                }
            } else {
                Text(presenter.errorMessage)
            }
        }
        .onAppear {
            self.presenter.getDetail()
        }
        .navigationBarTitle(
            Text("Detail"),
            displayMode: .automatic
        )
    }
}
