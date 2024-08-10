//
//  CustomARView.swift
//  ARKit_discovery
//
//  Created by Mathieu Dubart on 09/08/2024.
//

import ARKit
import Combine
import RealityKit
import SwiftUI

// Creation of a custom view instead of using ARView so we can implement new fonctionnalities.
class CustomARView: ARView {
    enum ConfigurationType: String {
        case world, geo, face, bodies
    }
    
    enum AnchorsType: String {
        case worldZero, planeHorizontal, planeVertical, face, image
    }
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    // we will never decode the class so we dont need to implement it.
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // the init we will really use
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .placeModel(let model): self?.placeModel(model)
                case .removeAllAnchors: self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    func placeModel(_ model: String) {
        let anchor = AnchorEntity(plane: .horizontal)
        
        guard let entity = try? Entity.load(named: model) else {
            return
        }
        
        anchor.addChild(entity)
        
        scene.addAnchor(anchor)
        
    }
    
    /*
     
     func configurationsExamples(type: ConfigurationType) {
         let configuration: ARConfiguration
         
         switch type {
             //Tracks the device relative to it's environment
         case .world: configuration = ARWorldTrackingConfiguration()
             //Not supported in all regions, tracks w.r.t. global coordinates
         case .geo: configuration = ARGeoTrackingConfiguration()
             //Tracks faces in scene
         case .face: configuration = ARFaceTrackingConfiguration()
             //Tracks bodies in scene
         case .bodies: configuration = ARBodyTrackingConfiguration()
             
         }
         
         session.run(configuration)
     }
     
     func anchorsExamples(_ anchor: AnchorsType) {
         let coordinateAnchor: AnchorEntity
         
         switch anchor {
             //Attach anchors at speicif coordinates in the iPhone-centered coordinates system
         case .worldZero: coordinateAnchor = AnchorEntity(world: .zero)
             //Attach anchors to detected planes (works better on devices woth a LIDAR sensor)
         case .planeHorizontal: coordinateAnchor = AnchorEntity(plane: .horizontal)
         case .planeVertical: coordinateAnchor = AnchorEntity(plane: .vertical)
             //Attach anchors to tracked body parts, such as face
         case .face: coordinateAnchor = AnchorEntity(.face)
             //Attach anchors to tracked images, such as markers or visual codes
         case .image: coordinateAnchor = AnchorEntity(.image(group: "group", name: "name"))
         }
         
         scene.addAnchor(coordinateAnchor)
     }
     
     func entityExample() {
         //Load an entity from usdz file
         let _ = try? Entity.load(named: "usdzFileName")
         
         //Load an entity from a reality file
         let _ = try? Entity.load(named: "ralityFileName")
         
         //Generate an entity with code
         let box = MeshResource.generateBox(size: 1)
         let entity = ModelEntity(mesh: box)
         
         //Add entity to an anchor, so it's placed in the scene
         let anchor = AnchorEntity()
         anchor.addChild(entity)
     }
     */
}
