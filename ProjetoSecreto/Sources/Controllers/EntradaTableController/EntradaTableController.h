//
//  EntradaTableController.h
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 16/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntradaTableController : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *somatorioReceitas;
@property (strong, nonatomic) IBOutlet UILabel *somatorioDespesas;

@property(assign, nonatomic) NSInteger *usuario;

-(void) carregarTable;

@end
