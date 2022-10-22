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
    @State var aspectRatio: Double = 0.0
    @State var imageHeight: Double = 200
    
    var body: some View {
        VStack(alignment: .center) {
            if presenter.loadingState {
                Text("Loading...")
                ActivityIndicator()
            } else if presenter.detailMovie != nil {
                let detail = presenter.detailMovie!
                ScrollView{
                    VStack(alignment: .leading) {
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
                            .padding(.bottom, 5)
                            .clipped()
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
                            Text(AttributedString(detail.formattedSummary))
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
        }.navigationBarTitle(
            Text("Detail"),
            displayMode: .automatic
        )
    }
}

struct AttributedText: UIViewRepresentable {
    
    let attributedString: NSAttributedString
    
    init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }
    
    init(_ text: String) {
        self.attributedString = try! NSAttributedString(data: text.data(using: .utf8)!,
                                                        options: [.documentType: NSAttributedString.DocumentType.html,
                                                                  .characterEncoding: String.Encoding.utf8.rawValue],
                                                        documentAttributes: nil)
    }
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}
