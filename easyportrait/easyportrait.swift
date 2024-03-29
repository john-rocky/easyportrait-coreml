//
// easyportrait.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
class easyportraitInput : MLFeatureProvider {

    /// image as color (kCVPixelFormatType_32BGRA) image buffer, 512 pixels wide by 512 pixels high
    var image: CVPixelBuffer

    var featureNames: Set<String> {
        get {
            return ["image"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "image") {
            return MLFeatureValue(pixelBuffer: image)
        }
        return nil
    }
    
    init(image: CVPixelBuffer) {
        self.image = image
    }

    convenience init(imageWith image: CGImage) throws {
        self.init(image: try MLFeatureValue(cgImage: image, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    convenience init(imageAt image: URL) throws {
        self.init(image: try MLFeatureValue(imageAt: image, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    func setImage(with image: CGImage) throws  {
        self.image = try MLFeatureValue(cgImage: image, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

    func setImage(with image: URL) throws  {
        self.image = try MLFeatureValue(imageAt: image, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

}


/// Model Prediction Output Type
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
class easyportraitOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// out0 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out0: CVPixelBuffer {
        return self.provider.featureValue(for: "out0")!.imageBufferValue!
    }

    /// out1 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out1: CVPixelBuffer {
        return self.provider.featureValue(for: "out1")!.imageBufferValue!
    }

    /// out2 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out2: CVPixelBuffer {
        return self.provider.featureValue(for: "out2")!.imageBufferValue!
    }

    /// out3 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out3: CVPixelBuffer {
        return self.provider.featureValue(for: "out3")!.imageBufferValue!
    }

    /// out4 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out4: CVPixelBuffer {
        return self.provider.featureValue(for: "out4")!.imageBufferValue!
    }

    /// out5 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out5: CVPixelBuffer {
        return self.provider.featureValue(for: "out5")!.imageBufferValue!
    }

    /// out6 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out6: CVPixelBuffer {
        return self.provider.featureValue(for: "out6")!.imageBufferValue!
    }

    /// out7 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out7: CVPixelBuffer {
        return self.provider.featureValue(for: "out7")!.imageBufferValue!
    }

    /// out8 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var out8: CVPixelBuffer {
        return self.provider.featureValue(for: "out8")!.imageBufferValue!
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(out0: CVPixelBuffer, out1: CVPixelBuffer, out2: CVPixelBuffer, out3: CVPixelBuffer, out4: CVPixelBuffer, out5: CVPixelBuffer, out6: CVPixelBuffer, out7: CVPixelBuffer, out8: CVPixelBuffer) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["out0" : MLFeatureValue(pixelBuffer: out0), "out1" : MLFeatureValue(pixelBuffer: out1), "out2" : MLFeatureValue(pixelBuffer: out2), "out3" : MLFeatureValue(pixelBuffer: out3), "out4" : MLFeatureValue(pixelBuffer: out4), "out5" : MLFeatureValue(pixelBuffer: out5), "out6" : MLFeatureValue(pixelBuffer: out6), "out7" : MLFeatureValue(pixelBuffer: out7), "out8" : MLFeatureValue(pixelBuffer: out8)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
class easyportrait {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "easyportrait", withExtension:"mlmodelc")!
    }

    /**
        Construct easyportrait instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of easyportrait.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `easyportrait.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration = MLModelConfiguration()) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct easyportrait instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct easyportrait instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<easyportrait, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct easyportrait instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> easyportrait {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct easyportrait instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<easyportrait, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(easyportrait(model: model)))
            }
        }
    }

    /**
        Construct easyportrait instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> easyportrait {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return easyportrait(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as easyportraitInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as easyportraitOutput
    */
    func prediction(input: easyportraitInput) throws -> easyportraitOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as easyportraitInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as easyportraitOutput
    */
    func prediction(input: easyportraitInput, options: MLPredictionOptions) throws -> easyportraitOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return easyportraitOutput(features: outFeatures)
    }

    /**
        Make an asynchronous prediction using the structured interface

        - parameters:
           - input: the input to the prediction as easyportraitInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as easyportraitOutput
    */
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
    func prediction(input: easyportraitInput, options: MLPredictionOptions = MLPredictionOptions()) async throws -> easyportraitOutput {
        let outFeatures = try await model.prediction(from: input, options:options)
        return easyportraitOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - image as color (kCVPixelFormatType_32BGRA) image buffer, 512 pixels wide by 512 pixels high

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as easyportraitOutput
    */
    func prediction(image: CVPixelBuffer) throws -> easyportraitOutput {
        let input_ = easyportraitInput(image: image)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [easyportraitInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [easyportraitOutput]
    */
    func predictions(inputs: [easyportraitInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [easyportraitOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [easyportraitOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  easyportraitOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
