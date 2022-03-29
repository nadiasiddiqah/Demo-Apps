import SwiftUI
import UIKit
import CropViewController

struct ContentView: View {
    
    enum SheetType {
        case imagePick
        case imageCrop
        case share
    }
    
    @State private var currentSheet: SheetType = .imagePick
    @State private var actionSheetIsPresented = false
    @State private var sheetIsPresented = false
    
    @State private var originalImage: UIImage?
    @State private var image: UIImage?
    @State private var croppingStyle = CropViewCroppingStyle.default
    @State private var croppedRect = CGRect.zero
    @State private var croppedAngle = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if image == nil {
                    Text("Tap '+' to choose a photo.")
                        .foregroundColor(Color(UIColor.systemBlue))
                } else {
                    GeometryReader { geometry in
                        Image(uiImage: self.image!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width,
                               height: geometry.size.width)
                            .onTapGesture {
                                self.didTapImageView()
                            }
                    }
                }
            }
            .navigationBarTitle(Text(NSLocalizedString("CropViewController", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.actionSheetIsPresented.toggle()
            }) {
                Image(systemName: "plus")
            })
        }
        .actionSheet(isPresented: $actionSheetIsPresented) {
            ActionSheet(title: Text(""), message: nil, buttons: [
                .default(Text("Crop Image"), action: {
                    self.croppingStyle = .default
                    self.currentSheet = .imagePick
                    self.sheetIsPresented = true
                }),
                .default(Text("Make Profile Picture"), action: {
                    self.croppingStyle = .circular
                    self.currentSheet = .imagePick
                    self.sheetIsPresented = true
                })
            ])
        }
        .sheet(isPresented: $sheetIsPresented) {
            if (self.currentSheet == .imagePick) {
                ImagePickerView(croppingStyle: self.croppingStyle, sourceType: .photoLibrary, onCanceled: {
                    // on cancel
                }) { (image) in
                    guard let image = image else {
                        return
                    }
                    
                    self.originalImage = image
                    DispatchQueue.main.async {
                        self.currentSheet = .imageCrop
                        self.sheetIsPresented = true
                    }
                }
            } else if (self.currentSheet == .imageCrop) {
                ImageCropView(croppingStyle: self.croppingStyle, originalImage: self.originalImage!, onCanceled: {
                    // on cancel
                }) { (image, cropRect, angle) in
                    // on success
                    self.image = image
                }
            }
        }
    }
    
    internal func didTapImageView() {
        
    }
}

//struct ContentView: View {
//    @State private var isShowPhotoLibrary = false
//    @State private var image = UIImage()
//
//    var body: some View {
//        VStack {
//            Image(uiImage: self.image)
//                .resizable()
//                .frame(width: 350, height: 200)
//                .scaledToFill()
//
//            Button(action: {
//                self.isShowPhotoLibrary = true
//            }, label: {
//                HStack {
//                    Image(systemName: "photo")
//                        .font(.system(size: 20))
//
//                    Text("Photo Library")
//                        .font(.headline)
//                }
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(20)
//                .padding(.horizontal)
//            })
//        }
//        .sheet(isPresented: $isShowPhotoLibrary, content: {
//            ImagePicker(selectedImage: self.$image)
//        })
//    }
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage
//    @Environment(\.presentationMode) private var presentationMode
//    var croppedRect = CGRect.zero
//    var croppedAngle = 0
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = context.coordinator
//        imagePicker.sourceType = .photoLibrary
//
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//    }
//
//    final class Coordinator: NSObject, CropViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        var parent: ImagePicker
//
//        private var croppingStyle = CropViewCroppingStyle.default
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//            guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
//
//            let cropController = CropViewController(croppingStyle: croppingStyle, image: image)
//
//            cropController.modalPresentationStyle = .fullScreen
//            cropController.delegate = self
//
//            cropController.customAspectRatio = CGSize(width: 7, height: 4)
//            cropController.aspectRatioPreset = .presetCustom //Set the initial aspect ratio as a square
//            cropController.aspectRatioLockEnabled = true // The crop box is locked to the aspect ratio and can't be resized away from it
//            cropController.resetAspectRatioEnabled = false // When tapping 'reset', the aspect ratio will NOT be reset back to default
//            cropController.aspectRatioPickerButtonHidden = true
//
//            cropController.rotateButtonsHidden = true
//            cropController.rotateClockwiseButtonHidden = true
//
//            self.parent.selectedImage = image
//
//            picker.pushViewController(cropController, animated: true)
//        }
//
//        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
//            parent.croppedRect = cropRect
//            parent.croppedAngle = angle
//        }
//
//        func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
//            parent.selectedImage = image
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
