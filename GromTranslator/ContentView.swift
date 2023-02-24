//
//  ContentView.swift
//  GromTranslator
//
//  Created by Vitaly Gromov on 2/24/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var sourceText = ""
    @State var flag = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Input Your Source Text", text: $sourceText)
                    .padding()
                NavigationLink {
                    SecondView(sourceDataFromMainView: sourceText)
                } label: {
                    Text("Next")
                }
            }.navigationTitle("General Input")
        }
    }
}

struct SecondView: View {
    @State var sourceDataFromMainView: String
    @State var stringArray: [StringItem] = []
    
    
    @State var x = ""
    var body: some View {
        VStack {
            List {
                ForEach(stringArray, id: \.id) { i in
                        Section("") {
                            Text(i.sourceText)
                            TextField("translate", text: $stringArray[i.id].translateText)
                            
                            
                        }
                        
                }
                            }
            NavigationLink("Finish") {
                ThirdView(stringArray: stringArray)
            }
        }.onAppear {
            stringArray = splitSourceText(sourceDataFromMainView)
        }
    }
    
    private func splitSourceText(_ text: String) -> [StringItem] {
        let x = text.components(separatedBy: [".", "!", "?"])
        var count = 0
        var y: [StringItem] = []
        for i in x {
            if i == " " || i == "" {
                continue
            } else {
                let temp = i.trimmingCharacters(in: .whitespaces)
                y.append(StringItem(id: count, sourceText: temp))
                count += 1
            }
        }
        
        
        
        
        print(x)
        print(y)
        return y
    }
   
}

struct ThirdView: View {
    var stringArray: [StringItem]
    @State var finalText: String = ""
    var body: some View {
        VStack {
            Text(finalText)
            Button("Copy To Clipboard") {
                UIPasteboard.general.string = finalText
                print("success")
            }
            .padding(.top)
        }.onAppear {
            finalText = combineFinaltext(stringArray: stringArray)
        }
    }
    
    private func combineFinaltext(stringArray: [StringItem]) -> String{
        var final = ""
        
        for i in stringArray {
            final += i.translateText + " "
        }
        
        return final
    }
}


struct StringItem: Identifiable {
    var id: Int
    var sourceText: String
    var translateText: String = ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        SecondView(sourceDataFromMainView: "I.Am.Vitaly.")
    }
}
