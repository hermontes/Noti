//
//  SelectStudent.swift
//  Noti
//
//  Created by Nathanael Temesgen on 11/22/21.
//

import SwiftUI
import FirebaseDatabase

extension UITextField
{
    open override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.masksToBounds = true
    }
}

struct AddItemView: View {
    @EnvironmentObject var directory: Directory
    @EnvironmentObject var accCreator: CreateAccount
    @Binding var adding: Bool
    @State var firstnameStr  = ""
    @State var lastnameStr  = ""
    @State var schoolStr = ""
    @State var schoolIdStr = ""
    @State var passwordStr  = ""
    @State private var selection = 1

    let schools = ["Select School", "Arcola ES", "Ashburton ES", "Bannockburn ES", "Bethesda ES", "Argyle MS",  "John T. Baker MS", "Benjamin Banneker MS", "Briggs Chaney MS", "Cabin John  MS", "Herbert Hoover MS", "Kingsview  MS", "Lakelands Park  MS", "Shady Grove  MS", "Silver Creek MS", "Takoma Park MS", "Tilden MS", "Sligo MS", "Bethesda-Chevy Chase HS", "James Hubert Blake", "Winston Churchill HS", "Clarksburg HS", "Damascus HS", "Albert Einstein  HS", "Walter Johnson HS", "Richard Montgomery HS", "Wheaton HS", "Walt Whitman  HS" ]

    
//    let schools = ["Select School", "Arcola ES", "Bcc", "Ashburton ES", "Bannockburn ES", "Lucy V. Barnsley ES", "Beall ES", "Bel Pre ES", "Bells Mill ES",
//    "Belmont ES", "Bethesda ES", "Beverly Farms ES", "Bradley Hills ES", "Brooke Grove ES", "Brookhaven ES", "Brown Station ES","Burning Tree ES", "Burnt Mills ES", "Burtonsville ES", "Candlewood ES", "Cannon Road ES", "Carderock Springs ES", "Rachel Carson ES", "Cashell ES", "Cedar Grove ES", "Chevy Chase ES", "Clarksburg ES", "Clearspring ES", "Clopper Mill ES", "Cloverly ES", "Cold Spring ES", "College Gardens ES", "Cresthaven ES"]
    
    var body: some View {
            VStack {
                
                HStack(alignment: .bottom){
                    
                    HStack {
                        Text("First Name:")
                            .font(.callout)
                        TextField("First Name", text: $firstnameStr)
                            .font(.callout)

                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 235/255, green: 245/255, blue: 255/255)))
                            //                Color(red: 222/255, green: 237/255, blue: 252/255)
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke( Color.white, style: StrokeStyle(lineWidth: 1.0)
                                    )
                            )
                    }.padding(4)
                HStack {
                    Text("Last Name:")
                        .font(.callout)

                    TextField("Last Name", text:$lastnameStr)
                        .font(.callout)

                        .padding(14)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 235/255, green: 245/255, blue: 255/255)))
                        //                Color(red: 222/255, green: 237/255, blue: 252/255)
                        
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke( Color.white, style: StrokeStyle(lineWidth: 1.0)
                                )
                        )
                }.padding(4)
                
             
                }
//                HStack {
//                    Text("School:")
//
//                    TextField("School", text: $schoolStr)
//                        .padding(10)
//                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 235/255, green: 245/255, blue: 255/255)))
//                        //                Color(red: 222/255, green: 237/255, blue: 252/255)
//
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke( Color.white, style: StrokeStyle(lineWidth: 1.0)
//                                )
//                        )
//                }.padding(4)
                VStack{
                    HStack {
                        Text("School ID:")
                        TextField("School ID", text: $schoolIdStr)
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 235/255, green: 245/255, blue: 255/255)))
                            //                Color(red: 222/255, green: 237/255, blue: 252/255)
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke( Color.white, style: StrokeStyle(lineWidth: 1.0)
                                    )
                            )                   .padding(7)
                    }.padding(4)
                    HStack {
                        Text("Password:")
                        SecureField("Password", text: $passwordStr)
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 235/255, green: 245/255, blue: 255/255)))
                            //                Color(red: 222/255, green: 237/255, blue: 252/255)
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke( Color.white, style: StrokeStyle(lineWidth: 1.0)
                                    )
                            )
                        //                        .padding(7)
                    }.padding(4)
                }.padding(7)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color(red: 1/255, green: 46/255, blue: 35/255), style: StrokeStyle(lineWidth: 0.5)
                        )
                )
                
                HStack {
                    Text("School:")

//                    TextField("School", text: $schoolStr)
//                        .padding(10)
//                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 235/255, green: 245/255, blue: 255/255)))
//                        //                Color(red: 222/255, green: 237/255, blue: 252/255)
//
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke( Color.white, style: StrokeStyle(lineWidth: 1.0)
//                                )
//                        )
                    
                    Form {
//                        Section {
                            Picker("School", selection: $schoolStr) {
                                ForEach(schools, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
//                        }
                    }.scaledToFill()
                    
                }.padding(4)
                //            Spacer(minLength: 10)
                
            }.padding()
//            .offset(y: -10)
            Button("Add") {
                guard (!firstnameStr.isEmpty
                        && !lastnameStr.isEmpty
                        && !schoolStr.isEmpty && !schoolIdStr.isEmpty && !passwordStr.isEmpty) else {
                    adding = false
                    return
                }
                
                var de = DirEntry(id: nil,
                                  firstname: firstnameStr,
                                  lastname: lastnameStr,
                                  school: schoolStr,
                                  schoolid: schoolIdStr,
                                  password: passwordStr)
                directory.addEntry(entry: &de)
                adding = false
            }.padding(7)
            .foregroundColor(.blue)
            
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 3)
                    )
                //                    .background(Color(red: 102/255, green: 178/255, blue: 1))
            )
            .font(.title2)
            .offset(y: -27)
    }

}

struct DirEntryView: View {
    var entry: DirEntry
    
    var body: some View {
        
        VStack {
            
//            HStack {
//                Text("First Name:\t").bold()
//                Text(entry.firstname)
//                    .underline(true, color: Color.blue)
//                Spacer()
//            }.padding(7)
//            HStack {
//                Text("Last Name:\t").bold()
//
//                Text(entry.lastname)
//                    .underline(true, color: Color.blue)
//                Spacer()
//            }.padding(7)
//            HStack {
//                Text("School:\t").bold()
//                Text(entry.school)
//                    .underline(true, color: Color.blue)
//                Spacer()
//            }.padding(7)
//            HStack {
//                Text("School ID:\t").bold()
//                Text(entry.schoolid)
//                    .underline(true, color: Color.blue)
//                Spacer()
//            }.padding(7)
            NavigationLink(
                destination: HomePage(firstname: entry.firstname, lastname: entry.lastname, school: entry.school, schoolId: entry.schoolid, password: entry.password),
                label: {
                    HStack {
                        Text("\(entry.lastname), \(entry.firstname)")
                        Text("[\(entry.schoolid)]").font(.footnote).foregroundColor(.gray)
                    }
//                    Text("\(entry.lastname), \(entry.firstname) (\(entry.schoolid))")
                    
                }
            )
        }
    }
}

struct SelectStudent: View {
    @EnvironmentObject var directory: Directory
    @EnvironmentObject var accCreator: CreateAccount
    @State private var isFlipped = false
    
    @State var adding = false

    var body: some View {
        VStack {
//            VStack {
                HStack{
                    Circle()
                       

                        .stroke(Color(red: 102/255, green: 178/255, blue: 1), lineWidth: 5)

                        .overlay(            Text("Noti")
                                                .bold()
                                                .foregroundColor((Color(red: 102/255, green: 178/255, blue: 1)))
                                                                               .font(.title)
                                                .font(.system(size: 30, design: .rounded))
                                             
                        )
                        .aspectRatio(contentMode: .fit)
                        
                        .frame(maxHeight: 70, alignment: .bottomTrailing)
                        .animation(Animation.easeIn(duration: 4.0).repeatForever(autoreverses: true))
                       
                    Button(action: {
                        accCreator.logout()
                        accCreator.isSuccesful = false
                        UserDefaults.standard.set(accCreator.isSuccesful, forKey: "logged in")
                        
                    }) {
                        
                        
                        Text("Log Out")
                            .frame(maxWidth: .infinity, alignment: .topTrailing)
//                            .padding()
                            .foregroundColor(.blue)
                            .font(.title3)
                    }
                }.padding()
//            }
            
            NavigationView {
                
                VStack {
                    
                    Text("Hello, \(String(UserDefaults.standard.string(forKey: "user")!.split(separator: "@")[0]))").font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(7)
                        .foregroundColor(.blue)
                    Text("As you add a student, you'll be able to see them below!")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(7)
                    List {
                        Section(header: Text("Students")) {
                            ForEach(0..<directory.entries.keys.count, id: \.self) { i in
                                let key = directory.entries.keys.index(directory.entries.keys.startIndex, offsetBy: i)
                                let entry = directory.entries[key]
                                
                                DirEntryView(entry: entry.value)
                            }.onDelete(perform: deleteEm)
                            
                        }
//                    }.navigationTitle("Children")
                    }
                    
                    .listStyle(GroupedListStyle())
                    
                    NavigationLink(destination: AddItemView(adding: $adding)
                                    .environmentObject(directory)
                                    .environmentObject(accCreator),
                                   isActive: $adding) {
                        Button(action: {adding=true}) {
                            
                            Label("Add Student", systemImage: "person.badge.plus")
                                .font(.title)
                            
                        }
                    }
                    
                }
            }
            
        }
    }
    
    private func idByOffset(_ offset: Int) -> String {
        let idx = directory.entries.keys.index( directory.entries.keys.startIndex, offsetBy: offset)
        let (key, _) = directory.entries[idx]
        return key
    }
    
    private func addItem(_ entry: inout DirEntry) {
        withAnimation {
            directory.addEntry(entry: &entry)
        }
    }
    
    private func deleteEm(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                idByOffset($0)
            }.forEach(directory.delEntry)
        }
    }
}

struct SelectStudent_Previews: PreviewProvider {
    static var previews: some View {
        SelectStudent().environmentObject(Directory()).environmentObject(CreateAccount())
    }
}
