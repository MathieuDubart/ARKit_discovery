//
//  ContentView.swift
//  ARKit_discovery
//
//  Created by Mathieu Dubart on 09/08/2024.
//

import SwiftUI

enum FileType: String {
    case usdz, reality
}

struct ContentView: View {
    @State private var models: [String] = [
        "biplane",
        "guitare",
        "robot",
        "tv",
        "lunar_rover",
        "cosmonaut_suit",
        "skateboard",
        "rocket"
    ]
    
    var body: some View {
        VStack {
            CustomARViewRepresentable()
                .ignoresSafeArea()
                .overlay(alignment: .bottom) {
                    ScrollView(.horizontal) {
                        HStack {
                            Button {
                                ARManager.shared.actionStream.send(.removeAllAnchors)
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(.regularMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            
                            ForEach(models, id:\.self) { model in
                                Button {
                                    ARManager.shared.actionStream.send(.placeModel(model))
                                } label: {
                                    Text("\(model)")
                                        .frame(width: 40, height: 40)
                                        .padding()
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                            }
                        }
                        .padding()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
