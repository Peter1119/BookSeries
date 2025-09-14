//
//  SummarySection.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/12/25.
//

import UIKit
import SnapKit
import Domain

public final class SummarySection: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isHidden = true
        return button
    }()
    
    // 상태 관리
    private var fullText: String = ""
    private var isExpanded: Bool = false
    private let characterLimit = 450
    private var seriesOrder: Int?
    
    public var onExpandStateChanged: ((Int, Bool) -> Void)?
    
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
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                contentLabel
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        addSubview(stackView)
        addSubview(toggleButton)
        
        toggleButton.addAction(UIAction(handler: { [weak self] _ in
            self?.toggleExpanded()
        }), for: .touchUpInside)
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        // Toggle button을 우측 하단에 배치
        toggleButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    public func configure(
        with summary: String,
        seriesOrder: Int,
        isExpanded: Bool = false
    ) {
        self.fullText = summary
        self.seriesOrder = seriesOrder
        self.isExpanded = isExpanded
        
        updateContent()
    }
    
    // MARK: - Private Methods
    private func updateContent() {
        let needsTruncation = fullText.count > characterLimit
        if needsTruncation {
            toggleButton.isHidden = false
            
            if isExpanded {
                contentLabel.text = fullText
                toggleButton.setTitle("접기", for: .normal)
            } else {
                let trimmedText = String(fullText.prefix(characterLimit)) + "…"
                contentLabel.text = trimmedText
                toggleButton.setTitle("더보기", for: .normal)
            }
        } else {
            toggleButton.isHidden = true
            contentLabel.text = fullText
        }
    }
    
    private func toggleExpanded() {
        isExpanded.toggle()
        updateContent()
        
        if let seriesOrder = seriesOrder {
            onExpandStateChanged?(seriesOrder, isExpanded)
        }
    }
}
