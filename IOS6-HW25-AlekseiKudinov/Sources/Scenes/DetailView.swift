//
//  DetailView.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 14.08.2022.
//

import UIKit

class DetailView: UIView {

    func configureView(with model: Character) {
        self.character = model
        self.setupCharacterData()
        self.setupImage()
    }

    var character: Character?

    private lazy var mainStackView = createStackView(axis: .vertical, distribution: .fill)

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var titleLabel = createLabel(size: 35, weight: .bold, multiline: false)
    private lazy var descriptionLabel = createLabel(size: 15, weight: .regular, multiline: true)
    private lazy var comicsTitleLabel = createLabel(size: 20, weight: .bold, multiline: false)

    private lazy var comicsTableView = UITableView(frame: self.bounds, style: UITableView.Style.grouped)

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupView()
        setupHierarchy()
        setupLayout()

        setupDataSource()
        setupTableCells()
    }

    private func setupView() {
        self.backgroundColor = .systemRed
    }

    private func setupHierarchy() {
        self.addSubview(imageView)

        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(descriptionLabel)

        self.addSubview(comicsTitleLabel)
        self.addSubview(comicsTableView)
    }

    private func setupLayout() {
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true

        comicsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsTitleLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 30).isActive = true
        comicsTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        comicsTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true

        comicsTableView.translatesAutoresizingMaskIntoConstraints = false
        comicsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        comicsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        comicsTableView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: 10).isActive = true
        comicsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setupDataSource() {
        comicsTableView.dataSource = self
    }

    private func setupTableCells() {
        comicsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "charactersTableCell")
    }

    private func setupImage() {
        character?.image?.getImage(size: .big, completion: { data in
            guard let character = data else { return }
            self.imageView.image = UIImage(data: character)
        })
    }

    private func setupCharacterData() {
        guard let character = character else { return }

        titleLabel.text = character.name
        descriptionLabel.text = character.description

        if character.comics?.items?.count ?? 0 > 0 {
            comicsTitleLabel.text = "Comics"
        }
    }

    private func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()

        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = 12

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func createLabel(size: CGFloat, weight: UIFont.Weight, multiline: Bool) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: size, weight: weight)
        if multiline {
            label.numberOfLines = 0
        }

        return label
    }
}

extension DetailView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character?.comics?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comic = character?.comics?.items?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersTableCell", for: indexPath)
        cell.textLabel?.text = comic?.name

        return cell
    }
}
