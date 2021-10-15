//
//  MoveApp.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

//class MainViewModel: ObservableObject {
//    
//    
//}

@main
struct MoveApp: App {
    @State var showAuthFlow: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    OnboardingView(onFinished: {
                        showAuthFlow = true
                    })
                    NavigationLink(isActive: $showAuthFlow, destination: {
                        OnboardingCoordinatorView {
                            print("continue flow")
                        }
                        .navigationBarHidden(true)
                    })
                }
            }
        }
    }
}
