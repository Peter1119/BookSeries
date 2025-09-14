import UIKit
import Domain
import Data
import BookDetailFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

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
        let bookStateRepository = LocalBookStateRepository()
        let viewModel = BookDetailViewModel(
            fetchBookUseCase: FetchBooks(repository: booksRepository),
            manageBookStateUseCase: ManageBookState(repository: bookStateRepository)
        )
        window?.rootViewController = BookDetailViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}
