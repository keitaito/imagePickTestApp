//
//  ViewController.swift
//  imagePickTestApp
//
//  Created by Keita Ito on 6/26/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imageView = UIImageView()
    let locationLabel = UILabel()
    
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
        
        locationLabel.frame = CGRectMake(0, 64, self.view.frame.size.width, 44)
        locationLabel.backgroundColor = UIColor.lightGrayColor()
        locationLabel.textAlignment = .Center
        view.addSubview(locationLabel)
        
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
        let url = info[UIImagePickerControllerReferenceURL] as? NSURL
        guard let UnwrappedUrl = url else { return }
        let fetchResult = PHAsset.fetchAssetsWithALAssetURLs([UnwrappedUrl], options: nil)
        let asset = fetchResult.firstObject as? PHAsset
        let location = asset?.location
        if let l = location {
            print(l)
            let lat = l.coordinate.latitude
            let long = l.coordinate.longitude
            
            let latString = String(lat)
            let longString = String(long)
            locationLabel.text = "lat: \(latString), long: \(longString)"
        }
        
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

