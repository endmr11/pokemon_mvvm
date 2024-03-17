//
//  SettingsViewController.swift
//  PokemanApp
//
//  Created by Eren Demir on 21.03.2023.
//

import UIKit
import Combine

private enum HomeViewConstant {
    static let switchLabelText = "Dark Mode"
    static let searchText = "Search Pokemon"
    static let fontSize = 20.0
}

protocol ISettingsView: AnyObject {
    func setUpUI()
}

class SettingsViewController: UIViewController,ISettingsView {
    
    var cancellables = Set<AnyCancellable>()
    lazy var mySwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.addTarget(SettingsViewModel.shared, action: #selector(SettingsViewModel.shared.switchValueChanged(_:)), for: .valueChanged)
        return switchView
    }()
    
    private lazy var switchTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = HomeViewConstant.switchLabelText
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [switchTitleLabel,mySwitch])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.addArrangedSubview(switchTitleLabel)
        stackView.addArrangedSubview(mySwitch)
        return stackView
    }()
    
    lazy var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .systemGray
        return dividerView
    }()
    
    
    var switchStateSubscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        print(overrideUserInterfaceStyle.rawValue)
        mySwitch.isOn = overrideUserInterfaceStyle.rawValue != 0
        SettingsViewModel.shared.switchState
            .sink(receiveValue: { [weak self] isOn in
                self?.mySwitch.isOn = isOn
            })
            .store(in: &cancellables)
    }
    
    func setUpUI() {
        self.view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        view.addSubview(dividerView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            stackView.heightAnchor.constraint(equalToConstant: mySwitch.frame.height),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 8),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -8),
            dividerView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 10),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            dividerView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
        ])
    }
}
#Preview{
    let vc = SettingsViewController()
    return vc
}
