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

    @State var time: Float = 1
    @State var dome: Entity?
    
    var body: some View {
        VStack {
            RealityView { content in
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    self.dome = scene.findEntity(named: "Dome_geometry")
                    content.add(scene)
                }
            }
            VStack {
                HStack {
                    Image(systemName: "timer")
                    Slider(value: $time, in: -1...1)
                        .onChange(of: time) { oldValue, newValue in
                           updateTime(time: newValue)
                    }
                }
            }
        }
    }
    
    func updateTime(time:Float){
        updateMaterial(entity: self.dome) { material in
            try? material.setParameter(name: "Time", value: .float(time))
        }
    }
    
    func updateMaterial(entity:Entity?, callback:@escaping (inout ShaderGraphMaterial)->Void) {
        guard var modelComponent = entity?.components[ModelComponent.self] else { return }
        
        guard var material = modelComponent.materials.first as? ShaderGraphMaterial else { return }
        
        callback(&material)
        
        modelComponent.materials = [material]
        entity?.components.set(modelComponent)
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
