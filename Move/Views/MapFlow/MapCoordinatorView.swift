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
            MapView(viewModel: viewModel.mapViewModel)
                .overlay {
                    navigationBar
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .overlay {
                    selectedScooterCard
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
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
        HStack {
            Button {
            } label: {
                Image("menu-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
            }
            .padding()
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
            .padding()
        }
        .buttonStyle(SmallButtonStyle())
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var selectedScooterCard: some View {
        if let scooter = viewModel.selectedScooter {
            ScooterDetailCardView(
                scooter: scooter,
                onUnlock: {
                    print("Unlock scooter with code \(scooter.code)")
                },
                onRing: {
                    if let currentCoordinate = viewModel.locationViewModel.location?.coordinate {
                        APIService.ringScooter(coordinate: currentCoordinate, scooter: scooter) { result in
                            switch result {
                                case .success(let result):
                                    print(result)
                                case .failure(let error):
                                    ErrorHandler.handle(error: error)
                            }
                        }
                    }
                },
                onRequestDirections: {
                    print("Directions to scooter with code \(scooter.code)")
                })
                .cornerRadius(29)
                .shadow(color: Color(white: 0, opacity: 0.3), radius: 30, x: 7, y: 7)
                .frame(width: 280, height: 340)
                .id(UUID())
                .transition(.opacity.combined(with: .scale))
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
        @Published var selectedScooter: Scooter?
        
        
        init() {
            let locationViewModel = LocationViewModel()
            self.locationViewModel = locationViewModel
            self.mapViewModel = MapViewModel(locationViewModel: locationViewModel)

            _ = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
                timer.tolerance = 2.0
                print("Refreshed scooter data")
                self.requestScooters()
            }
            self.mapViewModel.onSelectedScooter = { [weak self] scooter in
                self?.handleScooterSelection(scooter)
            }
        }
        
        func toggleMenu(visible: Bool) {
            withAnimation {
                showMenu = visible
            }
        }

        @objc func handleLocationChange() {
            guard let location = locationViewModel.location else {
                return
            }
            guard scooters.isEmpty else {
                return
            }
            requestScooters()
        }
        
        func handlePlacemarkChange() {
            self.objectWillChange.send()
        }
        
        func handleScooterSelection(_ scooter: Scooter) {
            withAnimation(.easeInOut) {
                self.selectedScooter = scooter
            }
            
        }
        
        func requestScooters() {
            guard let location = locationViewModel.location else {
                return
            }
            APIService.getGeocodedScooters(coordinate: location.coordinate) { result in
                switch result {
                case .success(let scooters):
                        self.scooters = scooters.filter({ scooter in
                            scooter.status == "available"
                        })
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
