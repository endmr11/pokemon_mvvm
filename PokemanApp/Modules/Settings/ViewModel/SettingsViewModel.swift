//
//  SettingsViewModel.swift
//  PokemanApp
//
//  Created by Eren Demir on 21.03.2023.
//

import UIKit
import Combine

protocol ISettingsViewModel {
    var switchState: PassthroughSubject<Bool, Never>{get}
    func switchValueChanged(_ sender: UISwitch)
}

final class SettingsViewModel : ISettingsViewModel{
    static let shared = SettingsViewModel()
    var switchState = PassthroughSubject<Bool, Never>()
    @objc func switchValueChanged(_ sender: UISwitch) {
        switchState.send(sender.isOn)
    }
}


