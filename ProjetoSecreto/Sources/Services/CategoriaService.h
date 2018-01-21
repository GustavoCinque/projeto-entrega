//
//  CategoriaService.h
//  ProjetoSecreto
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Categoria.h"

@interface CategoriaService : NSObject

- (void) carregarPrimeiraCargaCategorias:(void (^)(NSArray<Categoria *> *, NSError *)) metodoParaRetorno;
- (void) carregarSegundaCargaCategorias:(void (^)(NSArray<Categoria *> *, NSError *)) metodoParaRetorno;

@end
