//
//  TabMenu.swift
//  boissibook
//
//  Created by Rémy Machavoine on 03/07/2022.
//

import SwiftUI

struct TabMenu: View {
    var body: some View {
        TabView {
            BooksHome()
                .tabItem {
                    Image(systemName: "house")
                }
            SearchBook()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            DownloadBooks()
                .tabItem {
                    Image(systemName: "house")
                }
        }
    }
}

struct TabMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabMenu()
    }
}
