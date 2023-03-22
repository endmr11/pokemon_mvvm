//
//  SplashViewModel.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

protocol ISplashViewModel {
    func viewDidLoad()
}

final class SplashViewModel{
    private var view: ISplashView?
    
    init(view: ISplashView) {
        self.view = view
    }
    
    private func checkNetworkConnectivity() {
        if AppNetworkConnectivity.isInternetAvailable {
            view?.setUpUI()
            view?.goMainPage()
        }
        else {
            view?.showToastDialog()
        }
    }
}
extension SplashViewModel: ISplashViewModel {
    
    func viewDidLoad() {
        view?.setViewColor()
        checkNetworkConnectivity()
    }
}
