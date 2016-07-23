//
//  ViewController.m
//  盗版QQ-聊天
//
//  Created by czbk on 16/5/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "ViewController.h"
#import "CZMessageModel.h"
#import "CZQQWithFrame.h"
#import "CZQQCell.h"

static NSString *cellID = @"cellID";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *mesgFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //注册cell
    [self.tableView registerClass:[CZQQCell class] forCellReuseIdentifier:cellID];
    //self.tableView.rowHeight=0;
    
    
    
    //获取最后一行的indexPath
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.mesgFrame.count-1 inSection:0];
    //出现键盘的时候,屏幕整体往上移动
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //设置文本框的监听,通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendTextQQ:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

//通知方法
-(void)sendTextQQ:(NSNotification*)nsnotification{
//    NSLog(@"xx");
    
    
    //获取键盘frame变化以后的frame
    CGRect endFrame = [nsnotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //计算屏幕需要移动的距离
    CGFloat transformY = self.view.frame.size.height - endFrame.origin.y;
    
    self.view.transform = CGAffineTransformMakeTranslation(0, -transformY);
}

//文本框的代理方法,文本框店家return的时候,执行
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //创建frame
    CZQQWithFrame *messFrame = [[CZQQWithFrame alloc]init];
    //创建model,接受文本框里面的内容
    CZMessageModel *model = [[CZMessageModel alloc]init];
    
    //
    model.text = textField.text;    //内容
    model.type = 0;                 //是否会员
    
    //时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formateer = [[NSDateFormatter alloc]init];
    formateer.dateFormat = @"hh:mm";
    
    NSString *time = [formateer stringFromDate:date];
    
    //判断时间是否一样
    CZQQWithFrame *lastFrame = self.mesgFrame.lastObject;
    if([lastFrame.model.time isEqualToString:time]){
        model.hidenTime = YES;
    }
    model.time = time;
    //把model 赋值给frame的model
    messFrame.model = model;
    
    //把刚刚创建的frame添加到数据源中
    [self.mesgFrame addObject:messFrame];
    
    //更新tableView
    //获取
    NSIndexPath *lastIndepath = [NSIndexPath indexPathForRow:self.mesgFrame.count-1 inSection:0];
    //
    [self.tableView insertRowsAtIndexPaths:@[lastIndepath] withRowAnimation:UITableViewRowAnimationTop];
    
    
    //把tableView向上滚动
    [self.tableView scrollToRowAtIndexPath:lastIndepath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //清空文本框
    textField.text = nil;
    
    return YES;
}
//tableView拖拽的时候,键盘收回
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZQQWithFrame *qqFrame = self.mesgFrame[indexPath.row];
    return qqFrame.rowHeight;
}

//- tableView:heightForRowAtIndexPath:


#pragma mark -tableView数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mesgFrame.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZQQCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    CZQQWithFrame * qqFrame = self.mesgFrame[indexPath.row];
    
    cell.qqFrame = qqFrame;
    
    return cell;
}


#pragma mark -懒加载
-(NSArray *)mesgFrame{
    if(nil == _mesgFrame){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            //创建model
            CZMessageModel *model = [CZMessageModel MessModel:dict];
            //创建frame
            CZQQWithFrame *qqFrame = [[CZQQWithFrame alloc]init];
            
            //取出数组中的最后一项
            CZQQWithFrame *lastArray = arrayM.lastObject;
            //判断最后一项的时间是否跟,model中的数据一致,一致的话,就标记hideneTime为YES
            if([lastArray.model.time isEqualToString:model.time]){
                model.hidenTime = YES;
            }
            
            //frame模型添加model
            qqFrame.model = model;
            
            //数组添加frame
            [arrayM addObject:qqFrame];
        }
        _mesgFrame = arrayM;
    }
    return _mesgFrame;
}

@end
