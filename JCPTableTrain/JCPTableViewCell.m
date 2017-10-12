//
//  JCPTableViewCell.m
//  JCPTableTrain
//
//  Created by jon on 2017/10/11.
//  Copyright © 2017年 pixnet. All rights reserved.
//

#import "JCPTableViewCell.h"
#import "SDAutoLayout.h"

@implementation JCPTableViewCell

static NSString *reuseID;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID  = reuseIdentifier;
        self.thumbImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 22, 100, 22)];
        self.detailLabel.numberOfLines = 3;
        [self.detailLabel setFont:[UIFont fontWithName:@"Farah" size:12.0]];
        [self.detailLabel sizeToFit];
        [self.contentView addSubview:self.thumbImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        
        
        self.thumbImageView.sd_layout
        .leftSpaceToView(self.contentView, 5)
        .topSpaceToView(self.contentView, 5)
        .heightIs(90)
        .widthIs(90);
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self.thumbImageView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(30);
        
        self.detailLabel.sd_layout
        .leftSpaceToView(self.thumbImageView, 10)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.titleLabel, 5)
        .heightIs(60);
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
