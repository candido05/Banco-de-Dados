import mysql.connector
from MetodosAuxiliares import MetodosAuxiliares

# Conecteca ao banco de dados MySQL usando mysql.connector
db = mysql.connector.connect(user='root', password='clqb050302',
                              host='localhost', database='banco_de_dados')

class Livro:
    def __init__(self, livro_id, livro_nome, escritor, ano_edição, editora, genero, valor, estoque_atual, lote):
        self.livro_id = livro_id
        self.livro_nome = livro_nome
        self.escritor = escritor
        self.ano_edição = ano_edição
        self.editora = editora
        self.genero = genero
        self.valor = valor
        self.estoque_atual = estoque_atual
        self.lote = lote

class livraria:
    
    def __init__(self):
        pass

    def inserir_livro(self):
        while True:
            try:
                livro_id = int(input("Insira o ID do livro: "))
                livro_nome = input("Insira o nome do livro: ")
                escritor = input("Insira o nome do escritor: ")
                ano_edição = int(input("Insira o ano de edição: "))
                editora = input("Insira o nome da editora: ")
                genero = input("Insira o gênero do livro: ")
                valor = float(input("Insira o valor do livro: "))
                estoque_atual = int(input("Insira o estoque atual: "))
                lote = int(input("Insira o número do lote: "))

                livro = Livro(livro_id, livro_nome, escritor, ano_edição, editora, genero, valor, estoque_atual, lote)

                # Execute a inserção na tabela
                query = 'INSERT INTO livraria (livro_id, livro_nome, escritor, ano_edição, editora, genero, valor, estoque_atual, lote) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);'
                valores = (livro.livro_id, livro.livro_nome, livro.escritor, livro.ano_edição, livro.editora, livro.genero, livro.valor, livro.estoque_atual, livro.lote)
                
                mycursor = db.cursor()
                mycursor.execute(query, valores)
                db.commit()
                print("Registro inserido com sucesso!")

                continuar = input("Deseja inserir outro livro? (S/N): ").strip().lower()
                if continuar != 's':
                    break

            except mysql.connector.Error as err:
                db.rollback()
                print(f"Erro ao inserir o registro: {err}")

            except ValueError:
                print("Entrada inválida. Certifique-se de fornecer valores numéricos para campos numéricos.")

        mycursor.close()
    
    def alterar(self):
        while True:
            livro_id = int(input("Insira o ID do livro que deseja alterar: "))
            
            # Verifique se o livro com o ID fornecido existe na tabela
            if not MetodosAuxiliares().existe_livro(livro_id):
                print(f"O livro com o ID {livro_id} não foi encontrado.")
                continuar = input("Deseja tentar outro ID? (S/N): ").strip().lower()
                if continuar != 's':
                    break
                else:
                    continue
            
            # Menu de seleção da coluna a ser alterada
            print("Selecione a coluna para a alteração:")
            print("1. livro_nome")
            print("2. escritor")
            print("3. ano_edição")
            print("4. editora")
            print("5. genero")
            print("6. valor")
            print("7. estoque_atual")
            print("8. lote")
            
            coluna = input("Opção (1-8): ")
            
            if coluna == '1':
                coluna_nome = "livro_nome"
                novo_valor = input(f"Insira o novo valor para {coluna_nome}: ")
            elif coluna == '2':
                coluna_nome = "escritor"
                novo_valor = input(f"Insira o novo valor para {coluna_nome}: ")
            elif coluna == '3':
                coluna_nome = "ano_edição"
                novo_valor = int(input(f"Insira o novo valor para {coluna_nome}: "))
            elif coluna == '4':
                coluna_nome = "editora"
                novo_valor = input(f"Insira o novo valor para {coluna_nome}: ")
            elif coluna == '5':
                coluna_nome = "genero"
                novo_valor = input(f"Insira o novo valor para {coluna_nome}: ")
            elif coluna == '6':
                coluna_nome = "valor"
                novo_valor = float(input(f"Insira o novo valor para {coluna_nome}: "))
            elif coluna == '7':
                coluna_nome = "estoque_atual"
                novo_valor = int(input(f"Insira o novo valor para {coluna_nome}: "))
            elif coluna == '8':
                coluna_nome = "lote"
                novo_valor = int(input(f"Insira o novo valor para {coluna_nome}: "))
            else:
                print("Opção inválida.")
                continue
            
            # Execute a atualização na tabela
            query = f'UPDATE livraria SET {coluna_nome} = %s WHERE livro_id = %s;'
            
            mycursor = db.cursor()
            
            try:
                mycursor.execute(query, (novo_valor, livro_id))
                db.commit()
                print(f"{coluna_nome} alterado com sucesso!")

            except mysql.connector.Error as err:
                db.rollback()
                print(f"Erro ao alterar {coluna_nome}: {err}")

            finally:
                mycursor.close()

            continuar = input("Deseja fazer outra alteração? (S/N): ").strip().lower()
            if continuar != 's':
                break

    def pesquisar_por_nome(self):
        while True:
          print("Opções de pesquisa:")
          print("1. Pesquisar por nome do livro")
          print("2. Pesquisar por escritor")
          print("3. Pesquisar por gênero")
          print("4. Pesquisar por editora")
          print("5. Pesquisar por ano de edição")
          print("6. Pesquisar por valor entre X e Y")
          print("7. Pesquisar por estoque atual")
          print("8. Pesquisar por lote")
          print("9. Sair")
          
          opcao = input("Escolha uma opção (1-9):")

          if opcao == '1':
            coluna = "livro_nome"
            termo = input("Insira o nome do livro para pesquisa: ")
            MetodosAuxiliares().executa_pesquisa(coluna, termo)
          elif opcao == '2':
            coluna = "escritor"
            termo = input("Insira o nome do escritor para pesquisa: ")
            MetodosAuxiliares().executa_pesquisa(coluna, termo)
          elif opcao == '3':
            coluna = "genero"
            termo = input("Insira o nome do genero do livro para pesquisa: ")
            MetodosAuxiliares().executa_pesquisa(coluna, termo)
          elif opcao == '4':
            coluna = "editora"
            termo = input("Insira o nome da editora para pesquisa: ")
            MetodosAuxiliares().executa_pesquisa(coluna, termo)
          elif opcao == '5':
            coluna = "ano_edição"
            termo = input("Insira o ano da edição do livro para pesquisa: ")
            MetodosAuxiliares().executa_pesquisa(coluna, termo)
          elif opcao == '6':
            coluna = "valor"
            valor_min = float(input("Insira o valor mínimo: "))
            valor_max = float(input("Insira o valor máximo: "))
            MetodosAuxiliares().executar_pesquisa_valor(coluna, valor_min, valor_max)
          elif opcao == '7':
            coluna = "estoque_atual"
            termo = int(input("Inisira o número de estoque para pesquisa: "))
            MetodosAuxiliares().executa_pesquisa(coluna, termo)
          elif opcao == '8':
            coluna = "lote"
            termo = int(input("Inisira o valor de lote para pesquisa: "))
            MetodosAuxiliares().executa_pesquisa(coluna, termo)
          elif opcao == '9':
            break
          else:
            print("Opção inválida. Tente novamente")
            
    def exibir_todos(self):
        query = 'SELECT * FROM livraria;'
        mycursor = db.cursor()
        mycursor.execute(query)
        resultados = mycursor.fetchall()
        mycursor.close()

        if resultados:
            for resultado in resultados:
                print(resultado)
        else:
            print("Não foi possível exibir todos os itens")
            
    def exibir_um(self):
        while True:
            try:
                livro_id = int(input("Insira o livro_id para pesquisa: "))
                
                if not MetodosAuxiliares().existe_livro(livro_id):
                    print(f"O livro com ID {livro_id} não foi encontrado.")
                    continuar = input("Deseja tentar outro ID? (S/N): ").strip().lower()
                    if continuar != 's':
                        break
                    else:
                        continue
                
                query = 'SELECT * FROM livraria WHERE livro_id = %s;'
                mycursor = db.cursor()
                mycursor.execute(query, (livro_id,))
                resultado = mycursor.fetchone()
                mycursor.close()

                print(resultado)
               
                continuar = input("Deseja fazer outra pesquisa? (S/N): ").strip().lower()
                if continuar != 's':
                    break

            except ValueError:
                print("O livro_id deve ser um valor inteiro válido.")
        
    def remover_livro(self):
        while True:
            try:
                livro_id = int(input("Insira o livro_id do livro a ser removido: "))
                
                if not MetodosAuxiliares().existe_livro(livro_id):
                    print(f"O livro com ID {livro_id} não foi encontrado.")
                    continuar = input("Deseja tentar outro ID? (S/N): ").strip().lower()
                    if continuar != 's':
                        break
                    else:
                        continue
                
                # Execute a remoção na tabela
                query = 'DELETE FROM livraria WHERE livro_id = %s;'
                mycursor = db.cursor()
                mycursor.execute(query, (livro_id,))
                db.commit()
                mycursor.close()
                print(f"Registro com livro_id: {livro_id} removido com sucesso!")

                continuar = input("Deseja fazer outra remoção? (S/N): ").strip().lower()
                if continuar != 's':
                    break
                
            except ValueError:
                print("O livro_id deve ser um valor inteiro válido.")
                
            except mysql.connector.Error as err:
                    db.rollback()
                    print(f"Erro ao remover o registro: {err}")

#############################################################################