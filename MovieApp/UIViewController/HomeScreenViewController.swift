//
//  HomeScreenViewController.swift
//  MovieApp
//
//  Created by Dhruv Jariwala on 28/04/22.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage

enum SectionIdentifier {
    case main
}

class HomeScreenViewController : UIViewController {
    
    var secureView = SecureView()
    
    var dataSource: UITableViewDiffableDataSource<SectionIdentifier, Results>!
    
    var movieData = [Results]()
    
    var snapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, Results>()
    
    let homeScreenView : UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .white
        return baseView
    }()
    
    let placeholderTextLabel : UILabel = {
        let baseLabel = UILabel()
        baseLabel.translatesAutoresizingMaskIntoConstraints = false
        baseLabel.numberOfLines = 2
        baseLabel.textAlignment = .center
        baseLabel.text = "Nice try! \nBut you can't 😉"
        return baseLabel
    }()
    
    let movieTableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        view.backgroundColor = .white
        
        setupTableView()
        setUpViewLayout()
        gettingConfigurations()
        movieList()
        
        movieTableView.delegate = self
        movieTableView.setDataSourceDelegate(datasourceAndDelegate: dataSource, tableCellIdentifier: "MovieTableviewCell", tableCell : MovieTableviewCell.self)
        
        let rightButton = UIBarButtonItem(
            image: .actions,
            style: .plain,
            target: self,
            action: #selector(rightButtonTapped)
        )
        navigationItem.rightBarButtonItem = rightButton
    }
}


extension HomeScreenViewController {
    func setUpViewLayout() {
        view.addSubview(homeScreenView)
        
        homeScreenView.leadingAnchor.constraint(equalTo : view.leadingAnchor, constant: 0).isActive = true
        homeScreenView.trailingAnchor.constraint(equalTo : view.trailingAnchor, constant: 0).isActive = true
        homeScreenView.topAnchor.constraint(equalTo : view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        homeScreenView.bottomAnchor.constraint(equalTo : view.bottomAnchor, constant: 0).isActive = true
        
        homeScreenView.addSubview(secureView)
        secureView.contentView.addSubview(movieTableView)
        secureView.placeholderView.addSubview(placeholderTextLabel)
        
        secureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secureView.leadingAnchor.constraint(equalTo: self.homeScreenView.leadingAnchor, constant: 0),
            secureView.trailingAnchor.constraint(equalTo: self.homeScreenView.trailingAnchor, constant: 0),
            secureView.topAnchor.constraint(equalTo: self.homeScreenView.topAnchor, constant: 0),
            secureView.bottomAnchor.constraint(equalTo: self.homeScreenView.bottomAnchor, constant: 0),

            placeholderTextLabel.centerXAnchor.constraint(equalTo: secureView.centerXAnchor),
            placeholderTextLabel.centerYAnchor.constraint(equalTo: secureView.centerYAnchor),
        ])
        
        movieTableView.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 14).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -14).isActive = true
        movieTableView.topAnchor.constraint(equalTo: secureView.topAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: secureView.bottomAnchor).isActive = true
    }
    
    func movieList() {
        var apiKey = Parameters()
        apiKey["api_key"] = Config.Apikey
        
        API().getMovieList(paramters: apiKey) { responseObj in
            let dataModel = RootClass(responseObj!)
            
            if let data = dataModel.results , data.count > 0 {
                self.movieData = data
                self.snapshot.appendSections([.main])
                self.snapshot.appendItems(data, toSection: .main)
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
            }
        } failure: { error in
            // Handle the error, if needed
        }
    }
    
    func setupTableView() {
        
        dataSource = UITableViewDiffableDataSource(tableView: movieTableView) { (tableView, indexPath, movie) -> UITableViewCell? in
            // Configure and return your cell here
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableviewCell", for: indexPath) as! MovieTableviewCell
            let image = (ConfigurationData.first?.baseUrl ?? "") + (ConfigurationData.first?.posterSizes?[4] ?? "") + (movie.posterPath ?? "")
            tableViewCell.movieImageView.getImage(url: image)
            print("image name : ", image)
            
            tableViewCell.titleLabel.text = movie.title
            tableViewCell.dateLabel.text = movie.releaseDate
            tableViewCell.ratingLabel.text = "\(movie.voteAverage ?? 0)"
            tableViewCell.descriptionLabel.text = movie.overview
            
            return tableViewCell
        }
    }
    
    @objc func rightButtonTapped() {
        //snapshot.deleteSections([.main])
        //self.snapshot.appendSections([.main])
        self.snapshot.appendItems(movieData, toSection: .main)
        self.dataSource.apply(self.snapshot, animatingDifferences: true)
    }
}

extension HomeScreenViewController: UINavigationControllerDelegate{
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        UIApplication.shared.statusBarStyle = .darkContent
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movies = movieData[indexPath.row]
        let viewController = DetailsViewController()
        viewController.movieData = [movies]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
