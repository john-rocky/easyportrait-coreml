//
// skin.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
class skinInput : MLFeatureProvider {

    /// orig_imgs as color (kCVPixelFormatType_32BGRA) image buffer, 512 pixels wide by 512 pixels high
    var orig_imgs: CVPixelBuffer

    var featureNames: Set<String> {
        get {
            return ["orig_imgs"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "orig_imgs") {
            return MLFeatureValue(pixelBuffer: orig_imgs)
        }
        return nil
    }
    
    init(orig_imgs: CVPixelBuffer) {
        self.orig_imgs = orig_imgs
    }

    convenience init(orig_imgsWith orig_imgs: CGImage) throws {
        self.init(orig_imgs: try MLFeatureValue(cgImage: orig_imgs, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    convenience init(orig_imgsAt orig_imgs: URL) throws {
        self.init(orig_imgs: try MLFeatureValue(imageAt: orig_imgs, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    func setOrig_imgs(with orig_imgs: CGImage) throws  {
        self.orig_imgs = try MLFeatureValue(cgImage: orig_imgs, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

    func setOrig_imgs(with orig_imgs: URL) throws  {
        self.orig_imgs = try MLFeatureValue(imageAt: orig_imgs, pixelsWide: 512, pixelsHigh: 512, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

}


/// Model Prediction Output Type
@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
class skinOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// var_573 as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 512 pixels wide by 512 pixels high
    var var_573: CVPixelBuffer {
        return self.provider.featureValue(for: "var_573")!.imageBufferValue!
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(var_573: CVPixelBuffer) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["var_573" : MLFeatureValue(pixelBuffer: var_573)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
class skin {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "skin", withExtension:"mlmodelc")!
    }

    /**
        Construct skin instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of skin.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `skin.urlOfModelInThisBundle` to create a MLModel object to pass-in.

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
        Construct skin instance with explicit path to mlmodelc file
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
        Construct skin instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<skin, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct skin instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> skin {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct skin instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<skin, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(skin(model: model)))
            }
        }
    }

    /**
        Construct skin instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> skin {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return skin(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as skinInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as skinOutput
    */
    func prediction(input: skinInput) throws -> skinOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as skinInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as skinOutput
    */
    func prediction(input: skinInput, options: MLPredictionOptions) throws -> skinOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return skinOutput(features: outFeatures)
    }

    /**
        Make an asynchronous prediction using the structured interface

        - parameters:
           - input: the input to the prediction as skinInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as skinOutput
    */
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
    func prediction(input: skinInput, options: MLPredictionOptions = MLPredictionOptions()) async throws -> skinOutput {
        let outFeatures = try await model.prediction(from: input, options:options)
        return skinOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - orig_imgs as color (kCVPixelFormatType_32BGRA) image buffer, 512 pixels wide by 512 pixels high

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as skinOutput
    */
    func prediction(orig_imgs: CVPixelBuffer) throws -> skinOutput {
        let input_ = skinInput(orig_imgs: orig_imgs)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [skinInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [skinOutput]
    */
    func predictions(inputs: [skinInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [skinOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [skinOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  skinOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
