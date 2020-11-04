//
//  ViewController.swift
//  ARKitRobotDemo
//
//  Created by 陳裕銘 on 2019/10/21.
//  Copyright © 2019 yuming. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
class ViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    private var planes: [UUID:PlaneNode] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.debugOptions = [.showFeaturePoints]
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addRobot(recognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        sceneView.session.pause()
    }
    @objc func addRobot(recognizer:UITapGestureRecognizer)
    {
     let tapLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitResult = hitResults.first else{return}
        guard let scene = SCNScene(named:"art.scnassets/FatBoy.dae") else{return}
        print("tapDid")
        let node = SCNNode()
        for childNode in scene.rootNode.childNodes
        {
            node.addChildNode(childNode)
        }
        node.pivot = SCNMatrix4MakeTranslation(0, 0,0)
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x,  hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        node.scale = SCNVector3(0.0005, 0.0005, 0.0005)
        node.rotation = SCNVector4(0, 1, 0, (0.15 * Float.pi))
        node.rotation = SCNVector4(1, 0, 0, (-0.2 * Float.pi))
        sceneView.scene.rootNode.addChildNode(node)
    }
   
    
   
}




extension ViewController: ARSCNViewDelegate
{
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("Surface Detected!!")
        
        if let planeAnchor = anchor as? ARPlaneAnchor
        {
           let planeNode = PlaneNode(anchor: planeAnchor)
            planes[anchor.identifier] = planeNode
            
            
            node.addChildNode(planeNode)
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, let plane = planes[anchor.identifier] else {return}
        
        plane.update(anchor: planeAnchor)
    }
    
}
