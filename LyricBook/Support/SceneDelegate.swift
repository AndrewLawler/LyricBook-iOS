//
//  SceneDelegate.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // creating out UIWindow and using the windowScene to create this
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        // setting the root as the tab bar controller and then making it visible
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }
    
    // creating the Search Navigation Controller
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchSongVC()
        searchVC.title = "Search Song"
        // tag = pos on the tab bar
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    // creating the Favorites Navigation Controller
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavouriteSongsVC()
        favoritesVC.title = "Favourite Songs"
        // tag = pos on the tab bar
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    // creating the actual tab bar controller
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        // setting the tab bar tint color
        UITabBar.appearance().tintColor = .systemRed
        // adding the tabbarview controllers as an array of Navigation Controllers which hold View Controllers
        tabbar.viewControllers = [createSearchNC(), createFavoritesNC()]
        return tabbar
    }

    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemRed
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

