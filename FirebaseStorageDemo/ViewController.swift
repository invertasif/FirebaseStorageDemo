//
//  ViewController.swift
//  FirebaseStorageDemo
//
//  Created by Asif Ikbal on 5/21/17.
//  Copyright © 2017 Asif Ikbal. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    var storageRef:FIRStorageReference?

    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    @IBAction func uploadAction(_ sender: Any) {
        
        let imagePiockerController = UIImagePickerController()
        imagePiockerController.delegate = self
        imagePiockerController.sourceType = .photoLibrary
        
        present(imagePiockerController, animated: true) {
            print("Picker presented")
        }
        
    }
    
    @IBAction func uploadToFirebase(_ sender: Any) {
        
        
        storageRef = FIRStorage.storage().reference().child("images/image.jpg")
        
       // let ref = storageRef?.child("images/image.jpg")
        
        let storageMetadata = FIRStorageMetadata()
        storageMetadata.contentType = "image/jpg"
        
        guard let image = imageViewOutlet.image else {
            return
        }
        let uploadData = UIImagePNGRepresentation(image)
        storageRef?.put(uploadData!, metadata: storageMetadata, completion: { (metadata, error) in
            
            if  (error == nil){
            
                print("image uploaded")
                print(metadata?.downloadURL())
            } else {
                print(error?.localizedDescription)
            }
        })

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("Cancel")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("..........................")
        print(info)
        print("..........................")
        
        let imageSelected = info["UIImagePickerControllerOriginalImage"]
        
        imageViewOutlet.image = imageSelected as? UIImage
        dismiss(animated: true, completion: nil)

    }
    
    
    
    


}

