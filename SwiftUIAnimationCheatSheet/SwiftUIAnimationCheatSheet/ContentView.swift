//
//  ContentView.swift
//  SwiftUIAnimationCheatSheet
//
//  Created by Krupanshu Sharma on 24/01/23.
//

import SwiftUI

struct ContentView: View {
    // 1.1
    @State private var scale = 1.0
    // 1.2
    @State private var angle: Double = 0
    // 1.3
    @State private var showingWelcome = false
    // 1.4
    @State var rotation = 0.0
    // 1.5
    @State var heartScale = 1.0

    
    var body: some View {
        NavigationStack{
            List{
                // 1.
                Section {
                    Button("Scale Button") {
                        scale += 1
                    }
                    .frame(height: 45)
                    .scaleEffect(scale)
                    .animation(.linear(duration: 1), value: scale)
                }header: {
                    Text("Basic Scale Animation")
                }
                
                // 2.
                Section {
                    Button("Spring Button") {
                        angle += 45
                    }
                    .frame(height: 45)
                    .padding()
                    .rotationEffect(.degrees(angle))
                    .animation(.spring(), value: angle)
                }header: {
                    Text("Spring Animation with rotation Effect")
                }
                
                // 3.
                Section {
                    VStack {
                        Toggle("Toggle label", isOn: $showingWelcome.animation(.spring()))
                        
                        if showingWelcome {
                            Text("You are welcome..!!")
                        }
                    }
                }header: {
                    Text("Show Hide In Binding Values")
                }
                
                // 4.
                Section {
                    Capsule()
                        .fill(.red)
                        .frame(width: 90, height: 40)
                        .padding()
                        .rotationEffect(.degrees(rotation))
                        .animation(.easeInOut(duration: 3).delay(1), value: rotation)
                        .onTapGesture {
                            rotation += 360
                        }
                }header: {
                    Text("Add Delay In Animation")
                }
                
                // 5.
                Section {
                    heartView
                        .frame(width: 200, height: 200)
                        .scaleEffect(heartScale)
                        .onAppear {
                            let baseAnimation = Animation.easeInOut(duration: 1)
                            let repeated = baseAnimation.repeatForever(autoreverses: true)
                            withAnimation(repeated) {
                                heartScale = 0.5
                            }
                        }
                }header: {
                    Text("Repeated Animation")
                }
                
                Section {
                    //6.
                    Ellipse()
                    .scaleEffect(0.2)
                    .foregroundColor(animationData.color)
                    .animation(.default, value: animationData)
                    .offset(animationData.offset)
                    .padding()
                    .frame(height: 240)
                    .onAppear {
                        //7.
                      for (index, data) in AnimationData.array.enumerated().dropFirst() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(index)) {
                          animationData = data
                        }
                      }
                    }
                }header: {
                    Text("Move View with Animation")
                }
            }
            .navigationTitle("Animations")
        }
    }
    
    private var heartView: some View {
        ZStack{
            Rectangle()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.red)
                .cornerRadius(5)
            
            Circle()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.red)
                .padding(.top, -50)
            
            Circle()
                .frame(width: 50, height: 100, alignment: .center)
                .foregroundColor(.red)
                .padding(.trailing, -100)
        }.rotationEffect(Angle(degrees: -45))
    }
    
    private struct AnimationData: Equatable {
      let offset: CGSize
      let color: Color

      static let array: [Self]  = [
        .init(
          offset: .init(width: 0, height: 0),
          color: .green
        ),
        .init(
          offset: .init(width: -100, height: 0),
          color: .blue
        ),
        .init(
          offset: .init(width: -100, height: -100),
          color: .red
        ),
        .init(
          offset: .init(width: 100, height: -100),
          color: .orange
        ),
        .init(
          offset: .init(width: 100, height: 0),
          color: .yellow
        ),
        .init(
          offset: .init(width: -10, height: 0),
          color: .black
        )
      ]
    }
    
    // 1.
    @State private var animationData = AnimationData.array[0]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
