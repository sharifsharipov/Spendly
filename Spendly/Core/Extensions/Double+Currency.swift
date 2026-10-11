import Foundation

extension Double {
    func toCurrency(symbol: String = "$") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "\(symbol)\(String(format: "%.2f", self))"
    }
}
