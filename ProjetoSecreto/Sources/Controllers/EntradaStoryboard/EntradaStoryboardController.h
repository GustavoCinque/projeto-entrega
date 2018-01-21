//
//  EntradaStoryboardController.h
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 18/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntradaTableController.h"

@interface EntradaStoryboardController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic, assign) BOOL receita;

@property(nonatomic, assign) NSInteger *idEntrada;
@property(nonatomic, assign) NSInteger *usuario;

@property(nonatomic, strong) EntradaTableController *tableController;

@end
