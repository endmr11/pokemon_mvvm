//
//  DetailViewController.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import UIKit

private enum DetailViewConstant {
    static let cellReuseIdentifier = "AbilityTableViewCell"
    static let navigationBarTitle = "Pokemon Detail"
    static let titleTextAttributesColor = Color.appBase
    static let cellBackgroundColor = Color.pokemonCellBackgrounColor
    static let cellBorderColor = Color.black
    static let backButtonIcon = "arrow.backward"
    static let cellSpacing = 20.0
    static let cellSize = CGSize(width: 100, height: 32)
    static let cornerRadius = 8.0
    static let borderWidth = 1.0
    static let fontSize = 20.0
}

protocol IDetailView: AnyObject {
    func configureNavigationBar()
    func setUpUI()
    func setUI(model: PokemonDetailResult)
}

class DetailViewController: UIViewController {
    
    private var viewModel: IDetailViewModel?
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //        scrollView.isScrollEnabled = true
        //        scrollView.contentSize.height = 1200
        scrollView.isDirectionalLockEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let abilityTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(AbilityTableViewCell.self, forCellReuseIdentifier: DetailViewConstant.cellReuseIdentifier)
        return tableView
    }()
    
    init(pokemonDetailResult: PokemonDetailResult) {
        super.init(nibName: nil, bundle: nil)
        viewModel = DetailViewModel(view: self, pokemonDetailResult: pokemonDetailResult)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else {
            return
        }
        viewModel.viewDidLoad()
    }
    
}

extension DetailViewController: IDetailView {
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(close))
        backButton.setBackgroundImage(UIImage(systemName: DetailViewConstant.backButtonIcon), for: .normal, barMetrics: .default)
        backButton.tintColor = DetailViewConstant.titleTextAttributesColor
        navigationItem.setLeftBarButton(backButton, animated: false)
        navigationItem.title = DetailViewConstant.navigationBarTitle
    }
    
    func setUpUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(abilityTitleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            abilityTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            abilityTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: abilityTitleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setUI(model: PokemonDetailResult) {
        nameLabel.text = model.name.capitalized
        abilityTitleLabel.text = "Abilities"
        imageView.kf.setImage(with: URL(string: model.sprites.front_default ))
    }
}

extension DetailViewController {
    @objc func close() {
        closeView()
    }
    
}

//MARK: - TableView DataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewConstant.cellReuseIdentifier,for: indexPath) as? AbilityTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(model: viewModel?.getAbility(index: indexPath.row))
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - TableView Delegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.heightForRowAt ?? 0
    }
}
