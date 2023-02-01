//
//  PerfumeColor.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//
import Foundation
import SwiftUI


struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Bookmark]?
    
    // some example websites
    static let apple = Bookmark(name: "Apple", icon: "1.circle")
    static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil")
    static let swift = Bookmark(name: "Swift", icon: "bolt.fill")
    static let twitter = Bookmark(name: "Twitter", icon: "mic")
    
    // some example groups
    static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    
    static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    
    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
}

struct PerfumeColor: Identifiable, Hashable {
    var id = UUID().uuidString

    var name: String
    var hexValue: String
    var color: Color {
        Color(hex: hexValue) ?? Color.clear
    }
    var description: [String]?
    
    /*
    static var types: [PerfumeColor] = [
        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C"),
        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818"),
        PerfumeColor(name: "Warm Florals", hexValue: "E26262"),
        PerfumeColor(name: "Warm Woods", hexValue: "895151"),
        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680"),
        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182"),
        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3"),
        PerfumeColor(name: "Woody Spices", hexValue: "513737"),
        PerfumeColor(name: "Cool Spices", hexValue: "326D98"),
        PerfumeColor(name: "Classic Woods", hexValue: "595252"),
        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795"),
        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00"),
        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0"),
        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7"),
        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA"),
        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E")
    ]
     */
    
    static var types: [PerfumeColor] = [
        PerfumeColor(name: "Fruity Florals", hexValue: "EC3C3C", description: ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ullamcorper in arcu vel cursus. Nulla facilisi. Morbi egestas sodales tristique. Vestibulum a metus dui. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris eget cursus erat. Duis elementum arcu ante. Sed vitae maximus neque. Donec varius velit nec neque ultricies elementum."]),
        PerfumeColor(name: "Warm & Sweet Gourmands", hexValue: "A11818", description: ["Maecenas dictum mattis est porttitor accumsan. Pellentesque vel tempor mauris. Nunc ornare, metus et lobortis accumsan, nisi augue varius nunc, sed porttitor elit magna at magna. Aenean hendrerit purus ante, ac convallis elit lacinia eget. Ut vulputate nec nunc nec volutpat. Etiam quis eros non leo accumsan elementum. Ut eros nisl, interdum et lobortis eget, lacinia vitae erat. Praesent eget maximus est, vitae ornare elit. Pellentesque vulputate neque eget sodales mattis. Pellentesque lacinia dolor sapien, eu lobortis felis scelerisque ac. Praesent suscipit semper erat fringilla euismod. Vestibulum sed tellus turpis."]),
        PerfumeColor(name: "Warm Florals", hexValue: "E26262", description: ["Mauris ut convallis dolor, eu auctor metus. Donec diam urna, congue mollis augue ut, faucibus egestas arcu. Quisque sed eleifend augue, quis lobortis sapien. Phasellus ac tincidunt purus. Donec porttitor quam nec massa interdum molestie. Etiam ligula lectus, scelerisque ut lorem eu, commodo interdum justo. Morbi ac luctus lectus"]),
        PerfumeColor(name: "Warm Woods", hexValue: "895151", description: ["Donec rutrum lacus ligula. Nunc risus nisi, laoreet porta venenatis in, feugiat a diam. Suspendisse ac turpis imperdiet, ornare augue non, ullamcorper diam. In nec dictum elit, sed venenatis libero. Etiam pretium maximus ligula cursus pharetra. Nunc ornare condimentum enim sit amet egestas. Nam vitae tristique mi, non volutpat libero. Etiam placerat nulla arcu, tempor ullamcorper mauris scelerisque sed. Proin sollicitudin consectetur varius. Maecenas posuere vulputate ultricies. Nam at tincidunt felis, ac posuere ex. Ut interdum rhoncus elit ac sagittis. Praesent ullamcorper varius lectus at dapibus."]),
        PerfumeColor(name: "Fresh Florals", hexValue: "FF9680", description: ["Curabitur sit amet dui dolor. Phasellus hendrerit tempus turpis. Nulla mollis commodo purus non dictum. Donec feugiat enim dapibus, eleifend libero at, rutrum nisl. Nullam dapibus, tortor non imperdiet luctus, est urna malesuada justo, at malesuada justo nisl eu est. Etiam metus mauris, lacinia at efficitur quis, facilisis ut nunc. Vivamus gravida vestibulum erat vitae sollicitudin. In magna risus, consequat non felis fringilla, venenatis ullamcorper est. Duis blandit purus in odio venenatis, sed convallis leo pharetra. Pellentesque iaculis tempus nunc lacinia faucibus. Nullam consectetur, urna ac bibendum dictum, nisi nunc feugiat dui, quis sollicitudin orci turpis vel nulla. Curabitur fermentum ante ut cursus pellentesque."]),
        PerfumeColor(name: "Fresh Citrus & Fruits", hexValue: "FCE182", description: ["Fusce lacinia accumsan magna, vitae semper velit vehicula porttitor. Duis enim nisl, molestie vitae ante sit amet, vehicula euismod neque. Quisque vitae risus at nibh aliquet volutpat a quis urna. Maecenas pretium nec leo eget pellentesque. Ut leo metus, vehicula ac accumsan eu, pharetra eget eros. Etiam ultrices et mi id vestibulum. Phasellus et sem dignissim, rhoncus augue a, scelerisque metus."]),
        PerfumeColor(name: "Classic Florals", hexValue: "EC96E3", description: ["Donec sit amet felis id ligula bibendum interdum. Nam tristique efficitur eros, quis consequat mauris lacinia eu. Proin pellentesque turpis nec elit gravida, in commodo dolor placerat. Proin semper metus tristique odio tristique, sed vehicula turpis venenatis. Vivamus a mi quis eros mollis aliquet ac a metus. Praesent hendrerit odio a leo laoreet ornare. Sed quis maximus velit. Quisque non felis nec elit gravida ornare. Duis et diam elementum, maximus diam at, pellentesque metus. Aliquam malesuada elit sit amet turpis vestibulum iaculis. Sed leo mauris, sollicitudin eget dignissim nec, iaculis id magna."]),
        PerfumeColor(name: "Woody Spices", hexValue: "513737", description: ["Praesent cursus eget nibh vitae rutrum. Cras tristique, massa quis tincidunt gravida, leo metus tempor nisi, sit amet lacinia tellus urna id ex. Nam at turpis sit amet urna aliquam commodo. Mauris porttitor imperdiet ante a finibus. Vestibulum sem mauris, pulvinar sed placerat a, sodales at justo. Sed in tincidunt magna. Nullam dapibus nisi id eleifend viverra. Ut condimentum cursus diam a iaculis."]),
        PerfumeColor(name: "Cool Spices", hexValue: "326D98", description: ["Sed blandit ac sapien in fringilla. Nam gravida arcu ultricies est ultrices, ut luctus nisi condimentum. Fusce sed faucibus tortor, eu rhoncus arcu. Nulla varius odio vitae sapien euismod tincidunt ac quis ante. Vivamus lobortis tortor eu vehicula pulvinar. In ac dolor et tellus aliquet pretium non ut ligula. Pellentesque vel mollis dui. Morbi hendrerit blandit nisi eu tempor. Sed feugiat vestibulum rhoncus. Proin nec sollicitudin sem. Praesent aliquet tincidunt quam, vitae consectetur mauris convallis in. Nunc eu orci at risus pellentesque elementum sed non velit. Suspendisse luctus consequat elit eget dapibus. Praesent suscipit, quam sed suscipit maximus, ex magna commodo massa, molestie tristique augue massa ac tortor. Integer eu metus tristique, euismod nisl sed, cursus urna. Duis erat justo, consequat non orci vel, mattis bibendum nulla."]),
        PerfumeColor(name: "Classic Woods", hexValue: "595252", description: ["Curabitur quis eros tellus. Suspendisse cursus ut felis at scelerisque. Cras mollis semper dui in facilisis. Quisque eu enim tempor justo gravida bibendum. Nulla scelerisque quis felis ac consequat. Ut accumsan in enim quis volutpat. Integer a gravida urna. Vivamus fermentum nibh nunc, ac accumsan mi imperdiet ac. Mauris id diam finibus, placerat massa nec, molestie augue. Quisque sodales nibh risus, eget suscipit metus malesuada eu. Maecenas eu velit nec leo aliquet pulvinar fermentum vel nunc. Donec dapibus turpis mattis dolor consectetur interdum. Integer fringilla odio odio, sed venenatis elit interdum pharetra. Mauris non iaculis nunc. Suspendisse vel nibh sem. Maecenas rhoncus nisi id fringilla dictum."]),
        PerfumeColor(name: "Citrus & Woods", hexValue: "B2A795", description: ["Vivamus ornare, enim ut scelerisque eleifend, odio risus scelerisque risus, at aliquam lacus libero ac est. Sed non velit erat. Integer consequat leo id volutpat ultricies. Duis semper elementum interdum. Nulla facilisi. Pellentesque pretium libero nec lobortis sagittis. Praesent ultrices ut sem non mattis. Sed quis dignissim nisl, in luctus velit. Suspendisse lacinia mollis eros quis tincidunt. Duis volutpat erat et odio aliquet, quis sollicitudin justo volutpat. Fusce arcu justo, tincidunt ultricies tincidunt quis, interdum eu lacus. Praesent magna sem, rutrum vitae luctus sit amet, gravida nec nibh. Fusce eget dolor eleifend, aliquam tellus eu, euismod ipsum."]),
        PerfumeColor(name: "Fresh Solar", hexValue: "F0BC00", description: ["Vestibulum purus purus, laoreet vitae scelerisque vitae, molestie nec dui. Donec ultrices lacus id quam vestibulum, eu euismod libero gravida. Nam in aliquet ante. Proin pharetra erat eu diam vestibulum, et tincidunt felis mollis. Etiam porttitor felis vitae nulla lobortis, vel pretium neque varius. Suspendisse potenti. Nam ut facilisis arcu. Ut vitae venenatis sapien, in eleifend quam. Sed condimentum magna sit amet dolor sodales posuere. Ut efficitur, quam id pretium aliquam, lacus metus fermentum neque, vehicula efficitur dolor libero eu nisl. Nam eget risus placerat, placerat massa at, euismod lectus. Cras diam mi, volutpat eget dui a, blandit ornare ligula. Quisque ut elementum nibh. Mauris vel tortor blandit, vulputate tellus et, suscipit turpis."]),
        PerfumeColor(name: "Warm & Sheer", hexValue: "B8B0B0", description: ["Nunc vel risus neque. Nunc in sem purus. Phasellus et ultrices augue. Quisque eget orci venenatis, sodales eros convallis, tincidunt metus. Quisque ullamcorper aliquam velit. Nullam ac rhoncus erat. Aenean placerat tincidunt quam non scelerisque. Cras massa ipsum, vehicula at rutrum a, aliquam ac urna. Pellentesque eget eros luctus, porttitor est a, fringilla nisl. Curabitur semper placerat libero sit amet gravida. Etiam consequat nibh eget nibh dignissim fringilla. Nulla finibus efficitur lectus, a semper justo ornare non. Fusce non interdum nisl. Aliquam justo erat, sagittis vitae porttitor non, aliquam porta quam."]),
        PerfumeColor(name: "Powdery Florals", hexValue: "D933C7", description: ["Duis et magna non orci iaculis fringilla et quis diam. Curabitur libero eros, finibus nec mollis at, fringilla ut metus. Maecenas in tincidunt lacus. Morbi arcu nulla, cursus et interdum a, sagittis eget quam. Ut fermentum non ipsum a dignissim. Nunc suscipit tincidunt dictum. Cras et sapien non neque ultrices pellentesque ultricies quis ex. Donec pulvinar lacus a lectus pharetra laoreet ut sit amet felis. Nullam ac blandit velit, at sodales est. Nullam eros lacus, tristique nec varius quis, commodo eu erat. Sed auctor maximus diam eu imperdiet. Donec sodales, mauris ut tempor mattis, erat arcu feugiat nibh, sit amet porta lacus elit lacinia metus. Curabitur dignissim semper pharetra. Vivamus suscipit eros id lorem dictum, vitae ornare neque aliquam."]),
        PerfumeColor(name: "Fresh Aquatics", hexValue: "2C5DDA", description: ["Ut eget blandit elit, a semper est. Etiam dictum ante vel dui elementum, vel tempor lacus pharetra. Etiam quis scelerisque arcu. Fusce porta ipsum eros, quis sodales odio fringilla in. Fusce scelerisque massa libero, ut sollicitudin massa pellentesque in. Quisque sodales nibh sed tristique aliquet. Aenean risus elit, efficitur id ultrices in, elementum quis diam. Nulla cursus, magna a volutpat aliquet, velit magna mattis dolor, eu tristique metus mi eget ipsum. Ut tincidunt ligula sed dui tristique consequat. Phasellus quis tellus sit amet arcu molestie pharetra sed non lorem. Suspendisse sed enim vel libero ornare viverra."]),
        PerfumeColor(name: "Earthy Greens & Herbs", hexValue: "4B9A4E", description: ["Integer pharetra ex vitae imperdiet iaculis. Sed blandit erat vel enim feugiat, vel facilisis lacus blandit. In ac semper velit. Sed rhoncus congue semper. Maecenas lacinia sem at ante cursus, in imperdiet erat viverra. Curabitur risus eros, vehicula sed mollis a, sodales et lorem. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nunc sit amet metus eget sapien rutrum condimentum nec venenatis nisl."])
    ]
}
