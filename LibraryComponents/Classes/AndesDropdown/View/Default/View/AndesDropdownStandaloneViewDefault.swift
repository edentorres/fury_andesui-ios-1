//
//  LabelViewDefault.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 11/12/20.
//

import Foundation

class AndesDropdownStandaloneView: AndesDropdownAbstractView {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!

    override func loadNib() {
        let bundle = AndesDropdownBundle.bundle()
        bundle.loadNibNamed("AndesDropdownStandaloneView", owner: self, options: nil)
    }

    override func updateView() {

    }

}
