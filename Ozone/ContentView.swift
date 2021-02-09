//
//  ContentView.swift
//  Ozone
//
//  Created by Sofi on 09.02.2021.
//

import SwiftUI





struct b:View {
    @State var item = 1
    var body: some View{
        TabView(selection:$item){
            b1().tabItem { VStack{
                Image("h")
                Text("Главная").font(.custom("", size: 12))
            } }.tag(1)
            b2().tabItem { VStack{
                Image("m")
                Text("Каталог").font(.custom("", size: 12))
            } }.tag(2)
            b3().tabItem { VStack{
                Image("p")
                Text("Магазины").font(.custom("", size: 12))
            } }.tag(3)
            ContentView().tabItem { VStack{
                Image("pro")
                Text("Профиль").font(.custom("", size: 12))
            } }.tag(4)
        }
    }
}

struct ContentView: View {
    @ObservedObject var model = ModelView()
    @State var error  = false
    @State var mess = ""
    @State var nam = ""
    @State var pass = ""
    @State var show = false
    var body: some View {
        ZStack{
            VStack(spacing:0){
                ZStack(alignment:.bottom){
                    Color("gren")
                    HStack{
                        Image("a").resizable().frame(width: 20, height: 20, alignment: .center).padding()
                        Spacer()
                    }
                    Text("Вход в личный кабинет").foregroundColor(.white).font(.custom("", size: 18)).padding()
                }.frame(width: UIScreen.main.bounds.width, height: 120, alignment: .center)
                VStack(spacing:50){
                    VStack(spacing:20){
                        TextField("Email", text: $nam).frame(width: UIScreen.main.bounds.width-30, height: 1, alignment: .center)
                        Rectangle().frame(width: UIScreen.main.bounds.width-30, height: 1, alignment: .center).foregroundColor(.gray).opacity(0.2)
                    }
                    VStack(spacing:20){
                        HStack{
                        TextField("Пароль", text: $pass).frame(width: UIScreen.main.bounds.width-60, height: 1, alignment: .center)
                            Image("e").resizable().frame(width: 20, height: 20, alignment: .center)
                        }
                        Rectangle().frame(width: UIScreen.main.bounds.width-30, height: 1, alignment: .center).foregroundColor(.gray).opacity(0.2).offset( y: -10)
                    }
                    Button(action: {
                        
                        if nam != "" && pass != ""{
                            if nam.contains("@"){
                                
                                model.SignIn(user: "\(nam)", pass: "\(pass)")
                                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                if model.perehod == 1 {
                                    error.toggle()
                                    mess = "All right!"
                                } else if model.perehod == 2{
                                    error.toggle()
                                    mess = "Error email or password"
                                }else if model.perehod == 3{
                                    error.toggle()
                                    mess = "User is active"
                                }
                                }
                            }else{
                                error.toggle()
                                mess = "Error email"
                            }
                        }else{
                            error.toggle()
                            mess = "Enter all fiels"
                        }
                        
                      
                            
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 310, height: 80, alignment: .center).foregroundColor(Color("gren"))
                            Text("Войти").foregroundColor(.white).font(.custom("", size: 20))
                        }
                    }).alert(isPresented: $error, content: {
                        Alert(title: Text("Error"), message: Text("\(mess)"), dismissButton: .default(Text("Ok")))
                    })
                    
                    Button(action: {
                        show.toggle()
                    }, label: {
                        Text("Зарегестрируйтесь").foregroundColor(Color("bu")).font(.custom("", size: 18)).offset( y: -20)
                    })
                    
                }.offset( y: 50)
                Spacer()
            }
            if show{
            GeometryReader{g in
                Custom(show: $show)
            }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct b1:View {
    var body: some View{
        ZStack{
            Text("Главная")
        }
    }
}

struct b2:View {
    var body: some View{
        ZStack{
            Text("Каталог")
        }
    }
}

struct b3:View {
    var body: some View{
        ZStack{
            Text("Магазины")
        }
    }
}


struct Custom:View {
    @State var model = ModelView()
    @Binding var show:Bool
    @State var error  = false
    @State var mess = ""
    @State var nam = ""
    @State var pass = ""
    @State var repass = ""
    var body: some View {
        ZStack{
            Color.white
            VStack(spacing:0){
                ZStack(alignment:.bottom){
                    Color("gren")
                    HStack{
                        Button(action: {
                            show.toggle()
                        }, label: {
                            Image("a").resizable().frame(width: 20, height: 20, alignment: .center).padding()
                        })
                        
                        Spacer()
                    }
                    Text("Зарегестрируйтесь").foregroundColor(.white).font(.custom("", size: 18)).padding()
                }.frame(width: UIScreen.main.bounds.width, height: 120, alignment: .center)
                VStack(spacing:50){
                    VStack(spacing:20){
                        TextField("Email", text: $nam).frame(width: UIScreen.main.bounds.width-30, height: 1, alignment: .center)
                        Rectangle().frame(width: UIScreen.main.bounds.width-30, height: 1, alignment: .center).foregroundColor(.gray).opacity(0.2)
                    }
                    VStack(spacing:20){
                        HStack{
                        TextField("Пароль", text: $pass).frame(width: UIScreen.main.bounds.width-60, height: 1, alignment: .center)
                            Image("e").resizable().frame(width: 20, height: 20, alignment: .center)
                        }
                        Rectangle().frame(width: UIScreen.main.bounds.width-30, height: 1, alignment: .center).foregroundColor(.gray).opacity(0.2).offset( y: -10)
                    }
                    VStack(spacing:20){
                        HStack{
                        TextField("Пароль", text: $repass).frame(width: UIScreen.main.bounds.width-60, height: 1, alignment: .center)
                            Image("e").resizable().frame(width: 20, height: 20, alignment: .center)
                        }
                        Rectangle().frame(width: UIScreen.main.bounds.width-30, height: 1, alignment: .center).foregroundColor(.gray).opacity(0.2).offset( y: -10)
                    }
                    Button(action: {
                        if nam != "" && pass != "" && repass != ""{
                            if nam.contains("@"){
                                model.SignUp(user: "\(nam)", pass: "\(pass)")
                                show.toggle()
                            }else{
                                error.toggle()
                                mess = "Error email"
                            }
                        }else{
                            error.toggle()
                            mess = "Enter all fiels"
                        }
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 310, height: 80, alignment: .center).foregroundColor(Color("gren"))
                            Text("Войти").foregroundColor(.white).font(.custom("", size: 20))
                        }
                    }).alert(isPresented: $error, content: {
                        Alert(title: Text("Error"), message: Text("\(mess)"), dismissButton: .default(Text("Ok")))
                    })
                    
                    
                    
                }.offset( y: 50)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
}
}
