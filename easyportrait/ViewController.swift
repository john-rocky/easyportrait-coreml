//
//  ViewController.swift
//  easyportrait
//
//  Created by 間嶋大輔 on 2024/01/18.
//

import UIKit
import Vision

class ViewController: UIViewController {
    var request:VNCoreMLRequest!
    var easyPortraitRequest:VNCoreMLRequest!
    var faceParsingRequest:VNCoreMLRequest!
    var imageView = UIImageView()
    var partsIndex = -1
    var toggle = UISegmentedControl(items: ["easyportrait","face-parsing"])
    var timeLabel = UILabel()
    var isMultiParts = true
    let image = UIImage(named: "sample2")
    var classNames = ["lips","left brow", "background","teeth","right eye","skin","blank","left eye","right brow"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModels()
        setupView()
    }

    func setupModels() {
        
        let easyPortraitModel = try! easyportrait(configuration: MLModelConfiguration()).model
        let vnEasyPortraitModel = try! VNCoreMLModel(for: easyPortraitModel)
        easyPortraitRequest = VNCoreMLRequest(model: vnEasyPortraitModel)
        easyPortraitRequest.imageCropAndScaleOption = .scaleFill
        let faceParsingModel = try! skin(configuration: MLModelConfiguration()).model
        let vnFaceParsingModel = try! VNCoreMLModel(for: faceParsingModel)
        faceParsingRequest = VNCoreMLRequest(model: vnFaceParsingModel)
        faceParsingRequest.imageCropAndScaleOption = .scaleFill

        request = easyPortraitRequest
    }
    
    
    
    @objc func inference() {
        var text = ""
        if isMultiParts {
            partsIndex += 1
            if partsIndex > 8 {
                
                partsIndex = -1
                
                DispatchQueue.main.async {
                    self.imageView.image = self.image
                    self.timeLabel.text = "Please tap to inference"

                }
                return
            }
            text = classNames[partsIndex]

        } else {
            partsIndex = 0
            text = "skin"
        }
        DispatchQueue.main.async {
            self.imageView.image = self.image!
        }

        let ciImage = CIImage(image: image!)
        let handler = VNImageRequestHandler(ciImage: ciImage!)
        
        let startTime = Date()
        try! handler.perform([request])
        guard let result = request.results?[partsIndex] as? VNPixelBufferObservation else {fatalError()}
        // out0:lips
        // out1:left brow
        // out2:background
        // out3:teeth
        // out4:right eye
        // out5:skin
        // out6:blank
        // out7:left eye
        // out8:right brow

        let time = Date().timeIntervalSince(startTime)
        print(time)
        let resultCIImage = CIImage(cvPixelBuffer: result.pixelBuffer).resize(as: image!.size)
        let resultUIImage = UIImage(ciImage: resultCIImage)
        DispatchQueue.main.async {
            self.imageView.image = resultUIImage
            self.timeLabel.text = "\(text)\ntime: \(time)"
        }
    }
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(inference))
        view.addGestureRecognizer(tap)

        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.image
        view.addSubview(imageView)
        toggle.frame = CGRect(x: view.center.x-100, y: view.bounds.maxY - 100, width: 200, height: 50)
        view.addSubview(toggle)
        toggle.selectedSegmentIndex = 0
        toggle.addTarget(self, action: #selector(toggleTapped), for: .valueChanged)
        
        timeLabel.frame = CGRect(x: view.center.x-200, y: toggle.frame.minY - 150, width: 400, height: 100)
        timeLabel.textAlignment = .center
        timeLabel.textColor = .white
        timeLabel.numberOfLines = 2
        timeLabel.text = "Please tap to inference"
        view.addSubview(timeLabel)
    }
    
    
    @objc func toggleTapped(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            request = easyPortraitRequest
            isMultiParts = true
        } else {
            request = faceParsingRequest
            isMultiParts = false
        }
        DispatchQueue.main.async {
            self.imageView.image = self.image
            self.timeLabel.text = "Please tap to inference"
        }
    }


}

extension CIImage {
    func resize(as size: CGSize) -> CIImage {
        let selfSize = extent.size
        let transform = CGAffineTransform(scaleX: size.width / selfSize.width, y: size.height / selfSize.height)
        return transformed(by: transform)
    }
}
