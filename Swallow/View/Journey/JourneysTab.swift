//
//  JourneysTab.swift
//  Swallow
//
//  Created by Kathy on 2021/8/12.
//

import SwiftUI

struct JourneysTab: View {

    @State private var showingSelectJourneyTypePopup = false
    @State private var showingCreateJourneyPopup = false

    @State private var journey: Journey = Journey.init()
    @Binding private var journeys: [Journey]

    init(journeys: Binding<[Journey]> ) {
        self._journeys = journeys
    }

    var filterJourneys: [Journey] {
        return self.journeys.sorted(by: {$0.date > $1.date}).filter({$0.date.isSameDate(self.journey.date)})
    }

    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            VStack {
                DatePicker("日期", selection: self.$journey.date, displayedComponents: .date)
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
            let values: [JourneyType] = JourneyType.allCases
            ForEach(values, id: \.self) { type in
                Button(action: {
                    self.showingSelectJourneyTypePopup.toggle()
                    self.showingCreateJourneyPopup.toggle()
                    self.journey.type = type
                    self.journey.title = type.localize()
                }) {
                    Image(type.rawValue)
                        .renderingMode(.original)
                }
            }
        }
        .frame(width: 300, height: 100)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }

    private func createJourneyPopup() -> some View {
        VStack{
            Image(self.journey.type.rawValue)
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(width: 100, height: 100)

            Text("新增 \(self.journey.date.convertDateToString()) \(self.journey.type.localize())")
                .foregroundColor(.white)
                .fontWeight(.bold)

            Spacer()

            DatePicker(selection: self.$journey.date, label: { Text("時間") })

            TextField("標題", text: $journey.title)
                .background(Color.white)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.pinkColor, lineWidth: 1)
                )

            TextEditor(text: $journey.content)
                .frame(height: 100)
                .lineSpacing(10)
                .autocapitalization(.words)
                .disableAutocorrection(true)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.pinkColor, lineWidth: 1)
                )
            Spacer()

            Button(action: {
                self.showingCreateJourneyPopup.toggle()
                self.journey.id = UUID()
                self.journeys.append(self.journey)
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
        .padding(EdgeInsets(top: 70, leading: 20, bottom: 40, trailing: 20))
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}
