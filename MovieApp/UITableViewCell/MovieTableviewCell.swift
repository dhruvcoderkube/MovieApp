//
//  MovieTableviewCell.swift
//  MovieApp
//
//  Created by Dhruv Jariwala on 28/04/22.
//

import UIKit

class MovieTableviewCell: UITableViewCell {
    
    let cellBGView : UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .white
        return baseView
    }()
    
    let movieImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        return label
    }()
    
    let likeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "icn_favourites")
        imageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        return imageView
    }()
    
    let ratingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .black
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .justified
        return label
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension MovieTableviewCell {
    func setUpViewLayout() {
        
        contentView.addSubview(cellBGView)
        
        cellBGView.leadingAnchor.constraint(equalTo : contentView.leadingAnchor, constant: 4).isActive = true
        cellBGView.trailingAnchor.constraint(equalTo : contentView.trailingAnchor, constant: 4).isActive = true
        cellBGView.topAnchor.constraint(equalTo : contentView.topAnchor, constant: 4).isActive = true
        cellBGView.bottomAnchor.constraint(equalTo : contentView.bottomAnchor, constant: 4).isActive = true
        
        cellBGView.addSubview(movieImageView)
        cellBGView.addSubview(titleLabel)
        cellBGView.addSubview(dateLabel)
        cellBGView.addSubview(likeImageView)
        cellBGView.addSubview(ratingLabel)
        cellBGView.addSubview(descriptionLabel)
        setUpUI()
    }
    
    func setUpUI() {
        
        movieImageView.leadingAnchor.constraint(equalTo:cellBGView.leadingAnchor, constant: 0).isActive = true
        movieImageView.topAnchor.constraint(equalTo: cellBGView.topAnchor, constant: 10).isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cellBGView.trailingAnchor, constant: -4).isActive = true
        
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: cellBGView.trailingAnchor, constant: -4).isActive = true
        
        
        likeImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        likeImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        
        
        ratingLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor, constant: 0).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 8).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: cellBGView.trailingAnchor, constant: -4).isActive = true
        
        
        descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: ratingLabel.bottomAnchor, constant: 4).isActive = true
        descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: movieImageView.bottomAnchor, constant: 4).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: cellBGView.leadingAnchor, constant: 0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: cellBGView.trailingAnchor, constant: -4).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: cellBGView.bottomAnchor, constant: -14).isActive = true
    }
}
