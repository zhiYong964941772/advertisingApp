//
//  history_LAI_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "history_LAI_ViewController.h"

@interface history_LAI_ViewController ()<UITextFieldDelegate>
@property(copy,nonatomic)NSString *test1;
@property(copy,nonatomic)NSString *test2;
@property(copy,nonatomic)NSString *test3;

@end

@implementation history_LAI_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<3; i++) {
        UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(30,100*(i+1),120,30)];
        text.backgroundColor = [UIColor redColor];
        text.delegate = self;
        text.tag = i;
        [self.view addSubview:text];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20,64,100,30);
    [button setTitle:@"111" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(savetest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(CGRectGetMaxX(button.frame)+10,64,100,30);
    [button2 setTitle:@"222" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(savetest2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame = CGRectMake(CGRectGetMaxX(button2.frame)+10,64,100,30);
    [button3 setTitle:@"333" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(savetest3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
        {
            _test1 = textField.text;
        }
            break;
        case 1:
        {
            _test2= textField.text;

        }

            break;
        case 2:
        {
            _test3= textField.text;
    
        }
 
            break;
        default:
            break;
    }
}
- (void)savetest{
    {
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
            context.searchObject();
        }];
    }

}
- (void)savetest2{
    {
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
            context.addObject(_test1,_test2,_test3);
        }];
    }
    
}
- (void)savetest3{
    {
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
            context.deleteObject(_test1);
        }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
