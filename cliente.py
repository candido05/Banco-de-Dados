import mysql.connector
import random

db = mysql.connector.connect(user='root', password='clqb050302',
                              host='localhost', database='banco_de_dados')

class Cliente:
    def __init__(self, id_cliente, nome, CPF, num_cartao, bandeira_cartao):
        self.id_cliente = id_cliente
        self.nome = nome
        self.CPF = CPF
        self.numero_cartao = num_cartao
        self.bandeira_cartao = bandeira_cartao

class CrudCliente:
    def __init__(self):
        pass

    def gerar_id_cliente(self):
        # Gere um ID de cliente aleatório com 10 caracteres numéricos
        id_cliente = ''.join(random.choice('0123456789') for _ in range(8))
        return id_cliente

    def cadastro(self):
        try:
            # Gere um ID de cliente aleatório
            id_cliente = self.gerar_id_cliente()

            nome = input("Insira o nome do cliente: ")
            CPF = input("Insira o CPF do cliente: ")
            numero_cartao = input("Insira o número do cartão: ")
            bandeira_cartao = input("Insira a bandeira do cartão: ")

            cliente = Cliente(id_cliente, nome, CPF, numero_cartao, bandeira_cartao)
            
            # Execute a inserção na tabela Cliente
            query = 'INSERT INTO Cliente (id_cliente, nome, CPF, numero_cartao, bandeira_cartao) VALUES (%s, %s, %s, %s, %s);'
            valores = (cliente.id_cliente, cliente.nome, cliente.CPF, cliente.numero_cartao, cliente.bandeira_cartao)

            mycursor = db.cursor()
            mycursor.execute(query, valores)
            db.commit()
            print("Registro do cliente inserido com sucesso!")

        except mysql.connector.Error as err:
            db.rollback()
            print(f"Erro ao inserir o registro do cliente: {err}")

        finally:
            mycursor.close()

    def validar_id_cliente(self, cpf_cliente):
        # Verifique se o ID do cliente existe na tabela Cliente
        query = 'SELECT CPF FROM Cliente WHERE CPF = %s;'
        mycursor = db.cursor()
        mycursor.execute(query, (cpf_cliente,))
        resultado = mycursor.fetchone()
        
        mycursor.close()
        return resultado is not None

    def login(self, cpf_cliente):
        while True:
            if self.validar_id_cliente(cpf_cliente):
                print("Login bem-sucedido!")
                break
            else:
                print("CPF de cliente não encontrado ou inválido.")
                continuar = input("Deseja tentar novamente? (S/N): ").strip().lower()
                if continuar != 's':
                    break

    def cadastrar_endereco(self, cpf):
        while True:
            try:
                rua = input("Insira o nome da rua: ")
                cep = input("Insira o CEP: ")
                numero = input("Insira o número: ")
                cidade = input("Insira a cidade: ")
                bairro = input("Insira o bairro: ")
                estado = input("Insira o Estado: ")
                id_enderecos = str(random.randint(10000000, 99999999))  # ID aleatório de 8 dígitos

                # Consulta o id_cliente associado ao CPF
                query_id_cliente = 'SELECT id_cliente FROM Cliente WHERE CPF = %s;'
                valores_id_cliente = (cpf,)

                mycursor = db.cursor()
                mycursor.execute(query_id_cliente, valores_id_cliente)
                id_cliente = mycursor.fetchone()
                mycursor.close()

                if id_cliente:
                    id_cliente = id_cliente[0]

                    # Execute a inserção na tabela EnderecosCliente
                    query_enderecos_cliente = '''
                        INSERT INTO EnderecosCliente (id_enderecos, cep, numero, rua, estado, bairro, cidade)
                        VALUES (%s, %s, %s, %s, %s, %s, %s);
                    '''
                    valores_enderecos_cliente = (id_enderecos, cep, numero, rua, estado, bairro, cidade)

                    # Execute a inserção na tabela Enderecos
                    query_enderecos = 'INSERT INTO Enderecos (id_enderecos, id_cliente) VALUES (%s, %s);'
                    valores_enderecos = (id_enderecos, id_cliente)

                    mycursor = db.cursor()

                    try:
                        mycursor.execute(query_enderecos_cliente, valores_enderecos_cliente)
                        mycursor.execute(query_enderecos, valores_enderecos)
                        db.commit()
                        print("Endereço cadastrado com sucesso!")

                        # Atualizar o número de endereços na tabela Cliente
                        query_atualizacao_cliente = 'UPDATE Cliente SET numero_enderecos = numero_enderecos + 1 WHERE id_cliente = %s;'
                        valores_atualizacao_cliente = (id_cliente,)
                        mycursor.execute(query_atualizacao_cliente, valores_atualizacao_cliente)
                        db.commit()
                        print("Número de endereços atualizado.")

                    except mysql.connector.Error as err:
                        db.rollback()
                        print(f"Erro ao cadastrar o endereço: {err}")
                    finally:
                        mycursor.close()
                else:
                    print("CPF não encontrado. Verifique se o CPF está correto ou cadastre o cliente primeiro.")

            except Exception as e:
                print(f"Ocorreu um erro inesperado: {e}")

            continuar = input("Deseja cadastrar outro endereço? (S/N): ").strip().lower()
            if continuar != 's':
                break

    def atualizar_dados(self, cpf):
        while True:
            try:
                print("Opções de atualização:")
                print("1. Atualizar nome")
                print("2. Atualizar informações do cartão")
                print("3. Atualizar informações de endereço (CEP, rua, bairro, cidade, número)")
                print("4. Sair")

                opcao = input("Escolha uma opção (1-4): ")

                # Consulta o id_cliente associado ao CPF
                query_id_cliente = 'SELECT id_cliente FROM Cliente WHERE CPF = %s;'
                valores_id_cliente = (cpf,)

                mycursor = db.cursor()
                mycursor.execute(query_id_cliente, valores_id_cliente)
                id_cliente = mycursor.fetchone()
                mycursor.close()

                if id_cliente:
                    id_cliente = id_cliente[0]

                    if opcao == '1':
                        novo_nome = input("Insira o novo nome: ")

                        # Atualizar nome na tabela Cliente
                        query_cliente = 'UPDATE Cliente SET nome = %s WHERE id_cliente = %s;'
                        valores_cliente = (novo_nome, id_cliente)

                        mycursor = db.cursor()
                        try:
                            mycursor.execute(query_cliente, valores_cliente)
                            db.commit()
                            print("Nome atualizado com sucesso!")

                        except mysql.connector.Error as err:
                            db.rollback()
                            print(f"Erro ao atualizar o nome: {err}")

                    elif opcao == '2':
                        novo_numero_cartao = input("Insira o novo número do cartão: ")
                        nova_bandeira_cartao = input("Insira a nova bandeira do cartão: ")

                        # Atualizar número do cartão e bandeira do cartão na tabela Cliente
                        query_cliente = 'UPDATE Cliente SET numero_cartao = %s, bandeira_cartao = %s WHERE id_cliente = %s;'
                        valores_cliente = (novo_numero_cartao, nova_bandeira_cartao, id_cliente)

                        mycursor = db.cursor()
                        try:
                            mycursor.execute(query_cliente, valores_cliente)
                            db.commit()
                            print("Informações do cartão atualizadas com sucesso!")

                        except mysql.connector.Error as err:
                            db.rollback()
                            print(f"Erro ao atualizar as informações do cartão: {err}")

                    elif opcao == '3':
                        id_endereco = input("Insira o ID do endereço que deseja atualizar: ")
                        novo_cep = input("Insira o novo CEP: ")
                        nova_rua = input("Insira a nova rua: ")
                        novo_bairro = input("Insira o novo bairro: ")
                        nova_cidade = input("Insira a nova cidade: ")
                        novo_numero = input("Insira o novo número: ")
                        novo_estado = input("Insira o novo Estado: ")

                        # Verificar se o endereço pertence ao cliente
                        query_validar_endereco = 'SELECT id_enderecos FROM Enderecos WHERE id_cliente = %s;'
                        valores_validar_endereco = (id_cliente,)
                        mycursor = db.cursor()
                        mycursor.execute(query_validar_endereco, valores_validar_endereco)
                        ids_enderecos = [str(row[0]) for row in mycursor.fetchall()]

                        if id_endereco not in ids_enderecos:
                            print("O endereço com o ID especificado não pertence a você.")
                            continuar = input("Deseja tentar outro ID? (S/N): ").strip().lower()
                            if continuar != 's':
                                break
                            else:
                                continue

                        # Atualizar CEP, rua, bairro, cidade e número na tabela EnderecosCliente
                        query_endereco_cliente = 'UPDATE EnderecosCliente SET cep = %s, rua = %s, bairro = %s, cidade = %s, numero = %s, estado = %s WHERE id_enderecos = %s;'
                        valores_endereco_cliente = (novo_cep, nova_rua, novo_bairro, nova_cidade, novo_numero, novo_estado, id_endereco)

                        try:
                            mycursor.execute(query_endereco_cliente, valores_endereco_cliente)
                            db.commit()
                            print("Endereço atualizado com sucesso!")

                        except mysql.connector.Error as err:
                            db.rollback()
                            print(f"Erro ao atualizar o endereço: {err}")

                    elif opcao == '4':
                        break
                    else:
                        print("Opção inválida. Tente novamente.")
                else:
                    print("CPF não encontrado. Verifique se o CPF está correto ou cadastre o cliente primeiro.")

            except Exception as e:
                print(f"Ocorreu um erro inesperado: {e}")

            continuar = input("Deseja fazer outra atualização? (S/N): ").strip().lower()
            if continuar != 's':
                break

    def exibir_dados_cliente(self, cpf):
        try:
            # Consulta o id_cliente associado ao CPF
            query_id_cliente = 'SELECT id_cliente FROM Cliente WHERE CPF = %s;'
            valores_id_cliente = (cpf,)

            mycursor = db.cursor()
            mycursor.execute(query_id_cliente, valores_id_cliente)
            id_cliente = mycursor.fetchone()
            mycursor.close()

            if id_cliente:
                id_cliente = id_cliente[0]

                # Consulta os dados do Cliente usando o id_cliente
                query = 'SELECT * FROM Cliente WHERE id_cliente = %s;'
                valores = (id_cliente,)

                mycursor = db.cursor()
                mycursor.execute(query, valores)
                resultado = mycursor.fetchone()
                mycursor.close()

                if resultado:
                    print("Dados do Cliente:")
                    print(f"ID do Cliente: {resultado[0]}")
                    print(f"Nome: {resultado[1]}")
                    print(f"CPF: {resultado[2]}")
                    print(f"Número de Endereços: {resultado[3]}")
                    print(f"Número do Cartão: {resultado[4]}")
                    print(f"Bandeira do Cartão: {resultado[5]}")
                else:
                    print("Cliente não encontrado.")
            else:
                print("CPF não encontrado. Verifique se o CPF está correto ou cadastre o cliente primeiro.")

        except mysql.connector.Error as err:
            print(f"Erro ao consultar dados do cliente: {err}")

        except Exception as e:
            print(f"Ocorreu um erro inesperado: {e}")

    def exibir_enderecos_cliente(self, cpf):
        try:
            # Consulta o id_cliente associado ao CPF
            query_id_cliente = 'SELECT id_cliente FROM Cliente WHERE CPF = %s;'
            valores_id_cliente = (cpf,)

            mycursor = db.cursor()
            mycursor.execute(query_id_cliente, valores_id_cliente)
            id_cliente = mycursor.fetchone()
            mycursor.close()

            if id_cliente:
                id_cliente = id_cliente[0]

                # Consulta os endereços do Cliente usando o id_cliente
                query = '''
                    SELECT *
                    FROM Enderecos E
                    JOIN EnderecosCliente EC ON E.id_enderecos = EC.id_enderecos
                    WHERE E.id_cliente = %s;
                '''
                valores = (id_cliente,)

                mycursor = db.cursor()
                mycursor.execute(query, valores)
                resultados = mycursor.fetchall()
                mycursor.close()

                if resultados:
                    print("Endereços do Cliente:")
                    for i, endereco in enumerate(resultados, start=0):
                        print(f"### Endereço {i} ###")
                        print(f"ID do endereço: {endereco[0]}")
                        print(f"CEP: {endereco[3]}")
                        print(f"Rua: {endereco[4]}")
                        print(f"Bairro: {endereco[5]}")
                        print(f"Cidade: {endereco[6]}")
                        print(f"Estado: {endereco[8]}")
                        print(f"Número: {endereco[7]}")
                        print("----")
                else:
                    print("Não foram encontrados endereços para o cliente.")
            else:
                print("CPF não encontrado. Verifique se o CPF está correto ou cadastre o cliente primeiro.")

        except mysql.connector.Error as err:
            print(f"Erro ao consultar endereços do cliente: {err}")

        except Exception as e:
            print(f"Ocorreu um erro inesperado: {e}")

   
    def menu_cliente(self):
        while True:
            print("Menu:")
            print("1. Login")
            print("2. Fazer Cadastro")
            print("3. Sair")
            escolha = input("Escolha uma opção (1/2/3): ")

            if escolha == '1':
                cpf = input("Digite seu CPF para fazer login: ")
                if self.validar_id_cliente(cpf):
                    self.menu_logado_cliente(cpf)
                else:
                    print("CPF não encontrado ou incorreto.")
            elif escolha == '2':
                self.cadastro()
            elif escolha == '3':
                print("Saindo. Até logo!")
                break
            else:
                print("Opção inválida. Tente novamente.")

    def menu_logado_cliente(self, cpf):
        while True:
            print("Menu Logado:")
            print("1. Cadastrar Endereço")
            print("2. Atualizar Dados")
            print("3. Exibir Dados do Cliente")
            print("4. Exibir Endereços do Cliente")
            print("5. Sair")

            escolha = input("Escolha uma opção (1/2/3/4/5): ")

            if escolha == '1':
                self.cadastrar_endereco(cpf)
            elif escolha == '2':
                self.atualizar_dados(cpf)
            elif escolha == '3':
                self.exibir_dados_cliente(cpf)
            elif escolha == '4':
                self.exibir_enderecos_cliente(cpf)
            elif escolha == '5':
                print("Saindo do Menu Logado.")
                break
            else:
                print("Opção inválida. Tente novamente.")


# Exemplo de uso
#cliente = CrudCliente()
#cliente.login("08424591461")

# Exemplo de uso
#insercao_cliente = CrudCliente()
#insercao_cliente.cadastro()

#cad_enderecos = CrudCliente()
#cliente.cadastrar_endereco('084291461')

#cliente.atualizar_dados("08424591461")
#cliente.exibir_dados_cliente("08424591461")
#cliente.exibir_enderecos_cliente("98765432105")
#cliente.cadastro()
#cliente.cadastrar_endereco(53287328)
#10498002694
#07402596456 8521473652 98765432105
'''
if __name__ == "__main__":
    cliente = CrudCliente()
    cliente.menu()

# Feche a conexão com o banco de dados
db.close()
#'''