//
//  ARManager.swift
//  ARKit_discovery
//
//  Created by Mathieu Dubart on 09/08/2024.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init() {}
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
