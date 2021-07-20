//
//  EditProfileViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class EditProfileViewController: UIViewController {
    
    private let viewModel: EditProfileViewModel = EditProfileViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureTableView()
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Methods
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = createHeaderView()
    }
    
    private func configureModels() {
        // name, user, website, bio
        viewModel.firstSectionLabels.forEach { label in
            let model = EditProfileFormModel(label: label, placeholder: "\(label)")
            viewModel.firstSection.append(model)
        }
        viewModel.formModels.append(viewModel.firstSection)
        
        // email, phone, gender
        viewModel.secondSectionLabels.forEach { label in
            let model = EditProfileFormModel(label: label, placeholder: "\(label)")
            viewModel.secondSection.append(model)
        }
        viewModel.formModels.append(viewModel.secondSection)
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height / 4).integral)
        let size = headerView.height / 1.5
        let profilePhotoBtn = UIButton(frame: CGRect(x: (view.width - size) / 2,
                                                  y: (headerView.height - size) / 2,
                                                  width: size,
                                                  height: size))
        headerView.addSubview(profilePhotoBtn)
        profilePhotoBtn.layer.masksToBounds = true
        profilePhotoBtn.layer.cornerRadius = size / 2
        profilePhotoBtn.addTarget(self, action: #selector(didTapProfilePhotoBtn), for: .touchUpInside)
        profilePhotoBtn.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoBtn.tintColor = .systemGray4
        profilePhotoBtn.layer.borderWidth = 1
        profilePhotoBtn.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return headerView
    }
    
    @objc func didTapProfilePhotoBtn() {
        
    }
    
    @objc private func didTapSave() {
        // save info to database
        dismiss(animated: true)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change Profile Picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Upload From Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        actionSheet.popoverPresentationController?.sourceView = view
        present(actionSheet, animated: true)
    }
}

extension EditProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.formModels.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.formModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as? FormTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: viewModel.formModels[indexPath.section][indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension EditProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCellUpdate(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel?) {
        print("\(updatedModel?.value ?? "")")
    }
}
