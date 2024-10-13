//
//  PhotosModel.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/4/24.
//
//  Originiated from https://stackoverflow.com/a/61473282/19402663.
//

// TODO: Fix photo-getting algo


import Foundation
import Photos
import UIKit

class PhotosModel: ObservableObject {
    @Published var errorString : String = ""
    @Published var photoArray: [BetterAsset] = []
    @Published var showAd: Bool = false
    
    let fromDate: Date = .distantPast
    var toDate: Date = .distantFuture
    
    private var currentIndex = 0
    private var totalInitialPhotos = 0
    
    var photosToDelete = [PHAsset]()
    
    var movedPhotos: [BetterAsset] = []
    
    init() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    self.errorString = ""
                    self.getInitialPhotos()
                case .denied, .restricted:
                    self.errorString = "Photo access permission denied"
                    print(self.errorString)
                case .notDetermined:
                    self.errorString = "Photo access permission not determined"
                    print(self.errorString)
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    fileprivate func getInitialPhotos() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let videoOptions = PHVideoRequestOptions()
        videoOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", fromDate as CVarArg, toDate as CVarArg)
        
        let results: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
        totalInitialPhotos = results.count
        
        if results.count > 2 {
            for i in 0..<3 {
                let asset = results.object(at: i)
                let size = CGSize(width: 700, height: 700) //You can change size here
                if asset.mediaType == .video {
                    DispatchQueue.main.async { 
                        manager.requestPlayerItem(forVideo: asset, options: videoOptions) { (video, _) in
                            if let video = video {
                                self.photoArray.append(BetterVideo(image: video, asset: asset))
                            } else {
                                print("error asset to image")
                            }
                        }
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                            if let image = image {
                                self.photoArray.append(BetterUIImage(image: image, asset: asset))
                            } else {
                                print("error asset to image")
                            }
                        }
                    }
                }
            }
            currentIndex = 3
        } else if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 700, height: 700) //You can change size here
                if asset.mediaType == .video {
                    DispatchQueue.main.async {
                        manager.requestPlayerItem(forVideo: asset, options: videoOptions) { (video, _) in
                            if let video = video {
                                self.photoArray.removeLast()
                                self.photoArray.append(BetterVideo(image: video, asset: asset))
                            } else {
                                print("error asset to image")
                            }
                        }
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                            if let image = image {
                                self.photoArray.removeLast()
                                self.photoArray.append(BetterUIImage(image: image, asset: asset))
                            } else {
                                print("error asset to image")
                            }
                        }
                    }
                }
            }
        } else {
            self.errorString = "No photos to display"
            print(errorString)
        }
        self.photoArray = self.photoArray.reversed()
        print("getAllPhotos() completed")
    }
    
    func appendToPhotosToDelete(_ asset: PHAsset) {
        photosToDelete.append(asset)
        print("appendToPhotosToDelete() completed")
    }
    
    fileprivate func getNextPhoto() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let videoOptions = PHVideoRequestOptions()
        videoOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", fromDate as CVarArg, toDate as CVarArg)
        
        // Set change with .image to with fetchOptions: Gets all types
        let results: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
        
        // Change photoArray so that it imcludes all three types
        self.photoArray = photoArray.shiftRight()
        
        let asset = results.object(at: currentIndex)
        let size = CGSize(width: 700, height: 700) //You can change size here

        // If video - https://developer.apple.com/documentation/photokit/phimagemanager/1616958-requestplayeritem, else ->
        if asset.mediaType == .video {
            manager.requestPlayerItem(forVideo: asset, options: videoOptions) { (video, _) in
                DispatchQueue.main.async {
                    if let video = video {
                        self.photoArray.removeLast()
                        self.photoArray.append(BetterVideo(image: video, asset: asset))
                    } else {
                        print("error asset to image")
                    }
                }
            }
        }
        else
        {
            manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                DispatchQueue.main.async {
                    if let image = image {
                        self.photoArray.removeLast()
                        self.photoArray.append(BetterUIImage(image: image, asset: asset))
                    } else {
                        print("error asset to image")
                    }
                }
            }
        }
    }
    
    func next() {
//        Checks to see if the index is geting close to the total number of photos. If it is, it removes any extra items.
        if currentIndex == totalInitialPhotos {
            self.photoArray = []
            deletePhoto()
            return
        } else if currentIndex == totalInitialPhotos - 1 {
            self.photoArray.removeLast()
        } else if currentIndex == totalInitialPhotos - 2 {
            self.photoArray.removeLast()
        }
        
        if !self.photoArray.isEmpty {
            movedPhotos.append(self.photoArray[0])
        }
        
        getNextPhoto()
        
        currentIndex += 1
        
        if currentIndex % 50 == 0 || currentIndex == 20 {
            showAd = true
        }
    }
    
    func undoSwipe() {
        if let recent = self.movedPhotos.last {
            self.currentIndex = self.currentIndex - 1
            photoArray.insert(recent, at: 0)
            self.photoArray.removeLast()
            self.movedPhotos.removeLast()
            
            if let index = photosToDelete.lastIndex(of: recent.asset) {
                self.photosToDelete.remove(at: index)
            }
        }
    }
    
    func deletePhoto() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(NSArray(array: self.photosToDelete))
        }) { success, error in
            guard let error = error else { return }
            guard (error as? PHPhotosError)?.code != .userCancelled else { return }
        }
        
        DispatchQueue.main.async {
            self.photosToDelete = []
        }
        
        
    }
    
    func changeDates() {
        photoArray = []
        getInitialPhotos()
    }
    
    func getAsset(asset: PHAsset) -> BetterAsset {
        var out: BetterAsset = BetterVideo(image: AVPlayerItem(url: URL(string: "https://videos.pexels.com/video-files/5824198/5824198-hd_1080_1920_24fps.mp4", encodingInvalidCharacters: true)!), asset: PHAsset())
        let size = CGSize(width: 700, height: 700) //You can change size here
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let videoOptions = PHVideoRequestOptions()
        videoOptions.deliveryMode = .highQualityFormat
        
        if asset.mediaType == .video {
            manager.requestPlayerItem(forVideo: asset, options: videoOptions) { (video, _) in
                DispatchQueue.main.async {
                    if let video = video {
                        out = BetterVideo(image: video, asset: asset)
                    } else {
                        print("error asset to image")
                    }
                }
            }
        }
        else
        {
            manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                DispatchQueue.main.async {
                    if let image = image {
                        out = BetterUIImage(image: image, asset: asset)
                    } else {
                        print("error asset to image")
                    }
                }
            }
        }
        return out
    }
    
    func getPhotosToDeleteAssets() -> [BetterUIImage] {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        let videoOptions = PHVideoRequestOptions()
        videoOptions.deliveryMode = .highQualityFormat

        let size = CGSize(width: 700, height: 700) //You can change size here
        
        var outArray: [BetterUIImage] = []

        for asset in photosToDelete {
            // If video - https://developer.apple.com/documentation/photokit/phimagemanager/1616958-requestplayeritem, else ->
            if asset.mediaType == .video {
                manager.requestPlayerItem(forVideo: asset, options: videoOptions) { (video, _) in
                    if video != nil {
                        var thumbnail = UIImage()
                        manager.requestImage(for: asset, targetSize: CGSize(width: 138, height: 138), contentMode: .aspectFit, options: requestOptions, resultHandler: {(result, info)->Void in
                            thumbnail = result!
                        })
                        outArray.append(BetterUIImage(image: thumbnail, asset: asset))
                        print("one added")
                    } else {
                        print("error asset to image")
                    }
                }
            }
            else
            {
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        outArray.append(BetterUIImage(image: image, asset: asset))
                        print("oneAdded")
                    } else {
                        print("error asset to image")
                    }
                }
            }
        }
        return outArray
    }
    
    func removeFromToDelete(array: [BetterUIImage]) {
        for item in array {
            if let index = photosToDelete.firstIndex(of: item.asset) {
                photosToDelete.remove(at: index)
            }
        }
    }
    
    func getCurrentIndex() -> Int {
        currentIndex
    }
}
