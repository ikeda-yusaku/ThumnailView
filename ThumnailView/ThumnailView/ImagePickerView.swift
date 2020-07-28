//
//  ImagePickerView.swift
//  ehon
//
//  Created by yusaku ikeda on 2020/07/11.
//  Copyright © 2020 yusaku ikeda. All rights reserved.
//

import SwiftUI

struct ImagePickerView {
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var filePath: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, filePath: $filePath)
    }
}

extension ImagePickerView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = ["public.movie"]
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isCoordinatorShown: Bool
    @Binding var filePath: String
    init(isShown: Binding<Bool>, filePath: Binding<String>) {
    _isCoordinatorShown = isShown
    _filePath = filePath
  }

  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
//    var localUrl = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerReferenceURL")]
    
    let localUrl = info[.mediaURL] as! URL
    let tempPath = localUrl.absoluteString

    let urlSlices = tempPath.split(separator: ".")

    //Create a temp directory using the file name
    let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    let targetUrl = tempDirectoryURL.appendingPathComponent(String(urlSlices[1])).appendingPathExtension(String(urlSlices[2]))

    do {
        //Copy the video over
        try FileManager.default.copyItem(at: URL(string:tempPath)!, to: targetUrl)
    } catch let error {
        print(error)
    }

    filePath = targetUrl.absoluteString
     isCoordinatorShown = false
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}

