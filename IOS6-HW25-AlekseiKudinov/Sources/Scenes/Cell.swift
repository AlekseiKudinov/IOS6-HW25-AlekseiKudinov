//
//  Cell.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 15.08.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    static let identifier = "DefaultTableViewCell"

    public func configureCell(with model: Character) {
        textLabel?.text = model.name
        detailTextLabel?.text = model.description

        model.image?.getImage(size: .small, completion: { data in
            guard let data = data else { return }
            self.imageView?.image = UIImage(data: data)
        })
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        imageSetup()
        accessoryType = .disclosureIndicator
    }

    private func imageSetup() {
        imageView?.layer.masksToBounds = true
        imageView?.layer.cornerRadius = 7
    }
}
