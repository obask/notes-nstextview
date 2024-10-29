import SwiftUI
import AppKit

struct RichTextView: NSViewRepresentable {
    @Binding var text: NSAttributedString
    var isEditable: Bool = true

    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.isRichText = true
        textView.isEditable = isEditable
        textView.isSelectable = true
        textView.backgroundColor = .black // Dark background for better contrast
        textView.textContainerInset = NSSize(width: 10, height: 10) // Add padding
        textView.delegate = context.coordinator
        textView.textStorage?.setAttributedString(text)
        return textView
    }

    func updateNSView(_ textView: NSTextView, context: Context) {
        if textView.attributedString() != text {
            textView.textStorage?.setAttributedString(text)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: RichTextView

        init(_ parent: RichTextView) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            if let textView = notification.object as? NSTextView {
                parent.text = textView.attributedString()
            }
        }
    }
}
