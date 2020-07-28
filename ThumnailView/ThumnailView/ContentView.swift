//
//  ContentView.swift
//  ThumnailView
//
//  Created by yusaku ikeda on 2020/07/28.
//  Copyright © 2020 yusaku ikeda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showImagePicker: Bool = false
    @State var filePath:String = ""


    var body: some View {
        ZStack {
            
            VStack {
                Button(action: {
                    self.showImagePicker.toggle()
                }) {
                    Text("ファイル選択")
                }
                
                if self.filePath != "" {
                    ThumnailView(filePath: self.filePath)
                }
            }
            
            if self.showImagePicker {
                ImagePickerView(isShown: self.$showImagePicker, filePath: self.$filePath)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
