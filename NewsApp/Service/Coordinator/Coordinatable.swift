//
//  Coordinatable.swift
//  NewsApp
//
//  Created by Illya Sirosh on 07.02.2021.
//

import Foundation
import UIKit

protocol Coordinatable where Self: UIViewController {
    var coordinator: Coordinator? {get set}
}
