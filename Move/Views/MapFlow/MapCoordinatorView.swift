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
                    MapView(viewModel: viewModel.mapViewModel)
                }
                MenuView()
                    .offset(x: viewModel.showMenu ? 0 : -proxy.size.width )
            }
        }
        .onReceive(viewModel.locationViewModel.objectDidChange) { _ in
            viewModel.handleLocationChange()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.locationViewModel.requestAuthorization()
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
        
        @Published var scooters: [Scooter] = [] {
            didSet {
                mapViewModel.scooters = scooters
            }
        }
        @Published var showMenu: Bool = false
        @Published var locationViewModel: LocationViewModel
        @Published var mapViewModel: MapViewModel
        
        init() {
            let locationViewModel = LocationViewModel()
            self.locationViewModel = locationViewModel
            self.mapViewModel = MapViewModel(locationViewModel: locationViewModel)
        }
        
        func toggleMenu(visible: Bool) {
            withAnimation {
                showMenu = visible
            }
        }

        func handleLocationChange() {
            guard let location = locationViewModel.location else {
                return
            }
            guard scooters.isEmpty else {
                return
            }
            APIService.getScooters(coordinate: location.coordinate) { result in
                switch result {
                case .success(let scooters):
                    self.scooters = scooters
                case .failure(let error):
                    ErrorHandler.handle(error: error)
                }
            }
        }
    }
}

struct MapCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        MapCoordinatorView()
    }
}
