//
//  EntradaTableController.h
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 16/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntradaVisualizacaoTableController : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *somatorioReceitas;
@property (strong, nonatomic) IBOutlet UILabel *somatorioDespesas;

@property(assign, nonatomic) NSInteger *usuario;

@property(assign, nonatomic) BOOL visualizacao;
@property(strong, nonatomic) NSString *visualizar;

@end
