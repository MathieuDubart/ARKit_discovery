//
//  CustomARViewRepresentable.swift
//  ARKit_discovery
//
//  Created by Mathieu Dubart on 09/08/2024.
//

import ARKit
import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    // we never use update func so we leave it empty
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
