//
//  HomeViewModel.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

protocol IHomeViewModel {
    var numberOfRowsInSection: Int { get }
    var heightForRowAt: Double { get }
    func viewDidLoad()
    func viewWillAppear()
    func removeAllPokemons()
    func fetchPokemons(text: String,completion: @escaping (() -> Void))
    func getPokemon(index: Int) -> Pokemon
    func filterPokemon(name: String)
    func didSelectRowAt(index: Int)
}

private extension HomeViewModel {
    enum Constant {
        static let cellHeight: Double = 140.0
    }
}

final class HomeViewModel {
    private weak var view: IHomeView?
    var pokemonList = [Pokemon]()
    private let apiManager: APIManagerProtocol
    
    init(view: IHomeView, storeManager: APIManagerProtocol = APIManager.shared) {
        self.view = view
        self.apiManager = storeManager
    }
    /// Selects the Pokemon. Thanks to the UIView protocol, it changes the page on the UI side.
    private func selectedPokemon(pokemonName: String) {
        let pokemon = pokemonList.filter {$0.name == pokemonName}
        if pokemon.first != nil{
            self.view?.openDetailView(result: pokemon.first!.detail!)
        }
    }
}


extension HomeViewModel: IHomeViewModel {
    
    
    var numberOfRowsInSection: Int {
        pokemonList.count
    }
    
    var heightForRowAt: Double {
        Constant.cellHeight
    }
    
    func viewDidLoad() {
        view?.setUpNavigationBar()
        view?.setUpUI()
        fetchPokemons(text: "",completion: {
            DispatchQueue.main.async {
                self.view?.closeCircularIndicator()
                self.view?.searchBarEnabled(isEnable: true)
                self.view?.emptyLabelIsHidden(isHidden: true)
                self.view?.refreshTable()
            }
        })
    }
    
    func viewWillAppear() {
        
    }
    
    func fetchPokemons(text: String, completion: @escaping (() -> Void)) {
        view?.showCircularIndicator()
        view?.searchBarEnabled(isEnable: false)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(500), execute: { [weak self] in
            self?.apiManager.apiRequest(endpoint: .pokemonSearchName(pokemonSearchName: text), type: PokemonResult.self, params: [:], completer: { result in
                switch result {
                case .success(let pokemonResults):
                    self?.pokemonList = pokemonResults.results ?? []
                    
                    //MARK: Synchronous code allows us to use asynchronous functions between blocks.
                    Task.detached{ [self] in
                        await self?.handlerImage(completer: {
                            completion()
                        })
                    }
                    
                case .failure(let error):
                    self?.view?.searchBarEnabled(isEnable: true)
                    self?.view?.closeCircularIndicator()
                    self?.view?.refreshTable()
                    self?.view?.showErrorDialog(text: error.rawValue)
                }
            })
        })
    }
    
    /// It fetch Pokemon pictures from the API and adds them to the parent model [Pokemon].
    func handlerImage(completer: @escaping () async -> Void) async{
        for i in 0...(self.pokemonList.count ) - 1 {
            do {
                let detail = try await self.apiManager.apiRequestWithAsync(endpoint:.pokemonSearchName(pokemonSearchName: (self.pokemonList[i].name!)), type: PokemonDetailResult.self, params: [:])
                self.pokemonList[i].imgUrl = detail?.sprites.front_default
                self.pokemonList[i].detail = detail
            } catch let error {
                self.view?.showErrorDialog(text: error.localizedDescription)
                break
            }
        }
        await completer()
    }
    
    
    func getPokemon(index: Int) -> Pokemon {
        pokemonList[index]
    }
    
    /// Filters according to the searched name among the pokemon fetch from the API.
    func filterPokemon(name: String) {
        view?.showCircularIndicator()
        view?.searchBarEnabled(isEnable: false)
        let filteredSearchList = pokemonList.filter{
            $0.name?.lowercased().contains(name.lowercased()) ?? false
        }
        self.view?.closeCircularIndicator()
        self.view?.searchBarEnabled(isEnable: true)
        self.view?.emptyLabelIsHidden(isHidden: true)
        self.view?.refreshTable()
        pokemonList = filteredSearchList
    }
    /// Clear Pokemon List.
    func removeAllPokemons() {
        pokemonList.removeAll()
    }
    
    func didSelectRowAt(index: Int) {
        selectedPokemon(pokemonName: pokemonList[index].name ?? "")
    }
}
