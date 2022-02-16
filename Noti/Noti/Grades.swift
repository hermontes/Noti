//
//  Grades.swift
//  Noti
//
//  Created by Hermon Haile on 12/5/21.
//

import SwiftUI
import SwiftSoup


struct Teacher: View {
    @State var copyOfData = Array<String>()
    @State var finalCpy = Array<String>()
    
    @State var studName:String
    
    @State var didTap = false
    @State var after = false
    var body: some View {
        
        VStack{
            
//            Button(action: {
//                DispatchQueue.main.asyncAfter(deadline: .now() ) {
//                    finalCpy = url(studentName: studName)
//                    //                imgHolder = urlGetImage(schoolName: studName)
//                    self.didTap = true
//                }
//            }) {
//                HStack{
//                    Label(didTap ? "Display \(studName)'s teachers" : "Fetch \(studName)'s teachers ", systemImage: didTap ? "hand.tap.fill": "antenna.radiowaves.left.and.right")
//                        .font(.title2)
//                }
//            }
            
            if didTap {
                ProgressView {
                    Label("Fetching \(studName)'s teachers...", systemImage: "antenna.radiowaves,left.and.right")
                        .font(.title2)
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.didTap.toggle()
                        self.after.toggle()
                    }
                }
            } else if after {
                Button(action: {
                    self.didTap.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                                            finalCpy = url(studentName: studName)
                        self.didTap = true
                    }
                }) {
                    Label("Display \(studName)'s teachers", systemImage: "hand.tap.fill")
                        .font(.title2)
                }
                
            } else {
                Button(action: {
                    self.didTap.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                                            finalCpy = url(studentName: studName)

                        self.didTap = true
                    }
                }) {
                    Label("Tap to fetch \(studName)'s teachers", systemImage: "antenna.radiowaves,left.and.right")
                        .font(.title2)
                }
            }
            
            ScrollView{
                VStack(alignment:.leading, spacing: 10){
                    ForEach(Array(finalCpy.enumerated()), id: \.offset){ i, element in
                        if i > 5 && i < 31{
                            if element.contains("Mr") || element.contains("Ms")  {
                                Text("\(element)")
                                    .font(.title)
                                    .bold()

                            }else if element.contains("Phone"){
                                
                                Text("\(element)")
                                    .font(.callout)


                            }
                            else if element.contains("Email"){
                                
                                Text("\(element)")
                                    .font(.callout)
                                Divider()


                            }
                            
//                            else if(element.contains(".edu") ){
////                                Text("\(element)")
////                                    .font(.caption)
//                            }
//
                            else{

                            }
                        }
                        
                    }
                }.padding(20)
            }
            
        }
        
    }
    
    func url(studentName: String) -> Array<String>{
        
        let baseUrl = "https://nathanaeltemesgen.wixsite.com/website/blank-page"
        let url =
            URL (string: baseUrl )!
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data else {
                print("data was nil")
                return
            }
            guard let htmlString = String(data: data, encoding: String.Encoding.utf8) else {
                print("cannot cast data into string")
                return
                
            }
            
            do{
                let doc: Document = try SwiftSoup.parse(htmlString)
                let elements: Array<Element> = try doc.select("span").array()
                for i in 0..<elements.count {
                    copyOfData.append(try elements[i].text())
                }
            } catch Exception.Error(type: let type, Message: let message) {
                print(type)
                print(message)
            } catch {
                print("")
            }
            
        }
        task.resume()
        
        return copyOfData
        
    }
    
    
}

struct Grades: View {
    
    @State var copyOfData = Array<String>()
    @State var finalCpy = Array<String>()
    
    @State var studName:String
    
    @State var didTap = false
    @State var after = false

    var body: some View {
        
        VStack{
            if didTap {
                ProgressView {
                    Label("Fetching \(studName)'s grades...", systemImage: "antenna.radiowaves,left.and.right")
                        .font(.title2)
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.didTap.toggle()
                        self.after.toggle()
                    }
                }
            } else if after {
                Button(action: {
                    self.didTap.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                                            finalCpy = url(studentName: studName)
                        self.didTap = true
                    }
                }) {
                    Label("Display \(studName)'s grades", systemImage: "hand.tap.fill")
                        .font(.title2)
                }
                
            } else {
                Button(action: {
                    self.didTap.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                                            finalCpy = url(studentName: studName)

                        self.didTap = true
                    }
                }) {
                    Label("Tap to fetch \(studName)'s grades", systemImage: "antenna.radiowaves,left.and.right")
                        .font(.title2)
                }
            }
            ScrollView{
                VStack(alignment:.leading, spacing: 6){
                    ForEach(Array(finalCpy.enumerated()), id: \.offset){ i, element in
                        if i > 5 && i < 31{
                            if element.contains("Algebra") || element.contains("Physics") || element.contains("History") || element.contains("English") || element.contains("Physical Ed.") || element.contains("Spanish") {
                                Text("\(element)")
                                    .font(.title)
                                    .bold()
//                                    .underline(true, color: .black)

                            }else if element.contains("is") || element.contains("shows") || element.contains("great") || element.contains("learner") {
                                Text("\(studName) \(element)")
                                    .foregroundColor(.gray)
//                                    .fontWeight(.medium)
//                                    .bold()
                                    .font(.callout)
                                Divider()

                            }
                            
                            else{
                                Text("\(element)")
                                    .font(.callout)
//                                Divider()

                            }
                        }
                        
                    }
                }.padding(5)
            }
            
        }
        
    }
    
    func url(studentName: String) -> Array<String>{
        
        let baseUrl = "https://nathanaeltemesgen.wixsite.com/website/blank-page"
        let url =
            URL (string: baseUrl )!
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data else {
                print("data was nil")
                return
            }
            guard let htmlString = String(data: data, encoding: String.Encoding.utf8) else {
                print("cannot cast data into string")
                return
                
            }
            
            do{
                let doc: Document = try SwiftSoup.parse(htmlString)
                let elements: Array<Element> = try doc.select("span").array()
                
                //
                for i in 0..<elements.count {
                    copyOfData.append(try elements[i].text())
                        
                }
            } catch Exception.Error(type: let type, Message: let message) {
                print(type)
                print(message)
            } catch {
                print("")
            }
            
        }
        task.resume()
        
        return copyOfData
        
    }
    
}

struct Grades_Previews: PreviewProvider {
    static var previews: some View {
        Grades(studName: "")
        Teacher(studName: "")

    }
}
