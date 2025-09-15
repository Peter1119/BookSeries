//
//  ChaptersSection.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/12/25.
//

import UIKit
import SnapKit
import Domain

public final class ChaptersSection: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chapters"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let chaptersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, chaptersStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.alignment = .leading
        
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    public func configure(with chapters: [Chapter]) {
        // 기존 챕터 라벨들 제거
        chaptersStackView.arrangedSubviews.forEach {
            chaptersStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        // 새로운 챕터 라벨들 추가
        chapters.forEach { chapter in
            let chapterLabel = UILabel()
            chapterLabel.text = chapter.title
            chapterLabel.font = UIFont.systemFont(ofSize: 14)
            chapterLabel.textColor = .darkGray
            chapterLabel.numberOfLines = 0
            
            chaptersStackView.addArrangedSubview(chapterLabel)
        }
    }
}
