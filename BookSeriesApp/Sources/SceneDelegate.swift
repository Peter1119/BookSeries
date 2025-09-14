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
        let repository: BooksRepository = LocalBooksRepository(
            dataLoader: LocalFileLoader(),
            decoder: JSONDataDecoder()
        )
        let useCase = FetchBooks(repository: repository)
        let viewModel = BookDetailViewModel(fetchBookUseCase: useCase)
        window?.rootViewController = BookDetailViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}
