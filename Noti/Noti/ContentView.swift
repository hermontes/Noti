//
//  ContentView.swift
//  Noti
//
//  Created by Nathanael Temesgen on 11/12/21.
//

import SwiftUI
import Firebase


class CreateAccount: ObservableObject{
    @Published var alertMessage: String = ""
    
    //    @State var isFocused = false
    @State var showAlert = false
    @Published var isSuccesful : Bool = false
    @Published var lop : String = "log off"
    @Published var email : String = ""
    
    let currAcc = Auth.auth()
    var isSignedIn: Bool {
        return currAcc.currentUser != nil // this means we are signed in
    }
    
    func login(email: String, password: String) {
        //         var isSuccesful = false
        self.email = email
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            //            self.isLoading = false
            
            if error != nil {
                self.isSuccesful = false
                
                self.alertMessage = error?.localizedDescription ?? "error"
                UserDefaults.standard.setValue(false, forKey: "logged in")  //new
                ////                self.showAlert = true
                //                print( error!)
                print("coming from here ")
                
                //    return false
            }else{ //show success screen
                self.isSuccesful = true
                self.lop = "logged in"
                UserDefaults.standard.setValue(true, forKey: "logged in")   //new
                
                print("logged in succesfully: \(self.isSuccesful)")
                DispatchQueue.main.asyncAfter(deadline: .now() ){
                    ////                    isSuccesful = false
                    //                                   self.isSuccesful = true
                    
                    //
                }
                //                return true
                
            }
        }
        
    }
    
    func signUp(em: String, pass: String) {
        @State var isSuccesful = false
        
        //        if password != repassword {
        //            //alert
        //        }
        Auth.auth().createUser(withEmail: em, password: pass) { result, error in
            
            if error != nil { //when there's an error while signing up
                self.alertMessage = error?.localizedDescription ?? "Error while attempting to sign up"
                self.showAlert = true
                //                print(self.alertMessage) //to see error in Output
                print(error!)
                print("coming from here ", error!)
                
            } else { //show success screen
                self.isSuccesful = true
                self.email = em
                
                DispatchQueue.main.asyncAfter(deadline: .now() ){
                    SignUpPage().email = ""
                    print("signed up")
                }
                
            }
        }
        
    }
    
    func logout() {
        do {
            try currAcc.signOut()
            isSuccesful = false
            lop = "logged off"
        } catch {
            print("no user")
        }
    }
}

struct ContentView: View {
    @State private var bouncing = true
    @Namespace private var animation
    @State private var isFlipped = false
    
    @EnvironmentObject var accCreator: CreateAccount
    //    @State private var bouncing = true
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(red: 102/255, green: 178/255, blue: 1)
                    .edgesIgnoringSafeArea(.all)
                Circle()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .top : .bottom)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                
                Circle()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 20)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .bottom : .top)
                    .animation(Animation.interpolatingSpring(mass: 0.8, stiffness: 1.0, damping: 1.0, initialVelocity: 1.0).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                Circle()
                    
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .bottom : .top)
                    .animation(Animation.interpolatingSpring(mass: 3.4, stiffness: 5.0, damping: 1.0, initialVelocity: 3.5).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                Circle()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .top : .bottom)
                    .animation(Animation.easeIn(duration: 4.0).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                    
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .bottom : .top)
                    .animation(Animation.interpolatingSpring(mass: 3.4, stiffness: 5.0, damping: 1.0, initialVelocity: 3.5).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                Circle()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .top : .bottom)
                    .animation(Animation.easeIn(duration: 4.0).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                    
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .bottom : .top)
                    .animation(Animation.interpolatingSpring(mass: 3.4, stiffness: 5.0, damping: 1.0, initialVelocity: 3.5).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                Circle()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .frame(maxHeight: .infinity, alignment: bouncing ? .top : .bottom)
                    .animation(Animation.easeIn(duration: 4.0).repeatForever(autoreverses: true))
                    .onAppear {
                        self.bouncing.toggle()
                    }
                
                VStack {
                    //                    Text("NOTI")
                    
//                    Label {
                        Text("NOTI")
                            .font(.system(size: 105, design: .rounded))
                            .foregroundColor(.white)
                            .padding()
//                    }
                    Spacer()
                        .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                    
                    NavigationLink(
                        destination: SignUpPage(),
                        label: {
                            Text("Sign Up")
                                .padding()
                                .font(.title)
                                .frame(width: 128, height: 49.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth:2))                    })
                    
                    
                    Spacer()
                        .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: 15)
                    
                    NavigationLink(
                        destination: LogInPage(),
                        label: {
                            Text("Log In")
                                .padding()
                                .font(.title)
                                .frame(width: 128, height: 49.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth:2))                    })
                }
            }
        }
    }
}

struct SignUpPage: View {
    
    @EnvironmentObject var accCreator: CreateAccount
    
    @State var firstname : String = ""
    @State var lastname : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State var repassword : String = ""
    @State var invalid = false
    
    @State private var bouncing = true
    @Namespace private var animation
    @State private var isFlipped = false
    @State var showAlert = false

    
    var body: some View {
        VStack {
           
            Text("Sign Up")
                
                .font(Font.largeTitle)
                .underline(true, color: Color(red: 102/255, green: 178/255, blue: 1))
            TextField("First Name", text: $firstname) //capture first and last name to be used in later pages
                .padding()

                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(7)
            TextField("Last Name", text: $lastname)
                .padding()

                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(7)
            TextField("Email", text: $email)
                .padding()

                .keyboardType(.emailAddress)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(7)
            SecureField("Password", text: $password)
                .padding()

                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(7)
            SecureField("Re-Enter Password", text: $repassword)
                .padding()

                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(7)
            
            Button(action: {
                
                //                isSuccesful =
                UserDefaults.standard.set(email, forKey: "user")
                if password != repassword {
                    self.password = ""
                    self.repassword = ""
                    invalid = true
                    accCreator.alertMessage = "Correctly re-enter your password"
                } else {
                    accCreator.signUp(em: email, pass: password)
                    //                $lastname = ""
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if accCreator.showAlert == true {
                            UserDefaults.standard.set(accCreator.isSuccesful, forKey: "logged in")
                            UserDefaults.standard.set(email, forKey: "user")
                            self.email = ""
                            self.password = ""
                            self.repassword = ""
                            self.firstname = ""
                            self.lastname = ""
                            self.invalid = false
                        } else if password.count < 6 {
                            self.password = ""
                            self.repassword = ""
                            invalid = true
                        } else {
                            self.email = ""
                            self.password = ""
                            self.repassword = ""
                            invalid = true
                        }
                    }
                }
                
            },
            
            label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 100, height: 40)
                    .overlay(
                        Text("Sign Up")
                            .foregroundColor(.white)
                    )
                
            }).alert(isPresented: $invalid) {
                Alert(
                    title: Text("Invalid Email/Password"),
                    message: Text("\(accCreator.alertMessage)")
                )
            }
        }
    }
}


struct LogInPage: View{
    
    @EnvironmentObject var accCreator: CreateAccount
    
    @State var email: String = ""
    @State var password: String = ""
    @State var alertMessage: String = ""
    @State var showAlert = false
    
    @State private var bouncing = true
    @Namespace private var animation
    @State private var isFlipped = false


    
    var body: some View {
        VStack {
//            VStack{
            Circle()
                .stroke(Color(red: 102/255, green: 178/255, blue: 1), lineWidth: 5)
                .frame(maxHeight: 70, alignment: .topTrailing)
              
//                .background((Color(red: 102/255, green: 178/255, blue: 1)))
                .overlay(            Text("Noti")
                                        .bold()
                                        .foregroundColor((Color(red: 102/255, green: 178/255, blue: 1)))
                                        //                                        .font(.title)
                                        .font(.system(size: 30, design: .rounded))
                                     
                )
               
                .aspectRatio(contentMode: .fit)
                //                .frame(height: 40)
                .animation(Animation.easeInOut(duration: 4.0).repeatForever(autoreverses: true))
                .onAppear {
                    self.bouncing.toggle()
                }
            Text("Log In")
                //                .font(Font.largeTitle)
                .font(.system(size: 50, design: .rounded))
                
                .underline(true, color: Color(red: 102/255, green: 178/255, blue: 1))
            TextField("Email", text: $email)
                .padding()
                .keyboardType(.emailAddress)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(7)
            SecureField("Password", text: $password)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke( Color(red: 102/255, green: 178/255, blue: 1), style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(7)
            
            Button(action: {
                accCreator.login(email: email, password: password)
                UserDefaults.standard.set(email, forKey: "user")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if accCreator.showAlert == true  {
                        UserDefaults.standard.set(accCreator.isSuccesful, forKey: "logged in")
                        UserDefaults.standard.set(email, forKey: "user")
                        self.email = ""
                        self.password = ""
                        showAlert = false
                    } else {
                        showAlert = true
                        self.password = ""
                    }
                }
                
            }) {            // needs to "submit" fields into the server
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 100, height: 40)
                    .overlay(
                        Text("Log In")
                            .foregroundColor(.white)
                    )
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Login"),
                    message: Text("\(accCreator.alertMessage)")
                )
            }
        }
    }
}

struct CurrPage: View {
    @EnvironmentObject var accCreator: CreateAccount
    
    var body: some View {
//        if UserDefaults.standard.bool(forKey: "logged in") {
        if accCreator.isSuccesful {
            SelectStudent().environmentObject(accCreator).environmentObject(Directory())
        } else {
            ContentView().environmentObject(accCreator)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrPage().environmentObject(CreateAccount())
    }
}
