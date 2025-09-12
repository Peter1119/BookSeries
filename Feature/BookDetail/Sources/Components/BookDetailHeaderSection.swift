//
//  BookDetailHeaderSection.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/12/25.
//

import UIKit
import SnapKit
import Domain
import Foundation

public struct SeriesInfo {
    let id: UUID
    let seriesOrder: Int
}

public final class BookDetailHeaderSection: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let seriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var seriesButtons: [UIButton] = []
    private var seriesInfoList: [SeriesInfo] = []
    private var selectedSeriesId: UUID?

    public var onSeriesSelected: ((UUID) -> Void)?
    
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
        addSubview(titleLabel)
        addSubview(seriesStackView)

        createSeriesButtons()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        seriesStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func createSeriesButtons() {
        seriesButtons.removeAll()
        seriesStackView.arrangedSubviews.forEach {
            seriesStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        for seriesInfo in seriesInfoList {
            let button = UIButton(type: .system)
            button.setTitle("\(seriesInfo.seriesOrder)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.backgroundColor = .systemGray5
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 20
            button.addAction(UIAction(handler: { [weak self] _ in
                self?.seriesButtonTapped(seriesInfo.id)
            }), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            seriesButtons.append(button)
            seriesStackView.addArrangedSubview(button)
        }
        
        // 첫 번째 버튼을 선택 상태로 설정
        if let firstSeries = seriesInfoList.first {
            updateButtonSelection(selectedSeriesId: firstSeries.id)
        }
    }
    
    private func seriesButtonTapped(_ id: UUID) {
        updateButtonSelection(selectedSeriesId: id)
        onSeriesSelected?(id)
    }
    
    private func updateButtonSelection(selectedSeriesId: UUID) {
        self.selectedSeriesId = selectedSeriesId
        
        for (index, button) in seriesButtons.enumerated() {
            if index < seriesInfoList.count && seriesInfoList[index].id == selectedSeriesId {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .systemGray5
                button.setTitleColor(.black, for: .normal)
            }
        }
    }

    public func configure(
        with seriesInfoList: [SeriesInfo],
        currentTitle: String,
        selectedSeriesId: UUID? = nil
    ) {
        self.seriesInfoList = seriesInfoList
        titleLabel.text = currentTitle
        
        createSeriesButtons()
        
        if let selectedId = selectedSeriesId {
            updateButtonSelection(selectedSeriesId: selectedId)
        }
    }
}
