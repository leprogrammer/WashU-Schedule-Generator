//
//  CoursesCollectionViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/24/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

protocol CoursesCollectionViewCellDelegate {
    func addCourse(index: Int)
    func removeCourse(index: Int)
}

class CoursesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var addOrRemoveCourseBtn: UIButton!
    @IBOutlet weak var unitsLabel: UILabel!

    static let identifier: String = "CoursesCollectionViewCell"

    static let removeCourseButtonLabel : String = "Remove Course"
    static let addCourseButtonLabel : String = "Add Course"

    var delegate: CoursesCollectionViewCellDelegate?

    private var selectedCourseIndex = 0
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }


    public func configure(course: CourseData, index: Int)
    {
        selectedCourseIndex = index
        courseNameLabel.text = course.courseTag + " : " + course.courseName
        unitsLabel.text = course.units
    }

    /**
    if the course has already been selected then allow user to remove the course.
     */
    public func setAddOrRemoveBtn(courseSelected: Bool)
    {
        if courseSelected
        {
            addOrRemoveCourseBtn.setTitle(CoursesCollectionViewCell.removeCourseButtonLabel, for: .normal)
            addOrRemoveCourseBtn.backgroundColor = UIColor(hue: 359/360, saturation: 87/100, brightness: 64/100, alpha: 1.0) /* #a51417 */
        }
        else
        {
            addOrRemoveCourseBtn.setTitle(CoursesCollectionViewCell.addCourseButtonLabel, for: .normal)
            addOrRemoveCourseBtn.backgroundColor = UIColor(hue: 0.2361, saturation: 0.83, brightness: 0.6, alpha: 1.0) /* #64991a */
        }

    }

    static func nib() -> UINib
    {
        return UINib(nibName: CoursesCollectionViewCell.identifier, bundle: nil)
    }

    @IBAction func addRemoveCourseClicked(_ sender: Any)
    {
        guard let buttonText : String = addOrRemoveCourseBtn.titleLabel?.text else
        {
            fatalError("Could not retrieve addOrRemoveCurseBtn text")
        }

        if (buttonText == CoursesCollectionViewCell.addCourseButtonLabel)
        {
            delegate?.addCourse(index: selectedCourseIndex)
            self.setAddOrRemoveBtn(courseSelected: true)
        }
        else if buttonText == CoursesCollectionViewCell.removeCourseButtonLabel
        {
            delegate?.removeCourse(index: selectedCourseIndex)
            self.setAddOrRemoveBtn(courseSelected: false)
        }
    }
}
