//
//  MainController.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 14.08.2022.
//

import UIKit

class MainController: UIViewController {

    var model: [Character]?
    var characters: [Character]?

    private let networkProvider = NetworkProvider()

    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }

    private lazy var searchController: UISearchController = {
        var search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Enter character name"

        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view = MainView()
        setupNavigation()
        setupSeach()

        searchController.searchBar.delegate = self
        configureViewDelegate()
        configureNetworkProviderDelegate()

        networkProvider.fetchData(characterName: nil) { characters in
            self.model = characters
            self.characters = characters
            self.configureView()
        }
    }
}

extension MainController {
    private func setupNavigation() {
        navigationItem.title = "Marvel characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Search

extension MainController {
    private func setupSeach() {
        navigationItem.searchController = searchController
    }
}

extension MainController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let characterName = searchController.searchBar.text else { return }
        networkProvider.fetchData(characterName: characterName) { characters in
            self.model = characters
            self.configureView()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = nil
        searchController.searchBar.resignFirstResponder()
        model = characters
        configureView()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard characters != nil,
              searchController.searchBar.text == ""
        else { return }
        self.model = characters
        self.configureView()
    }
}

extension MainController: NetworkProviderDelegate {
    func showAlert(message: String?) {
        let alert = UIAlertController(title: "Error",
                                      message: message != nil ? message : "Wrong request",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainController: MainViewDelegate {
    func changeViewController(with character: Character) {
        let detailViewController = DetailViewController()
        detailViewController.model = character

        detailViewController.modalPresentationStyle = .popover
        detailViewController.modalTransitionStyle = .coverVertical
        navigationController?.present(detailViewController, animated: true, completion: nil)
    }
}

extension MainController: ModelDelegate {
    func configureView() {
        guard let model = model else { return }
        mainView?.configureView(with: model)
    }
}

private extension MainController {
    func configureViewDelegate() {
        mainView?.delegate = self
    }

    func configureNetworkProviderDelegate() {
        networkProvider.delegate = self
    }
}

