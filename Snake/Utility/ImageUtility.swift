//
//  ImageUtility.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

class ImageUtility {
    
    static func createBackgroundImage() -> UIImage {
        
        let width: CGFloat = Constant.cellSize * CGFloat(Constant.boardColumn) + (Constant.borderStrokeWidth * 2)
        let height: CGFloat = Constant.cellSize * CGFloat(Constant.boardRow) + (Constant.borderStrokeWidth * 2)
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(GameColor.gameBoardColor.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        
        let halfStroke = Constant.borderStrokeWidth/2
        context.setStrokeColor(GameColor.borderStrokeColor.cgColor)
        context.stroke(CGRect(x: halfStroke, y: halfStroke, width: width - Constant.borderStrokeWidth, height: height - Constant.borderStrokeWidth), width: Constant.borderStrokeWidth)
        
        let path = UIBezierPath()
        
        let lineStartY = Constant.borderStrokeWidth
        let lineEndY = height - Constant.borderStrokeWidth
        var lineX = Constant.borderStrokeWidth + Constant.cellSize
        for _ in 1..<Constant.boardColumn {
            path.move(to: CGPoint(x: lineX, y: lineStartY))
            path.addLine(to: CGPoint(x: lineX, y: lineEndY))
            lineX += Constant.cellSize
        }
        
        let lineStartX = Constant.borderStrokeWidth
        let lineEndX = width - Constant.borderStrokeWidth
        var lineY = Constant.borderStrokeWidth + Constant.cellSize
        for _ in 1..<Constant.boardRow {
            path.move(to: CGPoint(x: lineStartX, y: lineY))
            path.addLine(to: CGPoint(x: lineEndX, y: lineY))
            lineY += Constant.cellSize
        }
        
        let  dashes: [CGFloat] = [1, 2]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineCapStyle = .butt
        GameColor.cellStrokeColor.set()
        path.stroke()
        
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return myImage
    }
}
