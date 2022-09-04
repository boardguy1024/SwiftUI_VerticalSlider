//
//  ContentView.swift
//  SwiiftUI_VerticalSlider
//
//  Created by park kyung seok on 2022/09/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Hello")
                
                ZStack(alignment: .bottom) {
                    
                    Rectangle()
                        .fill(Color.black).opacity(0.1)
                    
                    Rectangle()
                        .fill(Color.white).opacity(0.6)
                        .frame(height: sliderHeight < 0 ? 0 : sliderHeight)
                        
                }
                .frame(width: 100, height: maxHeight)
                .cornerRadius(35)
                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                    
                    let translation = value.translation
                    sliderHeight = -translation.height + lastDragValue
                    
                    if sliderHeight > maxHeight {
                        sliderHeight = maxHeight
                    } else if sliderHeight < 0 {
                        sliderHeight = 0
                    }
                    
                    
                    print("sliderHeight: \(sliderHeight)")

                    // %を表示
                    sliderProgress = sliderHeight / maxHeight
                    
                }).onEnded({ value in
                    lastDragValue = sliderHeight
                }))
                .overlay(alignment: .bottom, content: {
                   
                    Text("\(Int(sliderProgress * 100))%")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 18)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom, 30)
                        .offset(y: sliderHeight > maxHeight - 100 ? -(maxHeight - 100) :  -sliderHeight)
                })
                   
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue).ignoresSafeArea()
            .preferredColorScheme(.dark)
            .navigationTitle("DashBoard")
        }
    }
}
