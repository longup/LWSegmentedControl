# LWSegmentedControl
自定义选项卡实战swift
项目详解请访问：

使用方法如下：
LWSegmentedControl * segment = [LWSegmentedControl build:CGRectMake(0, 44, self.view.bounds.size.width, 44) titleDataSource:btnDataSource backgroundColor:[UIColor colorWithRed:253.0f/255 green:239.0f/255 blue:230.0f/255 alpha:1.0f] titleColor:[UIColor grayColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor orangeColor] normalIndicatorColor:[UIColor grayColor] selectionIndicatorColor:[UIColor redColor] delegate:self];
[self.view addSubview:segment];

自定义选项卡中涉及swift开发的一些基础流程以及混编的注意事项，对于从OC切换到swift的童鞋应该很有帮助。
项目还有待优化，抛砖引玉，快速实现功能，目的是讲解流程。
