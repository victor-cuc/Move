//
//  MoveApp.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI
import Combine
import NavigationStack

@main
struct MoveApp: App {
    
    var onLogoutPublisher: PassthroughSubject<Void, Never> = Session.shared.onLogout
    
    @StateObject var navigationStackViewModel = NavigationStack()
    
    var body: some Scene {
        WindowGroup {
            NavigationStackView(navigationStack: navigationStackViewModel) {
                if Session.shared.isActive {
                    MapCoordinatorView()
                } else {
                    onboardingFlow
                }
            }
            .onReceive(onLogoutPublisher) { _ in
                navigationStackViewModel.pop(to: PopDestination.root)
                navigationStackViewModel.objectWillChange.send()
            }
        }
    }
    
    func handleAuthFlow() {
        let view = AuthCoordinator(onFinished: {
            navigationStackViewModel.push(MapCoordinatorView(), withId: MapCoordinatorView.id)
        })
        navigationStackViewModel.push(view, withId: AuthCoordinator.id)
    }
    
    var onboardingFlow: some View {
        OnboardingView(onFinished: {
            handleAuthFlow()
        })
    }
}
