//
//  OnboardingModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 16/06/22.
//

import Foundation
import UIKit

enum OnboardingData {
    case first, second, third
    
    var data: (image: UIImage, title: String, subtitle: String) {
        switch self {
        case .first:
            return (
                UIImage(named: "onboarding1.png")!,
                "Pembukuan Kas Bisnis Tanpa Ribet",
                "Tambah pemasukan dan pengeluaran bisnis kapanpun dan darimanapun"
            )
        case .second:
            return (
                UIImage(named: "onboarding2.png")!,
                "Persediaan Menu Lebih Rapi dan Teratur",
                "Catat semua menu penjualan agar lebih rapi dan teratur"
            )
        case .third:
            return (
                UIImage(named: "onboarding3.png")!,
                "Prediksi Penjualan Bisnis Kamu Kedepan",
                "Kapan bisnis kamu naik dan turun untuk persiapan kedepan lebh matang"
            )
        }
    }
}
