//
//  TabBarViewController.swift
//  PokemanApp
//
//  Created by Eren Demir on 21.03.2023.
//

import UIKit
import Combine
class TabBarViewController: UITabBarController {
    
    var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingsViewModel.shared.switchState
            .sink(receiveValue: { [weak self] isOn in
                self?.overrideUserInterfaceStyle = isOn ? .dark : .light
            })
            .store(in: &cancellables)
        navigationItem.hidesBackButton = true
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings"
        let navigationController1 = UINavigationController(rootViewController: homeVC)
        self.setViewControllers([navigationController1,settingsVC], animated: true)
        guard let items = self.tabBar.items else {return}
        let images = ["house","star"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        self.tabBar.tintColor = .orange
        self.tabBar.barTintColor = .systemBackground
    }
    
    
    
}
