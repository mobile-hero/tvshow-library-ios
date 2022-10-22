//
//  HomeView.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import UIKit

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    @State private var width = CGFloat.zero
    
    let columns = [GridItem(alignment: Alignment(horizontal: .leading, vertical: .top)),
                   GridItem(alignment: Alignment(horizontal: .leading, vertical: .top))]
    
    var body: some View {
        VStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                }
            } else if !presenter.movies.isEmpty {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: self.columns, spacing: 5) {
                        ForEach(
                            self.presenter.movies,
                            id: \.id
                        ) { movie in
                            self.presenter.linkBuilder(for: movie) {
                                ShowCell(show: movie)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            } else {
                Text(presenter.errorMessage)
            }
        }.onAppear {
            if self.presenter.movies.count == 0 {
                self.presenter.getMovies()
            }
        }.navigationBarTitle(
            Text("Movies"),
            displayMode: .automatic
        )
    }
}

struct CGSizeKey: PreferenceKey {
    typealias Value = CGSize
    
    static var defaultValue: Value { CGSize.zero }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct CGFloatKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: Value { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}


struct ShowCell: View {
    
    var show: MovieModel
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


typealias GridViewTap = (MovieModel) -> Void

struct GridView: UIViewRepresentable {
    
    public var dataSource: MovieModels
    private let layout: UICollectionViewFlowLayout
    private let onTap: GridViewTap
    
    init(_ dataSource: MovieModels, onTap: @escaping GridViewTap) {
        self.dataSource = dataSource
        self.onTap = onTap
        layout = UICollectionViewFlowLayout()
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let clView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clView.delegate = context.coordinator
        clView.dataSource = context.coordinator
        clView.registerCell(MovieViewCell.self)
        return clView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        uiView.reloadData()
    }
    
    func makeCoordinator() -> GridViewInterface {
        GridViewInterface(dataSource: dataSource, onTap: onTap)
    }
}

protocol GridViewInterfaceDelegate {
    func onTap(item: MovieModel)
}

class GridViewInterface: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var dataSource: MovieModels
    var delegate: GridViewInterfaceDelegate?
    var onTap: GridViewTap
    
    init(dataSource: MovieModels, onTap: @escaping GridViewTap) {
        self.dataSource = dataSource
        self.onTap = onTap
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onTap(item: dataSource[indexPath.row])
        onTap(dataSource[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.stringIdentifier, for: indexPath) as! MovieViewCell
        cell.configure(item: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2
        return .init(width: width, height: width / 2 * 3 + 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension UICollectionViewCell {
    static var stringIdentifier: String { String(describing: Self.self) }
}

extension UICollectionView {
    func registerCell(_ cell: UICollectionViewCell.Type) {
        self.register(cell.self, forCellWithReuseIdentifier: cell.stringIdentifier)
    }
}

class MovieViewCell: UICollectionViewCell {
    
    private let image = UIImageView()
    private let nameLabel = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    private func sharedInit() {
        clipsToBounds = true
        
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        print(layer.frame.width)
        let width = layer.frame.width
        image.heightAnchor.constraint(equalToConstant: width / 2 * 3).isActive = true
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .gray
        nameLabel.numberOfLines = 1
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        
        titleLabel.contentMode = .topLeft
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
    }
    
    func configure(item: MovieModel) {
        image.sd_setImage(with: URL(string: item.image))
        nameLabel.text = item.showName
        titleLabel.text = item.name
    }
    
    override func prepareForReuse() {
        image.image = nil
        nameLabel.text = .none
        titleLabel.text = .none
    }
}
