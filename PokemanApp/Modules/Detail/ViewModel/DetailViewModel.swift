//
//  DetailViewModel.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

protocol IDetailViewModel {
    func viewDidLoad()
    var numberOfRowsInSection: Int { get }
    var heightForRowAt: Double { get }
    func viewWillAppear()
    func didSelectRowAt(index: Int)
    func getAbility(index: Int) -> Ability
}
private extension DetailViewModel {
    enum Constant {
        static let cellHeight: Double = 65
    }
}

final class DetailViewModel {
    private weak var view: IDetailView?
    private var pokemonDetailResult: PokemonDetailResult
    
    init(view: IDetailView, pokemonDetailResult: PokemonDetailResult) {
        self.view = view
        self.pokemonDetailResult = pokemonDetailResult
    }
}

extension DetailViewModel: IDetailViewModel {
    var numberOfRowsInSection: Int {
        pokemonDetailResult.abilities.count
    }
    
    var heightForRowAt: Double {
        return Constant.cellHeight
    }
    
    func viewWillAppear() {
        
    }
    
    func didSelectRowAt(index: Int) {
        
    }
    
    
    func viewDidLoad() {
        view?.configureNavigationBar()
        view?.setUpUI()
        view?.setUI(model: pokemonDetailResult)
    }
    
    func getAbility(index: Int) -> Ability {
        self.pokemonDetailResult.abilities[index].ability
    }
}
