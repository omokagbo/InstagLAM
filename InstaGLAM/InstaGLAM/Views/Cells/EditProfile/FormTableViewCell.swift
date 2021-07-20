//
//  FormTableViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 17/07/2021.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCellUpdate(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel?)
}

final class FormTableViewCell: UITableViewCell {
    
    static let identifier = "FormTableViewCell"
    weak var delegate: FormTableViewCellDelegate?
    private var model: EditProfileFormModel?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let formTextField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(formTextField)
        formTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        formTextField.placeholder = model.placeholder
        formTextField.text = model.value
    }
    
    override func prepareForReuse() {
        formLabel.text = nil
        formTextField.placeholder = nil
        formTextField.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 10,
                                 y: 0,
                                 width: contentView.width / 3,
                                 height: contentView.height)
        formTextField.frame = CGRect(x: formLabel.right + 5,
                                     y: 0,
                                     width: contentView.width - 10 - formLabel.width,
                                     height: contentView.height)
    }
    
}

extension FormTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if var model = model {
            model.value = textField.text
            delegate?.formTableViewCellUpdate(self, didUpdateField: model)
        }
        textField.resignFirstResponder()
        return true
    }
}
