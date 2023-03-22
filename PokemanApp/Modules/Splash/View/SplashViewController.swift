//
//  ViewController.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import UIKit
import Combine

protocol ISplashView: AnyObject {
    func setViewColor()
    func setUpUI()
    func showToastDialog()
    func goMainPage()
}

class SplashViewController: UIViewController {
    lazy var viewModel: ISplashViewModel = SplashViewModel(view: self)
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashViewController: ISplashView {
    func setViewColor() {
        self.view.backgroundColor = .systemBackground
    }
    
    func setUpUI() {
        label.text = "Welcome Pokemon App!"
        versionLabel.text = "App Version: \(String(describing: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""))"
        self.view.addSubview(label)
        self.view.addSubview(versionLabel)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            versionLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant: -20),
        ])
    }
    
    func showToastDialog() {
        self.showToast(title: "Error", text: "No internet connection.", delay: 2)
    }
    
    func goMainPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigationController?.pushViewController(TabBarViewController(), animated: false)
        }
    }
}
