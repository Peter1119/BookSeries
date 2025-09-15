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
    
    // MARK: - Properties
    private let viewModel: BookDetailViewModel
    
    // MARK: - UI Components
    private let headerSection = BookDetailHeaderSection()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        return stackView
    }()
    
    private let bookInfoSection = BookInfoSection()
    private let dedicationSection = DedicationSection()
    private let summarySection = SummarySection()
    private let chaptersSection = ChaptersSection()
    
    // MARK: - Initializers
    public init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Lifecycle
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "BookDetail"
        
        setupLayout()
        loadBookData()
    }
    
    private func setupLayout() {
        // Header section 추가 (고정)
        view.addSubview(headerSection)
        
        // ScrollView 추가
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        // ContentStackView에 섹션들 추가
        contentStackView.addArrangedSubview(bookInfoSection)
        contentStackView.addArrangedSubview(dedicationSection)
        contentStackView.addArrangedSubview(summarySection)
        contentStackView.addArrangedSubview(chaptersSection)
        
        // Header section 레이아웃 (고정 영역)
        headerSection.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        // ScrollView 레이아웃 (스크롤 가능 영역)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerSection.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        // ContentStackView 레이아웃
        contentStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.leading.trailing.equalTo(scrollView).inset(20)
            $0.width.equalTo(scrollView).offset(-40)
        }
    }
    
    private func loadBookData() {
        Task {
            do {
                let books = try await viewModel.fetchBooks()
                await MainActor.run {
                    updateUI(with: books)
                }
            } catch {
                
            }
        }
    }
    
    private func updateUI(with models: [BookDetailModel]) {
        guard let currentModel = viewModel.getCurrentModel() else { return }
        headerSection.configure(
            with: models.map { $0.seriesOrder },
            currentTitle: currentModel.book.title,
            selectedSeriesOrder: currentModel.seriesOrder
        )
        
        headerSection.onSeriesSelected = { [weak self] order in
            self?.switchToModel(with: order)
        }
        
        summarySection.onExpandStateChanged = { [weak self] (order, isExpanded) in
            self?.viewModel.setSummaryExpandState(for: order, isExpanded: isExpanded)
        }
        
        updateContentSections(with: currentModel)
    }
    
    private func switchToModel(with order: Int) {
        // ViewModel에서 모델 선택
        viewModel.selectModel(by: order)
        
        // 선택된 모델로 UI 업데이트
        guard let selectedModel = viewModel.getModel(by: order) else { return }
        
        let allModels = viewModel.getAllBookModels()

        // 헤더의 제목 업데이트 (경량화된 데이터 사용)
        headerSection.configure(
            with: allModels.map(\.seriesOrder),
            currentTitle: selectedModel.book.title,
            selectedSeriesOrder: selectedModel.seriesOrder
        )
        
        // 콘텐츠 섹션들 업데이트
        updateContentSections(with: selectedModel)
    }
    
    private func updateContentSections(with model: BookDetailModel) {
        bookInfoSection.configure(with: model)
        dedicationSection.configure(with: model.book.dedication)
        summarySection.configure(
            with: model.book.summary,
            seriesOrder: model.seriesOrder,
            isExpanded: model.isSummaryExpanded
        )
        chaptersSection.configure(with: model.book.chapters)
    }
}
