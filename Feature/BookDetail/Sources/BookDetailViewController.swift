//
//  BookDetailViewController.swift
//  TestApp
//
//  Created by TestDev on 09-11-25.
//  Copyright © 2025 TestDev. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

public class BookDetailViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let image = DesignSystemAsset.harrypotter1
        let imageView = UIImageView(image: image.image)
        view.backgroundColor = .systemBackground
        title = "BookDetail"
        
        let label = UILabel()
        label.text = "BookDetail Feature"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
