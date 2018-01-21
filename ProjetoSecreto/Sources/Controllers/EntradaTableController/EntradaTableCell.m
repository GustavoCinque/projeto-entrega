//
//  EntradaTableCell.m
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 18/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import "EntradaTableCell.h"

@interface EntradaTableCell()

@property(nonatomic, strong) Entrada *entrada;
@property (strong, nonatomic) IBOutlet UIImageView *imagemTipo;
@property (strong, nonatomic) IBOutlet UILabel *valor;
@property (strong, nonatomic) IBOutlet UILabel *data;
@property (strong, nonatomic) IBOutlet UILabel *categoria;

@end

@implementation EntradaTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)inserirElementos:(Entrada *)entrada {
    self.entrada = entrada;
    if([self.entrada.categoria.tipoEntrada isEqual:@"RECEITA"]) {
        self.imagemTipo.image = [UIImage imageNamed:@"increase"];
    } else{
        self.imagemTipo.image = [UIImage imageNamed:@"decrease"];
    }
    
    NSDateFormatter* formatoData = [NSDateFormatter new];
    formatoData.dateFormat = @"dd/MM/yy";
    
    NSNumberFormatter *formatoValor = [NSNumberFormatter new];
    formatoValor.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.data.text = [formatoData stringFromDate:self.entrada.data];
    self.valor.text = [formatoValor stringFromNumber:self.entrada.valor];
    self.categoria.text = self.entrada.categoria.descricao;
}

@end
