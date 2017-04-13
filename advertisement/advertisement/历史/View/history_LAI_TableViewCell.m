//
//  history_LAI_TableViewCell.m
//  advertisement
//
//  Created by huazhan Huang on 2017/4/12.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "history_LAI_TableViewCell.h"
#import "history_LAI_model.h"
@interface history_LAI_TableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *historyName;
@property (weak, nonatomic) IBOutlet UILabel *historyTime;
@property (weak, nonatomic) IBOutlet UIImageView *historyImage;

@end
@implementation history_LAI_TableViewCell
static NSString *identifier = @"history_LAI_TableViewCell";
+ (instancetype)getWithTableView:(UITableView *)tableView{
    
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}
- (void)setHistoryModel:(history_LAI_model *)historyModel{
    _historyModel = historyModel;
    self.historyImage.image = [UIImage imageWithData:historyModel.imageData];
    self.historyName.text = historyModel.name;
    self.historyTime.text = historyModel.time;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
