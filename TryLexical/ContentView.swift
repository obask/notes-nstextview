import SwiftUI
import AppKit

struct ContentView: View {
    @State private var attributedText: NSAttributedString = {
        // Create white bold text for dark mode compatibility
        let boldFont = NSFont.boldSystemFont(ofSize: NSFont.systemFontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: NSColor.white
        ]
        return NSAttributedString(string: "Edit this rich text!", attributes: attributes)
    }()

    var body: some View {
        VStack {
            RichTextView(text: $attributedText)
                .frame(height: 200)
                .padding()
            Button("Bold Text") {
                toggleBold()
            }
        }
        .padding()
    }

    private func toggleBold() {
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mutableAttributedText.beginEditing()
        
        let fullRange = NSRange(location: 0, length: mutableAttributedText.length)
        mutableAttributedText.enumerateAttributes(in: fullRange, options: []) { attributes, range, _ in
            if let font = attributes[.font] as? NSFont {
                let isBold = font.fontDescriptor.symbolicTraits.contains(.bold)
                let newFont = isBold ? NSFont.systemFont(ofSize: font.pointSize) : NSFont.boldSystemFont(ofSize: font.pointSize)
                mutableAttributedText.addAttribute(.font, value: newFont, range: range)
                mutableAttributedText.addAttribute(.foregroundColor, value: NSColor.white, range: range) // Keep text white
            }
        }

        mutableAttributedText.endEditing()
        attributedText = mutableAttributedText
    }
}
