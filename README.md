# Harry Potter Book Series

해리포터 시리즈 도서 정보를 확인할 수 있는 iOS 앱입니다.

## 📱 주요 기능

- **시리즈 도서 탐색**: 해리포터 시리즈 1-7권 정보 확인
- **상세 정보 보기**: 각 도서의 표지, 제목, 작가, 페이지 수, 출간일, 헌정사, 줄거리 확인
- **확장 가능한 줄거리**: 긴 줄거리는 "더보기/접기" 기능으로 편리하게 확인
- **상태 저장**: 줄거리 펼침 상태가 앱 재실행 후에도 유지
- **직관적인 UI**: 시리즈 버튼으로 쉽게 도서 간 이동

## 🏗️ 아키텍처

### Clean Architecture + MVVM
```
📱 Feature Layer (BookDetail)
    └── MVVM Pattern
    
🔧 Domain Layer
    ├── Entities (Book)
    ├── Use Cases (FetchBooks, ManageBookState)  
    └── Repositories (Abstract)
    
💾 Data Layer
    ├── Repositories (Concrete)
    ├── SwiftData Models (BookState)
    └── Local JSON Data
    
🎨 Design System
    └── Assets & Components
```

### 모듈 구조
- **BookSeriesApp**: 메인 앱
- **Feature/BookDetail**: 도서 상세 정보 기능
- **Domain**: 비즈니스 로직 및 엔터티
- **Data**: 데이터 접근 및 저장
- **DesignSystem**: UI 컴포넌트 및 리소스

## 🚀 실행 방법

```bash
# Xcode 프로젝트 생성
make generate

# 앱 실행
# BookSeriesApp 스킴 선택 후 실행
```

## 🛠️ 기술 스택

- **Language**: Swift 5.9
- **UI**: UIKit + SnapKit
- **Architecture**: Clean Architecture, MVVM
- **Data**: SwiftData (영구 저장), Local JSON
- **Build Tool**: Tuist
- **Minimum iOS**: 18.5+

## 📊 데이터 구조

앱은 로컬 JSON 파일에서 해리포터 시리즈 데이터를 로드합니다:
- 제목, 작가, 페이지 수, 출간일
- 헌정사 및 상세 줄거리
- 사용자의 UI 상태는 SwiftData로 영구 저장

## 🎯 개발 포인트

- **모듈화**: Tuist를 활용한 멀티모듈 구조로 확장성과 재사용성 확보
- **상태 관리**: 비동기 상태 관리를 통한 부드러운 사용자 경험
- **데이터 지속성**: SwiftData를 활용한 로컬 상태 저장
- **컴포넌트 기반 UI**: 재사용 가능한 UI 컴포넌트로 유지보수성 향상

---

*해리포터 시리즈의 모든 정보는 공개된 데이터를 바탕으로 구성되었습니다.*
