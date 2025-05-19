import UIKit

extension UIImage
{
    // convenience function in UIImage extension to resize a given image
    func convert(toWidth: CGFloat) -> UIImage
    {
        let oldWidth = self.size.width
        let scaleFactor = toWidth / oldWidth
        
        let newHeight = self.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: newSize)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: imgRect)
        
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return copied!
    }
}
