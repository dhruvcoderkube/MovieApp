//
// Copyright (c) 2023 YASSIR. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    var movieData = [Results]()
    
    let baseView : UIView = {
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
        imageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        return imageView
    }()
    
    let titleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 58).isActive = true
        return imageView
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
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let ratingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = .black
        label.text = "5.5"
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = .black
        return label
    }()
    
    let ratingBGView : UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .clear
        return baseView
    }()
    
    let genreLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    let languageLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    let productionComapanyLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
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
    
    let navigationTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitleLabel.text = movieData.first?.title
        title = navigationTitleLabel.text
        view.backgroundColor = .white
        setUpViewLayout()
        movieDetails()
        setUpUI()
    }
}


extension DetailsViewController {
    func setUpViewLayout() {
        view.addSubview(baseView)
        
        baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        baseView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        baseView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        
        baseView.addSubview(movieImageView)
        baseView.addSubview(titleImageView)
        baseView.addSubview(titleLabel)
        baseView.addSubview(ratingBGView)
        baseView.addSubview(dateLabel)
        baseView.addSubview(genreLabel)
        baseView.addSubview(languageLabel)
        baseView.addSubview(productionComapanyLabel)
        baseView.addSubview(descriptionLabel)
        
        ratingBGView.addSubview(likeImageView)
        ratingBGView.addSubview(ratingLabel)
    }
    
    func setUpUI() {
        movieImageView.leadingAnchor.constraint(equalTo:baseView.leadingAnchor, constant: 0).isActive = true
        movieImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: 0).isActive = true
        
        
        titleImageView.centerYAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 0).isActive = true
        titleImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 44).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo:titleImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16).isActive = true
        
        ratingBGView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 8).isActive = true
        ratingBGView.centerXAnchor.constraint(equalTo: titleImageView.centerXAnchor, constant: 0).isActive = true
        
        likeImageView.topAnchor.constraint(equalTo: ratingBGView.topAnchor, constant: 0).isActive = true
        likeImageView.leadingAnchor.constraint(equalTo: ratingBGView.leadingAnchor, constant: 0).isActive = true
        likeImageView.bottomAnchor.constraint(equalTo: ratingBGView.bottomAnchor, constant: 0).isActive = true
        
        ratingLabel.topAnchor.constraint(equalTo: ratingBGView.topAnchor, constant: 0).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 8).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: ratingBGView.bottomAnchor, constant: 0).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: ratingBGView.trailingAnchor, constant: 0).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        
        genreLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 14).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16).isActive = true
        
        languageLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 12).isActive = true
        languageLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16).isActive = true
        languageLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16).isActive = true
        
        productionComapanyLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 12).isActive = true
        productionComapanyLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16).isActive = true
        productionComapanyLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: productionComapanyLabel.bottomAnchor, constant: 12).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16).isActive = true
    }
    
    
    func movieDetails(){
        
        var apiKey = Parameters()
        apiKey["api_key"] = Config.Apikey
        
        API().getDetails(movieID : movieData.first?.id ?? 0, paramters: apiKey) { responseObj in
            let dataModel = MovieDetails(responseObj!)
            
            self.titleLabel.text = dataModel.title
            self.dateLabel.text = dataModel.releaseDate
            self.ratingLabel.text = "\(dataModel.voteAverage ?? 0)"
            
            var nameArray = [String]()
            for data in dataModel.genres!{
                let name = data.name
                nameArray.append(name ?? "")
            }
            self.genreLabel.text = "Genres : " + nameArray.joined(separator: ", ")
            
            var language = [String]()
            for data in dataModel.spokenLanguages!{
                let name = data.name
                language.append(name ?? "")
            }
            self.languageLabel.text = "Languages : " + language.joined(separator: ", ")
            
            var companies = [String]()
            for data in dataModel.productionCompanies!{
                let name = data.name
                companies.append(name ?? "")
            }
            self.productionComapanyLabel.text = "Production Companies : " + companies.joined(separator: ", ")
            
            self.descriptionLabel.text = dataModel.overview
            
            let posterImage = (ConfigurationData.first?.baseUrl ?? "") + (ConfigurationData.first?.posterSizes?[4] ?? "") + (dataModel.posterPath ?? "")
            self.movieImageView.getImage(url: posterImage)
            
            let titleImage = (ConfigurationData.first?.baseUrl ?? "") + (ConfigurationData.first?.posterSizes?[4] ?? "") + (dataModel.backdropPath ?? "")
            self.titleImageView.getImage(url: titleImage)
            
        } failure: { error in
            
        }
    }
}
