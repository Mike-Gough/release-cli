import Foundation

extension String
{
    func storyNumbers() -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: "[A-Z]+-[0-9]+")
        {
            let string = self as NSString

            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
        }

        return []
    }
}