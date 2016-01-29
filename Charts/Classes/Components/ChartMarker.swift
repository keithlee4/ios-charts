//
//  ChartMarker.swift
//  Charts
//
//  Created by Daniel Cohen Gindi on 3/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation
import UIKit

public class ChartMarker: ChartComponentBase
{
    private var _size : CGSize!
    private var _sizes: [CGSize]!
    
    public var images: [UIImage]?{
        willSet(imgs){
            guard imgs != nil else{
                return
            }
            
            _sizes = []
            for img in imgs!{
                _sizes.append(img.size)
            }
        }
    }
    
    /// The marker image to render
    public var image: UIImage?{
        didSet{
            _size = image?.size
        }
    }
    
    /// Use this to return the desired offset you wish the MarkerView to have on the x-axis.
    public var offset: CGPoint = CGPoint()
    
    /// The marker's size
    public var size: CGSize
        {
        get
        {
            return _size
        }
        
        set(newSize)
        {
            _size = newSize
        }
    }
    
    public var sizes: [CGSize]{
        get{
            return _sizes
        }set(newSizes){
            _sizes = newSizes
        }
    }
    
    public override init()
    {
        super.init()
    }
    
    /// Returns the offset for drawing at the specific `point`
    ///
    /// - parameter point: This is the point at which the marker wants to be drawn. You can adjust the offset conditionally based on this argument.
    /// - By default returns the self.offset property. You can return any other value to override that.
    public func offsetForDrawingAtPos(point: CGPoint) -> CGPoint
    {
        return offset;
    }
    
    /// Draws the ChartMarker on the given position on the given context
    public func draw(context context: CGContext, point: CGPoint)
    {
        let offset = self.offsetForDrawingAtPos(point)
        let size = self.size
        
        let rect = CGRect(x: point.x + offset.x - size.width/2, y: point.y + offset.y - size.height/2, width: size.width, height: size.height)
        
        UIGraphicsPushContext(context)
        image!.drawInRect(rect)
        UIGraphicsPopContext()
    }
    
    /// This method enables a custom ChartMarker to update it's content everytime the MarkerView is redrawn according to the data entry it points to.
    ///
    /// - parameter highlight: the highlight object contains information about the highlighted value such as it's dataset-index, the selected range or stack-index (only stacked bar entries).
    public func refreshContent(entry entry: ChartDataEntry, highlight: ChartHighlight)
    {
        // Do nothing here...
        if let images = self.images{
            self.image = images[entry.xIndex]
            self.size = self.sizes[entry.xIndex]
        }
    }
}