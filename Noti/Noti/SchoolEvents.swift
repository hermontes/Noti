//
//  SwiftUIView.swift
//  Noti
//
//  Created by Hermon Haile on 12/1/21.
//
 
import SwiftUI
import SwiftSoup
 
extension String {
    func load() -> UIImage {
        
        do{
            guard let url = URL(string: self) else {
                return UIImage()
            }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        }catch{
            //
        }
        return UIImage()
    }
}
 
struct ImageOverlay: View {
    @State var incoming:String
    
    var body: some View {
        ZStack {
            Text("\(incoming)")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
            
        }.background(Color.black)
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(6)
    }
}
 
//@State var incomingSchool:String

 
struct SchoolEvents: View {
    
    @EnvironmentObject var accCreator: CreateAccount
    @State var incomingSchool:String
    
    @State var schools: [(schoolName: String, linkName: String)] = [("Arcola ES", "arcolaes"), ("Ashburton ES", "ashburtones"), ("Bannockburn ES", "bannockburnes"), ("Bannockburn ES", "bannockburnes"), ("Bethesda ES", "bethesdaes"),   ("Argyle MS", "argylems"), ("John T. Baker MS", "bakerms"), ("Benjamin Banneker MS", "bannekerms"), ("Briggs Chaney MS", "briggschaneyms"), ("Cabin John  MS", "cabinjohnms"), ("Herbert Hoover MS", "hooverms"), ("Kingsview  MS", "kingsviewms"), ("Lakelands Park  MS", "lakelandsparkms"), ("Shady Grove  MS", "shadygrovems"), ("Silver Creek MS", "silvercreekms"), ("Takoma Park MS", "takomaparkms"), ("Tilden MS", "tildenms")  , ("Sligo MS", "sligoms"), ("Bethesda-Chevy Chase HS", "bcchs"), ("James Hubert Blake", "blakehs"), ("Winston Churchill HS", "churchillhs"), ("Clarksburg HS", "clarksburghs"), ("Damascus HS", "damascushs"), ("Albert Einstein  HS", "einsteinhs"), ("Walter Johnson HS", "wjhs"), ("Richard Montgomery HS", "rmhs"), ("Wheaton HS", "wheatonhs"), ("Walt Whitman  HS", "whitmanhs")
                                                                    
    ]
    
    @State var arr = Array<String>()
    @State var arrOfImageSrcs = Array<String>()
    @State var imgHolder = Array<String>()
    
    @State var imagesElmsArr = ""
    @State var temp = ""
    @State var str = ""
    @State var copyOfSpan = Array<String>()
    
    @State var arrHolder = Array<String>()
 
    @State var copiesOfImages = Array<Image>()
    @State var counter = 0
    @State var arrnum = 0
    @State private var fontSize: CGFloat = 32
    
    @State private var bouncing = true
    @Namespace private var animation
    @State private var isFlipped = false
    @State private var didTap = false
    
    @State private var after = false
    @State private var capReveal = true
    
    var body: some View {
        VStack {
            ScrollView{
                if didTap {
                    ProgressView {
                        Label("Fetching \(incomingSchool)'s Calendar data...", systemImage: "antenna.radiowaves,left.and.right")
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
                            arr = url(schoolName: incomingSchool)
                            imgHolder = urlGetImage(schoolName: incomingSchool)
                            self.didTap = true
                        }
                    }) {
                        Label("Display \(incomingSchool)'s Calendar events", systemImage: "hand.tap.fill")
                            .font(.title2)
                    }
                    
                } else {
                    Button(action: {
                        self.didTap.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() ) {
                            arr = url(schoolName: incomingSchool)
                            imgHolder = urlGetImage(schoolName: incomingSchool)
                            self.didTap = true
                        }
                    }) {
                        Label("Tap to fetch \(incomingSchool)'s Calendar data ", systemImage: "antenna.radiowaves,left.and.right")
                            .font(.title2)
                    }
                }
                HStack{
                    VStack{
                        
                        
                        VStack{
//                            Divider()
                            
                            ScrollView(.horizontal){
                                HStack{
                                    
                                    ForEach(Array(imgHolder.enumerated()), id: \.offset){ i, element in
//                                        if i == 1 {
//                                            ImageOverlay(incoming: "Scroll horizontally to view recent photos")
//                                        }
//
                                        if ( !element.contains("fb") && !element.contains("yes") &&
                                                !element.contains("alert") &&
                                                !element.contains("fb") &&
                                             !element.contains("twitter") && !element.contains("amazon") && !element.contains("facebook") && !element.contains("logo") && !element.contains("instagram") && !element.contains("pdf") && !element.contains("PDF") ){
                                            if i > 1{
                                                Image(uiImage: element.load())
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 400, height: 200)
                                                    
                                                    .shadow(radius: 30)
                                                    .cornerRadius(10)
                                                Divider()
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }.frame(height: 200)
                        }
                    }
                }
                
                VStack(alignment:.leading, spacing: 6){
                    
                    
                    
                    ForEach(Array(arr.enumerated()), id: \.offset){ i, element in
                        if i == 0 {
                            ImageOverlay(incoming: "Scroll down to view upcoming events")
                        }
                        
                        if (element.contains("school") ||  element.contains("Release") || element.contains("closed") || element.contains("No")) {
//
                                Text("\(element)")
                                .font(.subheadline)
                                .font(.caption)
                                    .foregroundColor(.gray)
                        } else if (element.contains("Thu")
                                    || (element.contains("Fri") || (element.contains("Wed"))
                                            || (element.contains("Mon")) || (element.contains("Tue")) || (element.contains("Sat")) || (element.contains("Sun"))
                                    )
                        ) {
                            
                            Divider()
//                            arrHolder
                            Text("Date")
                                .font(.subheadline)
                                .fontWeight(.some(Font.Weight.light))
                                .foregroundColor(.blue)
                                +
                                Text(":")
                                .font(.subheadline)

                                .fontWeight(.some(Font.Weight.light))
 
                                +
                                Text("  \(element),")
                                .font(.subheadline)
                                .fontWeight(.some(Font.Weight.light))
 
                                +
                                Text(" \(arr[i+1])")
                                .font(.subheadline)
                                .fontWeight(.some(Font.Weight.light))
 
                                +
                                Text(" \(arr[i+2])")
                                .font(.subheadline)
                                .fontWeight(.some(Font.Weight.light))
                        } else{
                           
                        }
 
                    }
                }.padding(8)
                
                
            }
            
        }
    }
    
    
    func urlGetImage(schoolName: String) -> Array<String>{
        let baseUrl = "https://www2.montgomeryschoolsmd.org/schools/"
        var actualSchool = ""
        for skl in schools {
            if skl.schoolName == schoolName {
                actualSchool = skl.linkName
            }
        }
        let url =
            URL (string: baseUrl + actualSchool)!//        dataTask.resume()
        
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
                //                print("Span:", try text.text())
                let doc: Document = try SwiftSoup.parse(htmlString)
                let carouselImages: Array<Element> =   try doc.select("img").attr("class", "").array()
                
                self.arrOfImageSrcs = []
                for i in 0..<carouselImages.count {
                    if try carouselImages[i].attr("src").contains(".jpg") ||  carouselImages[i].attr("src").contains(".png"){
                        try self.arrOfImageSrcs.append("https://www2.montgomeryschoolsmd.org/" + carouselImages[i].attr("src"))
                        
                        
                    }
                }
                print("Array of image srcs: ", self.arrOfImageSrcs)
            } catch Exception.Error(type: let type, Message: let message) {
                print(type)
                print(message)
            } catch {
                print("")
            }
            
            
        }
        .resume()
        
        
        if self.arrOfImageSrcs.count != 0 {
            return  arrOfImageSrcs
        }
        
        
        return  self.arrOfImageSrcs
        
    }
    
    
    func url(schoolName: String) -> Array<String>{
        var actualSchool = ""
        for skl in schools {
            if skl.schoolName == schoolName {
                actualSchool = skl.linkName
            }
        }
        var b = false
        let baseUrl = "https://www2.montgomeryschoolsmd.org/schools/"
        let url =
            URL (string: baseUrl + actualSchool)!
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
                let spann: Array<Element> = try doc.select("span").attr("class", "ue-week").array()
                
                for i in 0..<spann.count {
                    if try spann[i].text() == "Thu"{
                        arrnum = i
                        b = true
                    }
                    if b {
                        copyOfSpan.append(try spann[i].text())
                    }
                }
            } catch Exception.Error(type: let type, Message: let message) {
                print(type)
                print(message)
            } catch {
                print("")
            }
            
        }
        task.resume()
        
        return copyOfSpan
        
    }
    
}
 
struct SchoolEvents_Previews: PreviewProvider {
    static var previews: some View {
        SchoolEvents(incomingSchool: "")
    }
}
