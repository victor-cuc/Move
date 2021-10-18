//
//  DocScanner.swift
//  Move
//
//  Created by Victor Cuc on 18/10/2021.
//

import SwiftUI
import VisionKit
//import UIKit

struct ScannerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
     
    typealias UIViewControllerType = VNDocumentCameraViewController
     
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
     
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScannerView>) {}
     
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
     
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: ScannerView
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            parent.image = scan.imageOfPage(at: 0)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
