//
//  ViewController.h
//  Tic Tac Toe
//
//  Created by Anshuman Mitra on 12/08/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *R1B1;
@property (weak, nonatomic) IBOutlet UIButton *R1B2;
@property (weak, nonatomic) IBOutlet UIButton *R1B3;
@property (weak, nonatomic) IBOutlet UIButton *R2B1;
@property (weak, nonatomic) IBOutlet UIButton *R2B2;
@property (weak, nonatomic) IBOutlet UIButton *R2B3;
@property (weak, nonatomic) IBOutlet UIButton *R3B1;
@property (weak, nonatomic) IBOutlet UIButton *R3B2;
@property (weak, nonatomic) IBOutlet UIButton *R3B3;

@property (weak, nonatomic) IBOutlet UILabel *Round1;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *alertView;

@property (weak, nonatomic) IBOutlet UIImageView *WinnerImg;
@property (weak, nonatomic) IBOutlet UILabel *playerXScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOScoreLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *playerOSection;
@property (weak, nonatomic) IBOutlet UIScrollView *playerXSection;

@property (weak, nonatomic) IBOutlet UIScrollView *GameView;
@property (weak, nonatomic) IBOutlet UIScrollView *verticalDivider;
@property (weak, nonatomic) IBOutlet UIScrollView *verticalDivider2;
@property (weak, nonatomic) IBOutlet UIScrollView *horizontalDivider;
@property (weak, nonatomic) IBOutlet UIScrollView *horizontalDivider2;

@end

