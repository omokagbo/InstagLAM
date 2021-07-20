//
//  EditProfileViewModel.swift
//  InstaGLAM
//
//  Created by omokagbo on 17/07/2021.
//

import Foundation

class EditProfileViewModel {
    
    var formModels = [[EditProfileFormModel]]()
    
    var firstSection = [EditProfileFormModel]()
    var secondSection = [EditProfileFormModel]()
    
    let firstSectionLabels = ["Name", "Username", "Website", "Bio"]
    let secondSectionLabels = ["Email", "Phone", "Gender"]
}
