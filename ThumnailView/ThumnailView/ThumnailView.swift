//
//  ThumnailView.swift
//  ehon
//
//  Created by yusaku ikeda on 2020/07/27.
//  Copyright © 2020 yusaku ikeda. All rights reserved.
//

import SwiftUI
import AVKit

struct ThumnailView : View{
    
    var thumnailCGImage:CGImage = UIImage(systemName: "exclamationmark.octagon")!.cgImage!
    var imageOrientation:Image.Orientation = Image.Orientation.up
    
    init(filePath:String) {
        guard let url = URL(string: filePath) else {return}
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let track = asset.tracks(withMediaType: AVMediaType.video).first!
        let transform = track.preferredTransform
        
        print ("*** \(transform.tx), \(transform.ty), size: \(track.totalSampleDataLength)")
        
        do {
                        
            if transform.tx == 0 && transform.ty == 0 {
                self.imageOrientation = Image.Orientation.up
            } else if (transform.tx > 0 && transform.ty == 0) {
                self.imageOrientation = Image.Orientation.right
            } else if (transform.tx == 0 && transform.ty > 0) {
                self.imageOrientation = Image.Orientation.left
            } else {
                self.imageOrientation = Image.Orientation.down
            }
            
            self.thumnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1,timescale: 60), actualTime: nil)
            
        } catch let error {
            print (error)
        }
    }
    
    var body: some View {
        Image(decorative: self.thumnailCGImage, scale: 1, orientation: self.imageOrientation).resizable()
    }
}


struct ThumnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumnailView(filePath: "")
    }
}
