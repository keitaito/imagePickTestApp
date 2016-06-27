//
//  ViewController.swift
//  imagePickTestApp
//
//  Created by Keita Ito on 6/26/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imageView = UIImageView()
    
    var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let toolBar = UIToolbar()
        toolBar.frame = CGRectMake(0, self.view.frame.maxY - 44, self.view.frame.size.width, 44);
        toolBar.backgroundColor = UIColor.redColor()
        
        let barButtonItem = UIBarButtonItem(title: "Photo Libarary", style: .Plain, target: self, action: #selector(didTapButton(_:)))
        
        toolBar.items = [barButtonItem]
        view.addSubview(toolBar)
        
        imageView.frame = self.view.bounds
        imageView.contentMode = .ScaleAspectFit
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didTapButton(sender: UIBarButtonItem) -> Void {
        print("DidTapButton:")
        guard UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) else { return }
        showImagePicker(for_: .PhotoLibrary)
    }
    
    func showImagePicker(for_ sourceType: UIImagePickerControllerSourceType) -> Void {
        let imagePickerController = UIImagePickerController()
        imagePickerController.modalPresentationStyle = .CurrentContext
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        
        switch sourceType {
        case .Camera:
            return
        case .SavedPhotosAlbum:
            return
        case .PhotoLibrary:
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

