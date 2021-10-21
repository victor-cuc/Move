//
//  MapCoordinator.swift
//  Move
//
//  Created by Victor Cuc on 20/10/2021.
//

import SwiftUI
import NavigationStack

struct MapCoordinatorView: View {
    
    static let id = String(describing: Self.self)

    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    navigationBar
                    MapView()
                }
                MenuView()
                    .offset(x: viewModel.showMenu ? 0 : -proxy.size.width )
            }
        }
    }
    
    var navigationBar: some View {
        Button {
            viewModel.toggleMenu(visible: true)
        } label: {
            Text("Menu")
        }
        .frame(maxWidth: .infinity)
    }
}

extension MapCoordinatorView {
    
    class ViewModel: ObservableObject {
        
        @Published var showMenu: Bool = false
        
        func toggleMenu(visible: Bool) {
            withAnimation {
                showMenu = visible
            }
        }
    }
}

struct MapCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        MapCoordinatorView()
    }
}
