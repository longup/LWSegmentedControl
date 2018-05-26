//
//  LWSegmentedControl.swift
//
//  Created by 充电实践 on 2018/5/21.
//

import Foundation
import UIKit

//按钮点击事件代理
@objc(LWSegmentedDelegate)
protocol LWSegmentedDelegate: NSObjectProtocol {
    func segmentSelected(_ selection:Int)
}

class LWSegmentedControl: UIView {
    var segmentDelegate: LWSegmentedDelegate?
    //定义segment的button数组
    var btnTitleSource: Array<UIButton>?
    //定义未选中的字体颜色
    var titleColor: UIColor?
    //定义选中的字体颜色
    var selectedColor: UIColor?
    //定义选中的字体
    var titleFont: UIFont?
    //定义选中的指示器颜色
    fileprivate var selectionIndicatorColor: UIColor?
    //定义未选中的指示器颜色
    fileprivate var normalIndicatorColor: UIColor?
    //定义选中的index
    fileprivate var selectedSegment: Int?
    //定义按钮的宽度
    fileprivate var witdthFloat: CGFloat?
    //定义指示器
    fileprivate var indicatorSource: Array<UIView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.btnTitleSource = []
        self.indicatorSource = []
        selectedSegment = 0;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //类函数
    public class func build(_ frame: CGRect, titleDataSource: Array<String>, backgroundColor: UIColor, titleColor: UIColor, titleFont: UIFont, selectColor: UIColor, normalIndicatorColor: UIColor, selectionIndicatorColor: UIColor, delegate:Any) ->LWSegmentedControl {
        let customSegment: LWSegmentedControl = LWSegmentedControl.init(frame: frame)
        
        customSegment.backgroundColor = backgroundColor
        customSegment.normalIndicatorColor = normalIndicatorColor
        customSegment.selectionIndicatorColor = selectionIndicatorColor
        
        customSegment.titleColor = titleColor
        customSegment.titleFont = titleFont

        customSegment.selectedColor = selectColor
        customSegment.segmentDelegate = delegate as? LWSegmentedDelegate
        customSegment.addSegmentArray(segmentArray: titleDataSource)
        
        return customSegment
    }

    //添加button数组和指示器数组
    func addSegmentArray(segmentArray: Array<String>) {
        // 1.按钮的个数
        let segmentNumber = segmentArray.count
        // 2.按钮的宽度
        witdthFloat = (self.bounds.size.width) / CGFloat(segmentNumber);
        // 3.创建按钮
        for i in 0...(segmentNumber - 1) {
            let btn: UIButton = UIButton.init(frame: CGRect(x: CGFloat(i) * witdthFloat!, y: 0, width: witdthFloat!, height: self.bounds.size.height - 2))
            btn.setTitle(segmentArray[i], for: UIControlState.normal)
            btn.titleLabel?.font = self.titleFont
            btn.setTitleColor(self.titleColor, for: UIControlState.normal)
            btn.setTitleColor(self.selectedColor, for: UIControlState.selected)
            btn.tag = i + 1;
            btn.addTarget(self, action: #selector(changeSegumentAction(btn:)), for: UIControlEvents.touchUpInside)
            
            let indicatorView = UIView(frame: CGRect(x: CGFloat(i) * witdthFloat!, y: self.bounds.size.height - 2, width: witdthFloat!, height: 2))
            if 0 == i {
                indicatorView.backgroundColor = self.selectionIndicatorColor
            }
            else
            {
                indicatorView.backgroundColor = self.normalIndicatorColor
            }
            self.addSubview(indicatorView)
            self.indicatorSource?.append(indicatorView)
            
            self.addSubview(btn)
            self.btnTitleSource?.append(btn)
            self.btnTitleSource?.first?.isSelected = true
        }
    }
    
    //点击事件
    func changeSegumentAction(btn: UIButton) {
        self.selectSegment(segment: btn.tag - 1)
    }
    
    //点击事件，改变样式
    func selectSegment(segment: Int) {
        if selectedSegment != segment {
            let selectedBtn: UIButton = self.btnTitleSource![selectedSegment!]
            selectedBtn.isSelected = false
            let segmentBtn: UIButton = self.btnTitleSource![segment]
            segmentBtn.isSelected = true
        }
        
        for i in 0...((self.indicatorSource?.count)! - 1) {
            if i == segment {
                self.indicatorSource![i].backgroundColor = self.selectionIndicatorColor
            }
            else {
                self.indicatorSource![i].backgroundColor = self.normalIndicatorColor
            }
        }
        
        selectedSegment = segment
        self.segmentDelegate?.segmentSelected(selectedSegment!)
    }
}

