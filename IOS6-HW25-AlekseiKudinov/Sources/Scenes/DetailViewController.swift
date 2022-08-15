//
//  DetailViewController.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 14.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var model: Character?

    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = DetailView()
        self.configureView()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension DetailViewController: ModelDelegate {
    func configureView() {
        guard let model = model else { return }
        detailView?.configureView(with: model)
    }
}

