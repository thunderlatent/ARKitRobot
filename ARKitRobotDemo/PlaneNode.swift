//
//  PlaneNode.swift
//  ARKitRobotDemo
//
//  Created by 陳裕銘 on 2019/10/21.
//  Copyright © 2019 yuming. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
class PlaneNode: SCNNode{
    private var anchor: ARPlaneAnchor!
    private var plane: SCNPlane!
    init(anchor: ARPlaneAnchor!) {
        super.init()
        self.anchor = anchor
        
        self.plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        self.plane.materials.first?.diffuse.contents = UIColor(r: 90, g: 200, b: 250, alpha: 0.5)
        
        self.geometry = plane
        self.position = SCNVector3(anchor.center.x, 0.0, anchor.center.z)
        self.eulerAngles.x = -Float.pi / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(anchor:ARPlaneAnchor)
    {
        self.anchor = anchor
        plane.width = CGFloat(anchor.extent.x)
        plane.height = CGFloat(anchor.extent.z)
        
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    }
    
}
