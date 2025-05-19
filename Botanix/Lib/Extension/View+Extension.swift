import SwiftUI

extension View {
    @ViewBuilder
    public func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
    
    func onReceive(
        _ name: Notification.Name,
        center: NotificationCenter = .default,
        object: AnyObject? = nil,
        perform action: @escaping (Notification) -> Void
    ) -> some View {
        onReceive(
            center.publisher(for: name, object: object),
            perform: action
        )
    }
    
    func onReceiveByType<T: RawRepresentable, V: Any>(
        _ name: Notification.Name,
        type: T.Type = T.self,
        center: NotificationCenter = .default,
        object: AnyObject? = nil,
        additionalUserInfo: (String, V.Type)? = ("", Any.self),
        perform action: @escaping (T, V?) -> Void
    ) -> some View where T.RawValue == String, V: Any {
        onReceive(
            center.publisher(for: name, object: object)) { notification in
                if let userInfo = notification.userInfo,
                   let statusString = userInfo["status"] as? String,
                   let status = T(rawValue: statusString) {
                    if let (key, type) = additionalUserInfo,
                       !key.isEmpty && type != Any.self,
                       let value = userInfo[key] as? V
                    {
                        action(status, value)
                    } else {
                        action(status, nil)
                    }
                }
            }
    }
    
    @ViewBuilder
    public func vStandardView(withPadding: Bool = true) -> some View {
        if withPadding {
            padding(.horizontal, .mediumPadding)
                .background(Color.ui.background)
        } else {
            background(Color.ui.background)
        }
    }
    
    @ViewBuilder
    public func vCellView() -> some View {
        frame(width: 360, height: 140)
            .background(Color.ui.cellBackground)
            .listRowBackground(Color.clear)
            .contentShape(Rectangle())
            .cornerRadius(10)
    }
    
    @ViewBuilder
    public func vDisclosureGroup() -> some View {
        padding()
            .background(Color.ui.cellBackground)
            .cornerRadius(8)
            .listRowBackground(Color.clear)
    }
    
    
    @ViewBuilder
    public func vText(font: Font = .vBodyMedium, color: Color = Color.ui.text) -> some View {
        foregroundColor(color)
            .font(font)
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    public func vTextField(title: String, tip: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4){
            Spacer().frame(height: 10)
            Text(title).vText(font: .vBodyMediumBold)
            Spacer().frame(height: 10)
            TextField("", text: text, prompt: Text(tip).foregroundColor(Color.ui.text.opacity(0.5)))
                .padding()
                .background(Color.ui.background)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.ui.text, lineWidth: 1)
                )
                .foregroundColor(Color.ui.text)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .accentColor(Color.ui.text)
        }
    }
    
    @ViewBuilder
    public func vSecureTextField(title: String, tip: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4){
            Spacer().frame(height: 10)
            Text(title).vText(font: .vBodyMediumBold)
            Spacer().frame(height: 10)
            SecureField("", text: text, prompt: Text(tip).foregroundColor(Color.ui.text.opacity(0.5)))
                .padding()
                .background(Color.ui.background)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.ui.text, lineWidth: 1)
                )
                .foregroundColor(Color.ui.text)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .accentColor(Color.ui.text)
        }
    }
    
    @ViewBuilder
    public func vListStyle() -> some View {
        listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .listRowBackground(Color.clear)
    }
    
    @ViewBuilder
    public func vScrollViewStyle() -> some View {
        
    }
    
    @ViewBuilder
    func vNavigationBar(_ localizedKey: String = "", navigationTitle: String, navigationBarBackButtonHidden: Bool, withSettingsButton: Bool = false) -> some View {
        navigationBarTitleDisplayMode(.inline)
            .navigationTitle(navigationTitle)
            .navigationBarBackButtonHidden(navigationBarBackButtonHidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    vDestinationIconButton(destination: SettingsView(), systemName: "gearshape.fill")
                        .opacity(withSettingsButton ? 1 : 0)
                }
                
                ToolbarItem(placement: .principal) {
                    Text(navigationTitle)
                        .vText(font: .vHeadlineSmall, color: Color.ui.text)
                }
            }
    }
    
    
    @ViewBuilder
    public func vButton(action: @escaping @MainActor() async -> (), buttonText: String) -> some View {
        HStack(alignment: .center) {
            Button(action: {
                Task {
                    await action()
                }
            }) {
                Text(buttonText)
                    .font(.headline)
                    .foregroundColor(Color.ui.text)
                    .frame(width: 350, height: 55)
                    .background(Color.ui.accent)
                    .cornerRadius(10)
            }
        }
    }
    
    @ViewBuilder
    public func vDestinationButton(destination: some View, buttonText: String) -> some View {
        HStack(alignment: .center) {
            NavigationLink(destination: destination){
                Text(buttonText)
                    .font(.headline)
                    .foregroundColor(.ui.text)
                    .frame(width: 350, height: 55)
                    .background(Color.ui.accent)
                    .cornerRadius(10)
            }
        }
    }
    
    @ViewBuilder
    public func vDestinationIconButton(destination: some View, systemName: String) -> some View {
        HStack(alignment: .center) {
            NavigationLink(destination: destination){
                Image(systemName: systemName)
                    .foregroundColor(Color.ui.text)
                    .font(.system(size: 20))
                    .opacity(0.7)
            }
        }
    }
    
    @ViewBuilder
    public func vInlineDestinationButton(preText: String, text: String, destination: some View, alignment: Alignment = .center) -> some View {
        Spacer().frame(height: 20)
        HStack(){
            Text(preText)
                .vText(font: .vLabelLarge)
            NavigationLink(destination: destination){
                Text(text)
                    .vText(font: .vLabelLargeBold)
            }
        }.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    public func vDivider() -> some View {
        Divider()
            .frame(height: 0.5)
            .background(Color.ui.text.opacity(0.5))
    }
    
    @ViewBuilder
    public func vCellImage(image: UIImage, width: CGFloat, height: CGFloat, cornerRadius: CGFloat? = nil) -> some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius ?? 0)
        //            .scaledToFit()
    }
    
    @ViewBuilder
    public func vImage(imageName: String, width: CGFloat, height: CGFloat, cornerRadius: CGFloat? = nil) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius ?? 0)
    }
    
    @ViewBuilder
    public func vInlineAlert(error: Binding<String>) -> some View{
        Spacer().frame(height: 20)
        HStack(){
            Text(error.wrappedValue)
                .vText(font: .vLabelLargeBold, color: Color.ui.danger)
        }.frame(maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    public func vStandardAlert(_ alertItem: Binding<VAlertItem?>) -> some View {
        alert(item: alertItem) { alertItem in
            if let secondaryButton = alertItem.secondaryButton {
                Alert(title: Text(alertItem.title),
                      message: Text(alertItem.message ?? ""),
                      primaryButton: alertItem.dismissButton,
                      secondaryButton: secondaryButton
                )
            } else {
                Alert(title: Text(alertItem.title),
                      message: Text(alertItem.message ?? ""),
                      dismissButton: alertItem.dismissButton
                )
            }
        }
    }
    
    @ViewBuilder
    public func vSettingsSection(header: String, buttons: [VSettingsButton], destinationButtons: [VDestinationSettingsButton]) -> some View {
        Section {
            Text(header)
                .foregroundColor(Color.ui.text)
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.ui.cellBackground)
                    .padding(.vertical, 4)
                
                VStack(alignment: .leading){
                    if !buttons.isEmpty {
                        ForEach(buttons) { button in
                            vSettingsButton(buttonText: button.buttonText, action: button.action)
                            
                            if button.id != buttons.last?.id {
                                Divider()
                                    .background(Color.ui.text)
                            }
                        }
                    }
                    
                    if !destinationButtons.isEmpty {
                        
                        if (!buttons.isEmpty){
                            Divider()
                                .background(Color.ui.text)
                        }
                        
                        ForEach(destinationButtons) { destinationButton in
                            vDestinationSettingsButton(buttonText: destinationButton.buttonText, destination: destinationButton.destination)
                            
                            if destinationButton.id != destinationButtons.last?.id {
                                Divider()
                                    .background(Color.ui.text)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    
    @ViewBuilder
    public func vSettingsButton(buttonText: String, action: @escaping @MainActor() async -> ()) -> some View {
        Button(action: {
            Task { await action() }
        }) {
            HStack {
                Text(buttonText)
                    .vText()
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    public func vDestinationSettingsButton(buttonText: String, destination: @escaping () -> AnyView) -> some View {
        NavigationLink(destination: destination()) {
            HStack {
                Text(buttonText)
                    .vText()
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    public func vikaSave(onSave: @escaping () -> Void) -> some View {
        toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(alignment: .center) {
                    Button(action: {
                        onSave()
                    }) {
                        Image(systemName: "checkmark")
                            .resizable()
                            .vText(font: .vLabelLarge, color: Color.ui.text)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    public func vikaStandardNavBack(dismiss: DismissAction, enabled: Bool = true) -> some View {
        navigationBarBackButtonHidden(true)
            .if(enabled) { view in
                view
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            HStack(alignment: .center) {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .vText(font: .vLabelLarge, color: Color.ui.text)
                                }
                            }
                        }
                    }
            }
    }
    
    @ViewBuilder
    public func vikaButton(backgroundColor: Color = Color.ui.accent) -> some View {
        padding(.mediumPadding)
            .background(backgroundColor)
    }
    
    @ViewBuilder
    public func vikaCircleImage(borderWidth: CGFloat = 1, innerPadding: CGFloat = .mediumPadding, imageContentMode: ContentMode = .fit, newSize: CGFloat = 64) -> some View {
        aspectRatio(contentMode: imageContentMode)
            .padding(innerPadding)
            .clipShape(Circle())
            .frame(width: newSize)
            .overlay(Circle().stroke(Color.ui.text, lineWidth: borderWidth))
    }
    
    @ViewBuilder
    public func vikaTextField(autoCapitalization: Bool = false, autoCorrection: Bool = false, keyboardType: UIKeyboardType = .default, shouldPlaceholderMove: Bool, isFocused: FocusState<Bool>.Binding) -> some View {
        vText(font: .vBodyLarge)
            .autocapitalization(autoCapitalization ? .sentences : .none)
            .disableAutocorrection(autoCorrection ? false : true)
            .keyboardType(keyboardType)
            .offset(y: !shouldPlaceholderMove ? 0 : +10)
            .focused(isFocused)
            .tint(Color.ui.text)
    }
    
    
    @ViewBuilder
    public func vikaListStyle() -> some View {
        self.onAppear() {
            UITableView.appearance().backgroundColor = .clear
            UIScrollView.appearance().backgroundColor = .clear
        }
    }
    
    @ViewBuilder
    public func vikaFormStyle() -> some View {
        scrollContentBackground(.hidden)
            .background(Color.white)
            .listRowInsets(EdgeInsets())
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
