//
//  JPIMSelectFriendsCtl.m
//  JPush IM
//
//  Created by Apple on 15/2/6.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "JPIMSelectFriendsCtl.h"
#import "JPIMCommon.h"
#import "JPIMSelectFriendCell.h"
#import "JPIMSendMessageViewController.h"
@interface JPIMSelectFriendsCtl ()
{
    UITextField *_groupTextField;
}
@end

@implementation JPIMSelectFriendsCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    JPIMLog(@"Action");
    [self sectionIndexTitles];
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 60)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    UILabel *groupNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 60, 50)];
    groupNameLabel.text = @"群名称:";
    groupNameLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:groupNameLabel];
    _groupTextField =[[UITextField alloc] initWithFrame:CGRectMake(60, 5, 150, 50)];
    [headView addSubview:_groupTextField];
    _groupTextField.placeholder = @"请输入群名称";
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 59, kApplicationWidth, 1)];
    [line setBackgroundColor:[UIColor grayColor]];
    [headView addSubview:line];
    
    self.selectFriendTab =[[ChatTable alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.selectFriendTab setBackgroundColor:[UIColor clearColor]];
    self.selectFriendTab.dataSource=self;
    self.selectFriendTab.delegate=self;
    self.selectFriendTab.touchDelegate = self;
    self.selectFriendTab.tableHeaderView=headView;
    self.selectFriendTab.delegate = self;
    [self.view addSubview:self.selectFriendTab];
    self.navigationController.navigationBar.barTintColor =UIColorFromRGB(0x3f80dd);
    self.navigationController.navigationBar.alpha=0.8;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], UITextAttributeTextColor,
                                                                     [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                     [UIFont boldSystemFontOfSize:18], UITextAttributeFont,
                                                                     nil]];
    UIButton *leftbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 30, 30)];
    [leftbtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setImage:[UIImage imageNamed:@"login_15"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];//为导航栏添加右侧按钮
    UIButton *rightbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setFrame:CGRectMake(0, 0, 50, 50)];
    [rightbtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];//为导航栏添加右侧按钮
}

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event
{
    [_groupTextField resignFirstResponder];
}

- (void)rightBtnClick {
    [_groupTextField resignFirstResponder];
    JPIMSendMessageViewController *sendMessageCtl =[[JPIMSendMessageViewController alloc] init];
    sendMessageCtl.hidesBottomBarWhenPushed=YES;
    sendMessageCtl.conversationType = kGroup;
    [self.navigationController pushViewController:sendMessageCtl animated:YES];
}

- (void)backClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)sectionIndexTitles {
    self.arrayOfCharacters =[[NSMutableArray alloc] init];
    for(char c = 'A';c<='Z';c++)
    [self.arrayOfCharacters addObject:[NSString stringWithFormat:@"%c",c]];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.arrayOfCharacters;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger count = 0;
    for(NSString *character in self.arrayOfCharacters)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.arrayOfCharacters count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier =@"selectFriendIdentify";
    JPIMSelectFriendCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JPIMSelectFriendCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
