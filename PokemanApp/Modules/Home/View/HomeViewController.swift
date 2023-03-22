//
//  HomeViewController.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import UIKit

private enum HomeViewConstant {
    static let cellReuseIdentifier = "PokemonTableViewCell"
    static let navigationBarTitle = "Pokemons"
    static let titleTextAttributesColor = Color.appBase
    static let emptyLabelText = "No Pokemons Found!"
    static let searchText = "Search Pokemon"
    static let fontSize = 20.0
}

protocol IHomeView: AnyObject {
    func setUpNavigationBar()
    func setUpUI()
    func openDetailView(result: PokemonDetailResult)
    func refreshTable()
    func closeCircularIndicator()
    func showCircularIndicator()
    func searchBarEnabled(isEnable: Bool)
    func emptyLabelIsHidden(isHidden: Bool)
    func showErrorDialog(text:String)
}


final class HomeViewController: UIViewController, UISearchControllerDelegate {
    
    private lazy var searchBar: UISearchController = {
        let searchVC = UISearchController(searchResultsController: nil)
        searchVC.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchVC
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: HomeViewConstant.cellReuseIdentifier)
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = HomeViewConstant.titleTextAttributesColor
        label.textAlignment = .left
        label.text = HomeViewConstant.emptyLabelText
        label.isHidden = true
        return label
    }()
    
    private lazy var viewModel: IHomeViewModel = HomeViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

//MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewConstant.cellReuseIdentifier,for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(model: viewModel.getPokemon(index: indexPath.row))
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt
    }
}

//MARK: - SearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.filterPokemon(name: text)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        emptyLabel.isHidden = true
        viewModel.fetchPokemons(text: "",completion: {
            DispatchQueue.main.async {
                self.closeCircularIndicator()
                self.searchBarEnabled(isEnable: true)
                self.emptyLabelIsHidden(isHidden: true)
                self.refreshTable()
            }
        })
    }
}

// MARK: - HomeViewInterface
extension HomeViewController: IHomeView {
    func setUpNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
        searchBar.searchBar.placeholder = HomeViewConstant.searchText
        navigationItem.title = HomeViewConstant.navigationBarTitle
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setUpUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            tableView.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            tableView.heightAnchor.constraint(equalTo:view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo:view.widthAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            
        ])
    }
    
    func openDetailView(result: PokemonDetailResult) {
        openView(viewController: DetailViewController(pokemonDetailResult: result))
    }
    
    func refreshTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func closeCircularIndicator() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(30), execute: {
            self.dismissLoadingView()
        })
    }
    
    func showCircularIndicator() {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
    }
    
    func searchBarEnabled(isEnable: Bool) {
        searchBar.searchBar.isUserInteractionEnabled = isEnable
    }
    
    func emptyLabelIsHidden(isHidden: Bool) {
        emptyLabel.isHidden = isHidden
    }
    func showErrorDialog(text:String) {
        DispatchQueue.main.async {
            self.showToast(title: "Error", text: text, delay: 5)
        }
    }
}
