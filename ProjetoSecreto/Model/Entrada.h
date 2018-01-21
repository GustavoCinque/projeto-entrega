//
//  Entrada.h
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 16/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Categoria.h"

@interface Entrada : NSObject

@property(nonatomic, strong) Categoria *categoria;
@property(nonatomic, strong) NSDate *data;
@property(nonatomic, strong) NSString *descricao;
@property(nonatomic, strong) NSNumber *idEntrada;
@property(nonatomic, strong) NSNumber *latitude;
@property(nonatomic, strong) NSNumber *longitude;
@property(nonatomic, strong) NSNumber *usuario;
@property(nonatomic, strong) NSNumber *valor;

@end
