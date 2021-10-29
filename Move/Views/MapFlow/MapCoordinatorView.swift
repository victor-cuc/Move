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
//                    navigationBar
                    MapView(viewModel: viewModel.mapViewModel)
                }
                overlay
//                MenuView()
//                    .offset(x: viewModel.showMenu ? 0 : -proxy.size.width )
            }
        }
        .onReceive(viewModel.locationViewModel.objectDidChange) { _ in
            viewModel.handleLocationChange()
            viewModel.handlePlacemarkChange()
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
    
    var overlay: some View {
        VStack {
            HStack {
                Button {
                } label: {
                    Image("menu-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                }
                Spacer()
                Text(viewModel.locationViewModel.placemark?.locality ?? "")
                    .font(.Custom.semibold.with(size: 17))
                    .foregroundColor(Constants.Colors.primaryTextColor)
                Spacer()
                Button {
                    viewModel.mapViewModel.userTrackingMode = .follow
                } label: {
                    Image("current-location-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
            .buttonStyle(SmallButtonStyle())
            .padding()
            
            Spacer()
        }
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
        
        func handlePlacemarkChange() {
            self.objectWillChange.send()
        }
    }
}

struct MapCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        MapCoordinatorView()
    }
}
