//
//  ContentView.swift
//  ARKit_discovery
//
//  Created by Mathieu Dubart on 09/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var colors: [Color] = [
        .green,
        .blue,
        .yellow,
        .orange,
        .purple
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
                            
                            ForEach(colors, id:\.self) { color in
                                Button {
                                    ARManager.shared.actionStream.send(.placeBlock(color: color))
                                } label: {
                                    color
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
