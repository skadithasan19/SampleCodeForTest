//
//  PullsSwiftUIView.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import SwiftUI

struct PullsSwiftUIView: View {
    @ObservedObject var pullViewModel = PullsViewModel()
    var body: some View {
        NavigationView {
            List(pullViewModel.pulls, id:\.id) { pull in
                VStack(alignment: .leading, spacing: 5, content: {
                    Text(pull.title)
                        .font(.headline)
                    
                    Text(pull.user?.login ?? "")
                        .font(.subheadline)
                    
                    if let nsURL = URL(string:pull.user?.avatar_url ?? "") {
                        AsyncImage(
                            url: nsURL,
                           placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() }
                        )
                       .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3) // 2:3 aspect ratio
                    } 
                })
            }.navigationBarTitle(Text("PRs"))
        }
    }
}

struct PullsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PullsSwiftUIView()
    }
}


let posters = [
    "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg",
    "https://image.tmdb.org/t/p/original/vqzNJRH4YyquRiWxCCOH0aXggHI.jpg",
    "https://image.tmdb.org/t/p/original/6ApDtO7xaWAfPqfi2IARXIzj8QS.jpg",
    "https://image.tmdb.org/t/p/original/7GsM4mtM0worCtIVeiQt28HieeN.jpg"
].map { URL(string: $0)! }

struct ContentView: View {
    var body: some View {
         List(posters, id: \.self) { url in
             AsyncImage(
                url: url,
                placeholder: { Text("Loading ...") },
                image: { Image(uiImage: $0).resizable() }
             )
            .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3) // 2:3 aspect ratio
         }
    }
}
