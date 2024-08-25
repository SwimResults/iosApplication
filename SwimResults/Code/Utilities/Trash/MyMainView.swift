//
//  MyMainView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 20.08.24.
//

import SwiftUI

struct MyStruct {
    var myBool1: Bool = false
}

struct MyMainView: View {
    @State var myStruct: MyStruct = MyStruct()
    @State var aBool: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Button("Toggle", action: {
                    aBool = !aBool
                })
            }
            MySubView(myStruct: $myStruct)
        }
    }
}

struct MySubView: View {
    @Binding var myStruct: MyStruct
    
    var body: some View {
        List {
            Text("Super!")
            if (myStruct.myBool1) {
                Text("Yes")
            } else {
                Text("No")
            }
        }
    }
}

#Preview {
    MyMainView()
}
