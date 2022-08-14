//
//  MainView.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 14.08.2022.
//

import UIKit

class MainView: UIView {

    var model = [Character]()
    var delegate: MainViewDelegate?
    lazy var charactersTableView = UITableView(frame: self.bounds, style: UITableView.Style.plain)

    func configureView(with model: [Character]) {
        self.model = model
        charactersTableView.reloadData()
    }

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
        setupDataSource()
        setupDelegate()
        setupTableCells()
    }

    private func setupHierarchy() {
        self.addSubview(charactersTableView)
    }

    private func setupLayout() {
        charactersTableView.addConstraints(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor)
    }

    private func setupView() {
        self.backgroundColor = .white
    }

    private func setupDataSource() {
        charactersTableView.dataSource = self
    }

    private func setupDelegate() {
        charactersTableView.delegate = self
    }

    private func setupTableCells() {
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = model[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCell(with: model)
        return cell
    }
}

extension MainView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let character = model[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)

        delegate?.changeViewController(with: character)
    }
}

protocol MainViewDelegate {
    func changeViewController(with character: Character)
}

