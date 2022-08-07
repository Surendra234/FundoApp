//
//  NoteServiceViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 03/08/22.
//

import UIKit

class NoteService: NoteDetailVC {

    public var noteTitle: String = ""
    public var note: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = noteTitle
        descriptionTextView.text = note
        
    }
}
