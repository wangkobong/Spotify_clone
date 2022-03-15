//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/13.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        [albumCoverImageView, trackNameLabel, artistNameLabel].forEach {
            contentView.addSubview($0)
        }
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        albumCoverImageView.frame = CGRect(
            x: 5,
            y: 2,
            width: contentView.height-4,
            height: contentView.height-4)
        
        trackNameLabel.frame = CGRect(
            x: albumCoverImageView.right+10,
            y: 0,
            width: contentView.width-albumCoverImageView.right-15,
            height: contentView.height/2)
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right+10,
            y: contentView.height/2,
            width: contentView.width-albumCoverImageView.right-15,
            height: contentView.height/2)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        albumCoverImageView.image = nil
        artistNameLabel.text = nil
    }
    
    func configure(with viewModel: RecommendedTrackViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        
    }
}
