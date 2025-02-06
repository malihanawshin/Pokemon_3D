//
//  ViewController.swift
//  Poke_3D
//
//  Created by Maliha on 6/2/25.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()//ARWorldTrackingConfiguration()

        if let imagetoTrack = ARReferenceImage.referenceImages(inGroupNamed: "pokemon_cards", bundle: Bundle.main){
            configuration.trackingImages = imagetoTrack
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Images added")
        }
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: any SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            
            print(imageAnchor.referenceImage.name ?? "image not detected")
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "eevee" {
                if let pokescene = SCNScene(named: "art.scnassets/eevee.scn"){
                    if let pokenode = pokescene.rootNode.childNodes.first {
                        pokenode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(pokenode)
                    }
                }
            }
        
            else if imageAnchor.referenceImage.name == "oddish" {
                if let pokescene = SCNScene(named: "art.scnassets/oddish.scn"){
                    if let pokenode = pokescene.rootNode.childNodes.first {
                        pokenode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(pokenode)
                    }
                }
            }
            
            
        }
        
        return node
    }
    
}
