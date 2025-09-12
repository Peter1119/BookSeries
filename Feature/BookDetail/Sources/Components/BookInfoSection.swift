//
//  BookInfoSection.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/12/25.
//

import UIKit
import SnapKit
import Domain
import DesignSystem

public final class BookInfoSection: UIView {
    
    // MARK: - UI Components
    private let bookCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let authorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    private let releasedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Released"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let pagesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pages"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let pagesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
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
        // 저자 스택뷰 (Author + 저자명)
        let authorStackView = UIStackView(arrangedSubviews: [authorTitleLabel, authorLabel])
        authorStackView.axis = .horizontal
        authorStackView.spacing = 8
        authorStackView.alignment = .firstBaseline
        
        // 출간일 스택뷰 (Released + 출간일)
        let releaseDateStackView = UIStackView(arrangedSubviews: [releasedTitleLabel, releaseDateLabel])
        releaseDateStackView.axis = .horizontal
        releaseDateStackView.spacing = 8
        releaseDateStackView.alignment = .firstBaseline
        
        // 페이지 스택뷰 (Pages + 페이지수)
        let pagesStackView = UIStackView(arrangedSubviews: [pagesTitleLabel, pagesLabel])
        pagesStackView.axis = .horizontal
        pagesStackView.spacing = 8
        pagesStackView.alignment = .firstBaseline
        
        // 텍스트 정보들을 담는 수직 스택뷰
        let textInfoStackView = UIStackView(arrangedSubviews: [
            bookTitleLabel,
            authorStackView,
            releaseDateStackView,
            pagesStackView
        ])
        textInfoStackView.axis = .vertical
        textInfoStackView.spacing = 12
        textInfoStackView.alignment = .leading
        
        // 이미지와 텍스트 정보를 담는 메인 수평 스택뷰
        let bookInfoStackView = UIStackView(arrangedSubviews: [bookCoverImageView, textInfoStackView])
        bookInfoStackView.axis = .horizontal
        bookInfoStackView.spacing = 16
        bookInfoStackView.alignment = .top
        
        addSubview(bookInfoStackView)
        
        // 책 표지 이미지 크기 제약
        bookCoverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(150) // 1:1.5 비율
        }
        
        // 메인 스택뷰 레이아웃
        bookInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: BookDetailModel) {
        bookTitleLabel.text = viewModel.book.title
        authorLabel.text = viewModel.book.author
        releaseDateLabel.text = formatReleaseDate(viewModel.book.releaseDate)
        pagesLabel.text = "\(viewModel.book.pages)"
        
        // TODO: 실제 이미지 로딩 구현
        bookCoverImageView.image = viewModel.image
        bookCoverImageView.backgroundColor = .lightGray
    }
    
    private func formatReleaseDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return dateString
        }
        
        return outputFormatter.string(from: date)
    }
}
