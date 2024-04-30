//
//  ContentView.swift
//  iOS-study-0514
//
//  Created by 中口 翔太（Shota Nakaguchi） on 2024/04/30.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    var body: some View {
        VStack {
            RealityView { content in
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
