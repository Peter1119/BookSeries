import UIKit
import SwiftData
import Domain
import Data
import BookDetailFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private lazy var modelContainer: ModelContainer = {
        let container: ModelContainer
        do {
            container = try ModelContainer(for: BookState.self)
        } catch {
            fatalError("모델 컨테이너를 생성하지 못했습니다: \(error)")
        }
        return container
    }()
    
    func scene(
        _ scene: UIScene, 
        willConnectTo session: UISceneSession, 
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let booksRepository: BooksRepository = LocalBooksRepository(
            dataLoader: LocalFileLoader(),
            decoder: JSONDataDecoder()
        )
        let modelContext = modelContainer.mainContext
        let bookStateRepository = LocalBookStateRepository(modelContext: modelContext)
        let viewModel = BookDetailViewModel(
            fetchBookUseCase: FetchBooks(repository: booksRepository),
            manageBookStateUseCase: ManageBookState(repository: bookStateRepository)
        )
        window?.rootViewController = BookDetailViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}
