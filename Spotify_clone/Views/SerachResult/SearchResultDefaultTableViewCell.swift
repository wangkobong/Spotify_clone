//
//  SearchResultDefaultTableViewCell.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/18.
//

import UIKit
import SDWebImage


class SearchResultDefaultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultDefaultTableViewCell"
    
    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [label, iconImageView].forEach {
            contentView.addSubview($0)
        }
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height-10
        iconImageView.frame = CGRect(x: 10, y: 0, width: imageSize, height: imageSize)
        iconImageView.layer.cornerRadius = imageSize/2
        iconImageView.layer.masksToBounds = true
        label.frame = CGRect(x: iconImageView.right+10, y: 0, width: contentView.width-iconImageView.right-15, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        iconImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }

}
