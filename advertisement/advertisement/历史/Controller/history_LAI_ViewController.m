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
    [self creatRightButton];
}
- (void)creatRightButton{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:@selector(deleteHistory)];
    self.navigationItem.rightBarButtonItem = right;
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
- (void)deleteHistory{
    {
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
            context.deleteObject(@"");
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
