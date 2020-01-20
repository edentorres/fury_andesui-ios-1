//
//  AndesButtonAbstractView.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 26/12/2019.
//

import Foundation

/**
 AndesButtonAbstractView is an abstract class that includes the functionality for the button to be drawn by a AndesButtonSizeProtocol and a AndesButtonStyleProtocol
 */
internal class AndesButtonAbstractView: UIControl, AndesButtonView {

    internal var size: AndesButtonSizeProtocol
    internal var style: AndesButtonStyleProtocol
    internal var backgroundLayer: CALayer

    @IBOutlet var buttonView: UIView!
    @IBOutlet var label: UILabel!

    override public var frame: CGRect {
        didSet {
               buttonView?.frame = frame
           }
    }

    internal init(size: AndesButtonSizeProtocol, style: AndesButtonStyleProtocol) {
        self.size = size
        self.style = style
        self.backgroundLayer = CALayer()
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        self.size = AndesButtonSizeLarge()
        self.style = AndesButtonStyleLoud()
        self.backgroundLayer = CALayer()
        super.init(coder: coder)

        setup()
    }

    private func setup() {
        loadNib()

        backgroundLayer = buttonView.layer
        addSubview(buttonView)

        setupSize()
        setupStyle()
    }

    internal func loadNib() {
        fatalError("This should be override by a subclass")
    }

    internal func setupStyle() {
        backgroundLayer.backgroundColor = style.idleColor.cgColor
        label.textColor = style.fontColor
    }

    internal func setupSize() {
        backgroundLayer.cornerRadius = size.borderRadius
        label.font = size.font
    }

    func enable() {
        setupStyle()
    }

    func disable() {
        backgroundLayer.backgroundColor = style.disableColor.cgColor
        label.textColor = AndesStyleSheetManager.styleSheet.textDisableColor
    }

    func touchUp() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundLayer.backgroundColor = self.style.idleColor.cgColor
        }, completion: nil)
    }

    func touchDown() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundLayer.backgroundColor = self.style.pressedColor.cgColor
        }, completion: nil)
    }

    func setText(_ text: String) {
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedString.addAttribute(.paragraphStyle, value: AndesButtonHelper.provideParagraphStyle(), range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
    }
}

internal class AndesButtonHelper {

    public static func provideParagraphStyle() -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail

        return paragraphStyle
    }
}
