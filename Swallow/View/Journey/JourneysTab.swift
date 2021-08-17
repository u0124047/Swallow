//
//  JourneysTab.swift
//  Swallow
//
//  Created by Kathy on 2021/8/12.
//

import SwiftUI
import UIKit

struct JourneysTab: View {
    @State var showImagePicker: Bool = false
    @State private var images: [(id: UUID, image: Image)] = []

    @State private var showingSelectJourneyTypePopup = false
    @State private var showingCreateJourneyPopup = false

    @State private var journey: Journey? = Journey(())
    @Binding private var journeys: [Journey]

    init(journeys: Binding<[Journey]> ) {
        self._journeys = journeys
    }

    var filterJourneys: [Journey] {
        return self.journeys.sorted(by: {$0.date ?? Date() > $1.date ?? Date()}).filter({($0.date ?? Date()).isSameDate(self.journey?.date ?? Date())})
    }

    private var dateBinding: Binding<Date> {
        Binding {
            self.journey?.date ?? Date()
        } set: {
            self.journey?.date = $0
        }
    }
    
    private var titleBinding: Binding<String> {
        Binding {
            self.journey?.title ?? ""
        } set: {
            self.journey?.title = $0
        }
    }

    private var contentBinding: Binding<String> {
        Binding {
            self.journey?.content ?? ""
        } set: {
            self.journey?.content = $0
        }
    }

    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            VStack {
                DatePicker("日期", selection: dateBinding, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "zh_Hant_TW"))
                    .environment(\.calendar, Calendar(identifier: .republicOfChina))
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .background(Color.white)
                    .accentColor(.red)
                    .cornerRadius(10)

                VStack (alignment: .leading, spacing: 0) {
                    List {
                        ForEach(self.filterJourneys, id: \.id) { j in
                            JourneyCell(journey: j)
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .colorMultiply(self.filterJourneys.isEmpty ? Color.white.opacity(0.7) : Color.white)
                    .overlay(Group {
                        if self.filterJourneys.isEmpty {
                            Text("沒有行程")
                        }
                    })
                    .onAppear(perform: {
                        UITableView.appearance().contentInset.top = -35
                    })
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("行程")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(
                    action: { self.showingSelectJourneyTypePopup.toggle() },
                    label: { Text(showingSelectJourneyTypePopup ? "Cancel" : "Add") }
                )
            }
        }
        .popup(isPresented: showingSelectJourneyTypePopup, alignment: .center, content: selectJourneyTypePopup)
        .popup(isPresented: showingCreateJourneyPopup, alignment: .center, content: createJourneyPopup)
    }

    private func selectJourneyTypePopup() -> some View {
        HStack{
            let values: [JourneyType] = JourneyType.shared ?? []
            ForEach(values, id: \.self) { type in
                Button(action: {
                    self.showingSelectJourneyTypePopup.toggle()
                    self.showingCreateJourneyPopup.toggle()
                    self.journey?.journeyType = type.key
                    self.journey?.title = type.value
                    if self.journey?.date == nil {
                        self.journey?.date = Date()
                    }
                }) {
                    if let imgName = type.key {
                        Image(imgName)
                            .renderingMode(.original)
                    }
                }
            }
        }
        .frame(width: 300, height: 100)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }

    private func createJourneyPopup() -> some View {
        VStack {
            ScrollView {
                Group {
                    if let imgName = journey?.journeyType {
                        Image(imgName)
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(width: 100, height: 100)
                    }

                    if let date = journey?.date, let type = journey?.journeyType {
                        Text("新增 \(date.convertDateToString()) \(type)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Group {
                    DatePicker(selection: dateBinding, label: { Text("時間") })

                    TextField("標題", text: titleBinding)
                        .background(Color.white)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.pinkColor, lineWidth: 1)
                        )

                    TextEditor(text: contentBinding)
                        .frame(height: 100)
                        .lineSpacing(10)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.pinkColor, lineWidth: 1)
                        )
                }
                Spacer()
                Group {
                    List(images, id: \.id) { img in
                        img.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    }.frame(height: CGFloat(images.count) * CGFloat(200))
                }
                Spacer()
                Group {
                    Button(
                        action: {
                            self.showImagePicker.toggle()
                        },
                        label: { Text("新增照片") }
                    )

                    Button(action: {
                        self.showingCreateJourneyPopup.toggle()
                        self.journey?.id = UUID()
                        if let _journey = self.journey {
                            self.journeys.append(_journey)
                            Journey.create(journey: _journey)
                            saveImages()
                        }
                    }) {
                        Text("新增")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(10)
                    .frame(width: 300, height: 40)
                    .background(Color.pinkColor)
                    .clipShape(Capsule())

                    Button(action: {
                        self.showingCreateJourneyPopup.toggle()
                    }) {
                        Text("取消")
                            .font(.system(size: 14))
                            .foregroundColor(Color.pinkColor)
                            .fontWeight(.bold)
                    }
                    .padding(10)
                    .frame(width: 300, height: 40)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.pinkColor, lineWidth: 1)
                    )
                }
            }
        }
        .padding(EdgeInsets(top: 70, leading: 20, bottom: 40, trailing: 20))
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(isShown: self.$showImagePicker, images: self.$images)
        }
    }

    func saveImages() {
        if let journeyId = self.journey?.id {
            Photo.createInitialData(journey_id: journeyId, datas: images.map({$0.image.asUIImage()}))
        }
    }
}

class ImagePickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @Binding var isShown    : Bool
    @Binding var images      : [(id: UUID, image: Image)]

    init(isShown : Binding<Bool>, images: Binding<[(id: UUID, image: Image)]>) {
        _isShown = isShown
        _images   = images
    }

    //Selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let img = (id: UUID(), image: Image(uiImage: uiImage))
        images.append(img)
        isShown = false
    }

    //Image selection got cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker : UIViewControllerRepresentable {

    @Binding var isShown    : Bool
    @Binding var images      : [(id: UUID, image: Image)]

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> ImagePickerCordinator {
        return ImagePickerCordinator(isShown: $isShown, images: $images)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
}
