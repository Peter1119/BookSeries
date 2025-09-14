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
    private var seriesOrderList: [Int] = []
    private var selectedSeriesOrder: Int?

    public var onSeriesSelected: ((Int) -> Void)?
    
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
        
        for seriesOrder in seriesOrderList {
            let button = UIButton(type: .system)
            button.setTitle("\(seriesOrder)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.backgroundColor = .systemGray5
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 20
            button.addAction(UIAction(handler: { [weak self] _ in
                self?.seriesButtonTapped(seriesOrder)
            }), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            seriesButtons.append(button)
            seriesStackView.addArrangedSubview(button)
        }
        
        // 첫 번째 버튼을 선택 상태로 설정
        if let firstSeries = seriesOrderList.first {
            updateButtonSelection(selectedSeriesOrder: firstSeries)
        }
    }
    
    private func seriesButtonTapped(_ order: Int) {
        updateButtonSelection(selectedSeriesOrder: order)
        onSeriesSelected?(order)
    }
    
    private func updateButtonSelection(selectedSeriesOrder: Int) {
        self.selectedSeriesOrder = selectedSeriesOrder
        
        for (index, button) in seriesButtons.enumerated() {
            if index < seriesOrderList.count && seriesOrderList[index] == selectedSeriesOrder {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .systemGray5
                button.setTitleColor(.black, for: .normal)
            }
        }
    }

    public func configure(
        with seriesOrders: [Int],
        currentTitle: String,
        selectedSeriesOrder: Int? = nil
    ) {
        self.seriesOrderList = seriesOrders
        titleLabel.text = currentTitle
        
        createSeriesButtons()
        
        if let selectedOrder = selectedSeriesOrder {
            updateButtonSelection(selectedSeriesOrder: selectedOrder)
        }
    }
}
