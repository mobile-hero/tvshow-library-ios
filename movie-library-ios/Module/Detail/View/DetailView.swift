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
        VStack(alignment: .center) {
            if presenter.loadingState {
                Text("Loading...")
                ActivityIndicator()
            } else if presenter.detailMovie != nil {
                let detail = presenter.detailMovie!
                ScrollView{
                    VStack(alignment: .leading) {
                        WebImage(url: URL(string: detail.image))
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .indicator(.activity)
                            .frame(width: .infinity, height: 150, alignment: .center)
                            .scaledToFit()
                            .padding(.bottom, 5)
                        Text(detail.name).font(Font.system(size: 25))
                        Text("S\(detail.season)-E\(detail.number)")
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        Divider()
                        Rectangle().foregroundColor(.clear).frame(height: 10)
                        Text(AttributedString(detail.formattedSummary))
                    }
                }
            } else {
                Text(presenter.errorMessage)
            }
        }
        .padding(10)
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
