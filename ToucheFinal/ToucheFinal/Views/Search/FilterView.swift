//
//  FilterView.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//

import SwiftUI
import Combine


final class FilterViewModel: ObservableObject {
    @Published var brands: [Brand] = []
    @Published var colors: [PerfumeColor] = []
    @Published var canApplying: Bool = false
    @Published var tab: Tab = .brand
    @Published var brandSearch: String = ""
    @Published var colorSearch: String = ""
    @Published var isShowingOverCheckedBrandAlert = false
    @Published var isShowingOverCheckedColorAlert = false
    
    // grouping: [https://www.hackingwithswift.com/forums/swift/best-way-to-group-string-array-by-first-character-and-show-in-table-view-as-groups/298](https://www.hackingwithswift.com/forums/swift/best-way-to-group-string-array-by-first-character-and-show-in-table-view-as-groups/298)
    
    var brandSections: [(letter: String, brands: [Brand])]  {
        let filtered = Brand.dummy.filter {
            if brandSearch.isEmpty {
                return true
            } else {
                return $0.name.lowercased().contains(brandSearch.lowercased())
            }
        }

        return Dictionary(grouping: filtered) { (brand) -> Character in
                return brand.name.first!
            }
        .map { (key: Character, value: [Brand]) -> (letter: String, brands: [Brand]) in
            (letter: String(key), brands: value)
        }
        .sorted { (left, right) -> Bool in
            left.letter < right.letter
        }
        
        
    }
    
    var colorSections: [(letter: String, colors: [PerfumeColor])]  {
        let filtered = PerfumeColor.types.filter {
            if colorSearch.isEmpty {
                return true
            } else {
                return $0.name.lowercased().contains(colorSearch.lowercased())
            }
        }

        return Dictionary(grouping: filtered) { (brand) -> Character in
                return brand.name.first!
            }
        .map { (key: Character, value: [PerfumeColor]) -> (letter: String, colors: [PerfumeColor]) in
            (letter: String(key), colors: value)
        }
        .sorted { (left, right) -> Bool in
            left.letter < right.letter
        }
    }
    
    enum Tab {
        case brand
        case color
    }
    
    init() {
        /// Apply????????? ?????????????????? ??????????????? ????????????.
        $brands
            .combineLatest($colors)
            .map { brands, colors -> Bool in
                return !brands.isEmpty || !colors.isEmpty
            }
            .assign(to: &$canApplying)
    }
    
    /// ?????? ????????? ???????????? ????????? ?????? ??????
    func isSelectedBrand(_ brand: Brand) -> Bool {
        return brands.contains(brand)
    }
    
    /// ?????? ????????? ????????? ????????? ?????? ??????
    func isSelectedColor(_ perfumeColor: PerfumeColor) -> Bool {
        return colors.contains(perfumeColor)
    }
    
    /// ????????? ????????? ??????
    func appendBrand(_ brand: Brand) {
        brands.append(brand)
    }
    
    /// ????????? ????????? ??????
    func removeBrand(_ brand: Brand) {
        brands = brands.filter { $0.id != brand.id }
    }
    
    /// ????????? ?????? ??????
    func apppendColor(_ color: PerfumeColor) {
        colors.append(color)
    }
    
    /// ????????? ?????? ??????
    func removeColor(_ color: PerfumeColor) {
        colors = colors.filter { $0.id != color.id }
    }
    
    /// Tab ?????????
    func toggleTab(_ tab: FilterViewModel.Tab) {
        self.tab = tab
        switch self.tab {
        case .brand:
            colors.removeAll()
            colorSearch = ""
        case .color:
            brands.removeAll()
            brandSearch = ""
        }
    }
    
    /// ?????? ???????????? ??????
    func clear() {
        brands.removeAll()
        colors.removeAll()
        colorSearch = ""
        brandSearch = ""
    }
}

struct FilterView: View {
    @EnvironmentObject var vm: FilterViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            // - HEADER
            filterHeaderView()
            // - BODY
            filterBodyView()
        }
        .padding(.top, 4.0)
        .padding(.bottom, vm.canApplying ? 40.0 + 30.0 : 0.0)
        // - BUTTON GROUP
        .overlay(alignment: .bottom, content: filterButtonGroupView)
        .overlay(alignment: .center) {
            Text((vm.brandSections.isEmpty || vm.colorSections.isEmpty) ? "No Results here.." : "")
                .foregroundStyle(.tertiary)
                .ignoresSafeArea(.keyboard)
        }
        .searchable(text: vm.tab == .brand ? $vm.brandSearch : $vm.colorSearch, prompt: "Search")
        .scrollDismissesKeyboard(.interactively)
        .navigationBarTitle("Filter")
        .navigationBarTitleDisplayMode(.inline)
        .keyboardType(.alphabet)
        .modifier(KeyboardTextField())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}

/// FilterView??? ?????? ???????????? ???
private extension FilterView {
    /// FilterView??? HeaderView
    ///
    /// - Tab??? ?????? brand ?????? color??? ???????????????, ????????? ????????? header??? ?????????????????????.
    /// - ????????? ????????? ?????????, ?????? ????????????.
    func filterHeaderView() -> some View {
        Group {
            switch vm.tab {
            case .brand:
                // Brand
                HStack(alignment: .center) {
                    Text("Brand ")
                        .font(.headline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                                ForEach(vm.brands, id: \.self) { brand in
                                    
                                    HStack {
                                        Text(brand.name)
                                            .fontWeight(.light)
                                        Image(systemName: "xmark")
                                    }
                                    .frame(height: 10)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .circular)
                                            .strokeBorder(.secondary, lineWidth: 0.5)
                                    }
                                    .padding(1)
                                    .onTapGesture {
                                        vm.removeBrand(brand)
                                    }
                                }
                        }//LazyHStack
                    }
                }
                
                Divider()
                
            case .color:
                // Type
                HStack(alignment: .center) {
                    Text("Color")
                        .font(.headline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                                ForEach(vm.colors, id: \.id) { perfumeColor in
                                    HStack(spacing: 4.0) {
                                        Circle()
                                            .frame(width: 10)
                                            .foregroundColor(perfumeColor.color)
                                        Text(perfumeColor.name)
                                            .fontWeight(.light)
                                        Image(systemName: "xmark")
                                    }
                                    .frame(height: 10)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .circular)
                                            .strokeBorder(.secondary, lineWidth: 0.5)
                                    }
                                    .padding(1)
                                    .onTapGesture {
                                        vm.removeColor(perfumeColor)
                                    }
                                }
                        }//LazyHStack
                    }
                }
                
                Divider()
            }
        }
        .frame(height: 30, alignment: .center)
        .padding(.horizontal, 16.0)
    }
    
    /// FilterView??? BodyView
    ///
    /// - Body??? ?????? ???????????? SelectionView??? ContentView??? ????????????.
    /// - Body?????? ??????????????? ??????.
    func filterBodyView() -> some View {
        HStack(alignment: .top, spacing: 4.0) {
            filterSelectionView()
            
            filterContentView()
        }
    }
    
    /// Tab Selection View
    ///
    /// - ????????? Tab??? ??????, Header??? Content??? ?????????.
    func filterSelectionView() -> some View {
        VStack(alignment: .leading, spacing: 32.0) {
            Text("**01**\nBrand")
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 3)
                        .foregroundColor(vm.tab == .brand ? .primary : .clear)
                }
                .onTapGesture { vm.toggleTab(.brand) }
            
            Text("**02**\nColor")
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 3)
                        .foregroundColor(vm.tab == .color ? .primary : .clear)
                }
                .onTapGesture { vm.toggleTab(.color) }
        }
        .frame(width: 60)
        .padding(.leading, 16.0)
    }
    
    /// ContentView
    ///
    /// - Tab??? ?????? ?????? ???????????? ???????????? ????????????.
    /// - ???????????? ????????????, checkmark??? ????????????, ?????? ???????????? checkmark??? ????????????. ???, ???????????? ??????????????? ????????? ??? ??????.
    func filterContentView() -> some View {
        Group {
            switch vm.tab {
            case .brand:
                ScrollViewReader { proxy in
                    List(vm.brandSections.indices, id: \.self) { index in
                        Section(vm.brandSections[index].letter) {
                            ForEach(vm.brandSections[index].brands) { brand in
                                Button {
                                    //MARK: ?????? 10???????????? ??????????????? ??????

                                    if vm.brands.count < 11 && vm.isSelectedBrand(brand) {
                                        vm.removeBrand(brand)
                                        
                                        //print("?????? ????????? ????????? ?????????: \(vm.brands.count)")
                                        
                                    } else if vm.brands.count < 10 && !(vm.isSelectedBrand(brand)) {
                                        vm.appendBrand(brand)
                                        
                                        //print("?????? ????????? ????????? ?????????: \(vm.brands.count)")
                                        
                                    } else if vm.brands.count == 10 {
                                        
                                        //print("?????? ????????? ????????? ?????????: \(vm.brands.count)")
                                        vm.isShowingOverCheckedBrandAlert.toggle()
//                                        print("?????? ??????")
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "checkmark")
                                            .opacity(vm.isSelectedBrand(brand) ? 1.0 : 0.0)
                                        Text(brand.name)
                                    }
                                }
                                .id(brand)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            case .color:
                ScrollViewReader { proxy in
                    List(vm.colorSections.indices, id: \.self) { index in
                        Section(vm.colorSections[index].letter) {
                            ForEach(vm.colorSections[index].colors) { color in
                                Button {
                                    if vm.colors.count < 11 && vm.isSelectedColor(color) {
                                        vm.removeColor(color)
                                        
                                        //print("?????? ????????? ?????? ?????????: \(vm.colors.count)")
                                        
                                    } else if vm.colors.count < 10 && !(vm.isSelectedColor(color)) {
                                        vm.apppendColor(color)
                                        
                                        //print("?????? ????????? ?????? ?????????: \(vm.colors.count)")
                                        
                                    } else if vm.colors.count == 10 {
                                        
                                        //print("?????? ????????? ????????? ?????????: \(vm.brands.count)")
                                        vm.isShowingOverCheckedColorAlert.toggle()
                                        //print("?????? ??????")
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "checkmark")
                                            .opacity(vm.isSelectedColor(color) ? 1.0 : 0.0)
                                        Circle()
                                            .frame(width: 20)
                                            .foregroundColor(color.color)
                                        Text(color.name)
                                    }
                                }
                                .id(color)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
    
    /// FilterButtonGroup
    ///
    /// 1. **Clear**: ????????? ?????? ???????????? ?????? ????????????.
    /// 2. **Apply**: ????????? ????????? ???????????? ???????????? ????????? ???????????? ??????, ????????? ????????? ???????????? ????????? ????????? ???????????????.
    func filterButtonGroupView() -> some View {
        HStack {
            Button {
                vm.clear()
            } label: {
                Text("Clear")
                    .frame(height: 40.0)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 20.0, style: .circular)
                            .strokeBorder(lineWidth: 1)
                            .background { Color.white }
                    }
            }
            .tint(.primary)
            
            NavigationLink {
                switch vm.tab {
                case .brand:
                    let queries = vm.brands.map { $0.name }
                    FilteringResultView(field: "brandName", queries: queries)
                case .color:
                    let queries = vm.colors.map { $0.name }
                    FilteringResultView(field: "scentType", queries: queries)
                }
            } label: {
                Text("Apply")
                    .frame(height: 40.0)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 20.0, style: .circular)
                    }
            }
            .tint(.primary)
            .disabled(!vm.canApplying)
        }
        .padding(.horizontal, 16.0)
        .padding(.bottom, 20.0)
        .opacity(vm.canApplying ? 1.0 : 0.0)
        .offset(y: vm.canApplying ? 0.0 : 100.0)
        .animation(.spring(), value: vm.canApplying)
    }
}
