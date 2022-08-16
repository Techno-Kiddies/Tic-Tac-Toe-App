//
//  ViewController.m
//  Tic Tac Toe
//
//  Created by Anshuman Mitra on 12/08/22.
//

#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int
    initDiffNum = 100,
    play[3][3],
    roundNum = 1,
    player = 1,
    xScore = 0,
    oScore = 0;

UIButton
    *buttonMap[3][3];

bool
    isDraw = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self setViews];
}

-(void)initialize
{
    player=1;
    for(int r = 0;r < 3;r++)
    {
        for(int c = 0;c < 3;c++)
        {
            play[r][c] = initDiffNum;
            [buttonMap[r][c] setImage:[UIImage imageNamed:@"none.jpg"] forState:UIControlStateNormal];
            initDiffNum = initDiffNum + 100;
        }
    }
    
    [_bgView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_alertView setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 10;
    
    buttonMap[0][0] = _R1B1;
    buttonMap[0][1] = _R1B2;
    buttonMap[0][2] = _R1B3;
    
    buttonMap[1][0] = _R2B1;
    buttonMap[1][1] = _R2B2;
    buttonMap[1][2] = _R2B3;
    
    buttonMap[2][0] = _R3B1;
    buttonMap[2][1] = _R3B2;
    buttonMap[2][2] = _R3B3;
}

-(void)setViews{
    [_GameView setFrame:CGRectMake(0, 0, self.view.frame.size.width-25, (self.view.frame.size.height/2)-25)];
    [_GameView setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    
    float
        buttonWidth = (_GameView.frame.size.width/3),
        buttonHeight = (_GameView.frame.size.height/3);
    
    int
        i = 0,
        j = 0,
        x = 0,
        y = 0;
    
    for(i=0,y=0;i<3;i++, y+=buttonHeight)
        for(j=0,x=0;j<3;j++, x+=buttonWidth){
            [buttonMap[i][j] setFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
        }
        
    UIScrollView
        *vDivider1 = [[UIScrollView alloc] initWithFrame:CGRectMake(buttonWidth, 0, 11, _GameView.frame.size.height)],
        *vDivider2 = [[UIScrollView alloc] initWithFrame:CGRectMake(buttonWidth*2, 0, 11, _GameView.frame.size.height)],
        *hDivider1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, buttonHeight, _GameView.frame.size.width, 11)],
        *hDivider2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, buttonHeight*2, _GameView.frame.size.width, 11)];
    
    vDivider1.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:160.0/255.0 blue:146.0/255.0 alpha:1.0];
    vDivider2.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:160.0/255.0 blue:146.0/255.0 alpha:1.0];
    hDivider1.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:160.0/255.0 blue:146.0/255.0 alpha:1.0];
    hDivider2.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:160.0/255.0 blue:146.0/255.0 alpha:1.0];
    
    [_GameView addSubview:vDivider1];
    [_GameView addSubview:vDivider2];
    [_GameView addSubview:hDivider1];
    [_GameView addSubview:hDivider2];
    
    [_playerOSection setFrame:CGRectMake(0, _GameView.frame.origin.y-(_playerOScoreLabel.frame.size.height*4), self.view.frame.size.width/2, _playerOScoreLabel.frame.size.height*4)];
    [_playerXSection setFrame:CGRectMake(self.view.frame.size.width/2, _GameView.frame.origin.y-(_playerOScoreLabel.frame.size.height*4), self.view.frame.size.width/2, _playerOScoreLabel.frame.size.height*4)];
}

-(void)setTable
{
    for(int r = 0;r < 3;r++)
    {
        for(int c = 0;c < 3;c++)
        {
            if(play[r][c] == 0)
                [buttonMap[r][c] setImage:[UIImage imageNamed:@"O.jpg"] forState:UIControlStateNormal];
            else if(play[r][c] == 1)
                [buttonMap[r][c] setImage:[UIImage imageNamed:@"X.jpg"] forState:UIControlStateNormal];
            else
                [buttonMap[r][c] setTitle:@" " forState:UIControlStateNormal];
        }
    }
    
    [self changePlayer];
    int
        win = [self checkWinner];
    
    if(win == 1){
        NSLog(@"Player %d Wins!", player+1);
        roundNum++;
        if(player == 0){
            _WinnerImg.image = [UIImage imageNamed:@"XWin.jpg"];
            xScore++;
        }
        else{
            _WinnerImg.image = [UIImage imageNamed:@"OWin.jpg"];
            oScore++;
        }
        
        [self presentWinnerAlert];
        [self setRoundNum];
        [self initialize];
    }
    
    for(int r = 0;r < 3;r++)
    {
        for(int c = 0;c < 3;c++)
        {
            if(play[r][c] == 0 || play[r][c] == 1)
                isDraw = true;
            else if(play[r][c] != 0 || play[r][c] != 1){
                isDraw = false;
                break;
            }
        }
        if(isDraw == false)
            break;
    }

    if(isDraw ){
        roundNum++;
        _WinnerImg.image = [UIImage imageNamed:@"Draw.jpg"];
        [self presentWinnerAlert];
        [self setRoundNum];
        [self initialize];
    }
    
    _playerXScoreLabel.text = [NSString stringWithFormat:@"%d", xScore];
    _playerOScoreLabel.text = [NSString stringWithFormat:@"%d", oScore];
}

- (IBAction)closeAlert:(id)sender {
    
    [_bgView removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        [_alertView setFrame:CGRectMake(_alertView.frame.origin.x, self.view.frame.size.height, _alertView.frame.size.width, _alertView.frame.size.height)];
    } completion:^(BOOL finished){
        [_alertView  removeFromSuperview];
    }];
}

-(void)setRoundNum
{
    _Round1.text = [NSString stringWithFormat:@"Round %d", roundNum];
}

-(void)presentWinnerAlert
{
    [self.view addSubview:_bgView];
    
    [_alertView setFrame:CGRectMake(_alertView.frame.origin.x, self.view.frame.size.height, _alertView.frame.size.width, _alertView.frame.size.height)];
    
    [UIView animateWithDuration:0.5 animations:^{
        [_alertView setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    } completion:^(BOOL finished){
        
    }];
    
    [self.view addSubview:_alertView];
}

-(int)checkWinner
{
    int
            i = 0,
            j = 0;

    //Diagonal:
    if(play[i][j] == play[i+1][j+1] && play[i+1][j+1] == play[i+2][j+2]){
        [self changeWinnerColor:i r2:i+1 r3:i+2 c1:j c2:j+1 c3:j+2];
        return 1;
    }
    else if(play[i][j+2] == play[i+1][j+1] && play[i+1][j+1] == play[i+2][j]){
        [self changeWinnerColor:i r2:i+1 r3:i+2 c1:j+2 c2:j+1 c3:j];
        return 1;
    }
    
    else if(play[i][j] == play[i][j+1] && play[i][j+1] == play[i][j+2]){
        [self changeWinnerColor:i r2:i r3:i c1:j c2:j+1 c3:j+2];
        return 1;
    }
    else if(play[i+1][j] == play[i+1][j+1] && play[i+1][j+1] == play[i+1][j+2]){
        [self changeWinnerColor:i+1 r2:i+1 r3:i+1 c1:j c2:j+1 c3:j+2];
        return 1;
    }
    else if(play[i+2][j] == play[i+2][j+1] && play[i+2][j+1] == play[i+2][j+2]){
        [self changeWinnerColor:i+2 r2:i+2 r3:i+2 c1:j c2:j+1 c3:j+2];
        return 1;
    }
        
    else if(play[i][j] == play[i+1][j] && play[i+1][j] == play[i+2][j]){
        [self changeWinnerColor:i r2:i+1 r3:i+2 c1:j c2:j c3:j];
        return 1;
    }
    else if(play[i][j+1] == play[i+1][j+1] && play[i+1][j+1] == play[i+2][j+1]){
        [self changeWinnerColor:i r2:i+1 r3:i+2 c1:j+1 c2:j+1 c3:j+1];
        return 1;
    }
    else if(play[i][j+2] == play[i+1][j+2] && play[i+1][j+2] == play[i+2][j+2]){
        [self changeWinnerColor:i r2:i+1 r3:i+2 c1:j+2 c2:j+2 c3:j+2];
        return 1;
    }
        
    else
        return 0;
}

-(void)changePlayer
{
    if(player == 0){
        player = 1;
        _turnLabel.text = @"X's Trun";
    }
    else if(player == 1){
        player = 0;
        _turnLabel.text = @"O's Trun";
    }
}

-(void)changeWinnerColor:(int)r1 r2:(int)r2 r3:(int)r3 c1:(int)c1 c2:(int)c2 c3:(int)c3
{
    [buttonMap[r1][c1] setTitleColor:UIColor.brownColor forState:UIControlStateNormal];
    [buttonMap[r2][c2] setTitleColor:UIColor.brownColor forState:UIControlStateNormal];
    [buttonMap[r3][c3] setTitleColor:UIColor.brownColor forState:UIControlStateNormal];
}

-(void)setPlayerChoice:(int)r c:(int)c
{
    if(play[r][c] == 1 || play[r][c] == 0)
    {
        _WinnerImg.image = [UIImage imageNamed:@"Filled.jpg"];
        [self presentWinnerAlert];
    }
    else
    {
        if(player == 0)
            play[r][c] = 0;
        else
            play[r][c] = 1;
        [self setTable];
    }
}


//Buttons Pressed:
//Row 1:
- (IBAction)R1B1Pressed:(id)sender {
    [self setPlayerChoice:0 c:0];
}
- (IBAction)R1B2Pressed:(id)sender {
    [self setPlayerChoice:0 c:1];
}
- (IBAction)R1B3Pressed:(id)sender {
    [self setPlayerChoice:0 c:2];
}

//Row 2:
- (IBAction)R2B1Pressed:(id)sender {
    [self setPlayerChoice:1 c:0];
}
- (IBAction)R2B2Pressed:(id)sender {
    [self setPlayerChoice:1 c:1];
}
- (IBAction)R2B3Pressed:(id)sender {
    [self setPlayerChoice:1 c:2];
}

//Row 3:
- (IBAction)R3B1Pressed:(id)sender {
    [self setPlayerChoice:2 c:0];
}
- (IBAction)R3B2Pressed:(id)sender {
    [self setPlayerChoice:2 c:1];
}
- (IBAction)R3B3Pressed:(id)sender {
    [self setPlayerChoice:2 c:2];
}

@end
