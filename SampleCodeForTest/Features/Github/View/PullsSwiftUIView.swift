//
//  PullsSwiftUIView.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import SwiftUI

struct PullsSwiftUIView: View {
    
    typealias Factory = DependencyContainerProtocol

    private let container: Factory
    
    @ObservedObject var pullViewModel: PullsViewModel
    
    init(container: Factory) {
        self.container = container
        self.pullViewModel = container.makeViewModel()
    }
    
    var body: some View {
        NavigationView {
            AsyncLoadableView(source: pullViewModel) { pulls in
                List(pulls, id:\.id) { pull in
                    NavigationLink(
                        destination: PullDetailSwiftUIView(pull: pull),
                        label: {
                            CellView(pull: pull)
                        })
                }.navigationBarTitle(Text("PRs"))
            }
        }
    }
}

struct CellView:View {
    
    var pull:Pull
    
    init(pull:Pull) {
        self.pull = pull
    }
    
    var body: some View {
        HStack {
            if let nsURL = URL(string:pull.user?.avatar_url ?? "") {
                AsyncImage(
                    url: nsURL,
                   placeholder: { Text("Loading ...") },
                   image: { Image(uiImage: $0).resizable() }
                )
                .frame(width: 50, height:50)
                .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 5, content: {
                Text(pull.title)
                    .font(.headline)
                Text(pull.user?.login ?? "")
                    .font(.subheadline)
            })
        }
    }
}

struct PullsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PullsSwiftUIView(container: DependencyContainer())
    }
}
