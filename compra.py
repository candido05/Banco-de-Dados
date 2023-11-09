import mysql.connector
import random

db = mysql.connector.connect(user='root', password='clqb050302',
                              host='localhost', database='banco_de_dados')

class CompraObj:
    def __init__(self, id_compra, id_livro, quantidade_por_livro):
        self.id_compra = id_compra
        self.id_livro = id_livro
        self.quantidade_por_livro = quantidade_por_livro

class Compra:
    
    def gerar_id(self):
        # Gerar um ID de compra único com 8 caracteres
        id_compra = ''.join(random.choice('0123456789') for _ in range(10))
        return id_compra
    
    def gerar_id_compra(self):
        # Gerar um ID de compra único com 8 caracteres
        id_compra = ''.join(random.choice('0123456789') for _ in range(8))
        return id_compra
    
    
    def comprar(self, cpf):
        try:
            # Verificar se o cliente existe com base no CPF
            query_cliente = 'SELECT id_cliente, numero_enderecos FROM Cliente WHERE cpf = %s;'
            valores_cliente = (cpf,)

            mycursor = db.cursor()
            mycursor.execute(query_cliente, valores_cliente)
            cliente_info = mycursor.fetchone()

            if cliente_info:
                id_cliente, numero_enderecos = cliente_info
                print("CPF reconhecido. Você está pronto para fazer uma compra.")
            else:
                print("CPF não encontrado. Certifique-se de estar cadastrado como cliente.")
                return

            if numero_enderecos == 0:
                print("Você precisa adicionar um endereço antes de fazer uma compra.")
                return

            ''''
            query_sousa = 
                    SELECT ec.cidade
                    FROM Cliente c
                    INNER JOIN Enderecos e ON c.id_cliente = e.id_cliente
                    INNER JOIN EnderecosCliente ec ON e.id_enderecos = ec.id_enderecos
                    WHERE c.id_cliente = %s
                    AND ec.cidade = 'Sousa';
                    
            endereco_sousa = (id_cliente,)
            mycursor.execute(query_sousa, endereco_sousa)
            resultado = mycursor.fetchone()  # Use fetchone para obter uma única linha
            cidade_sousa = resultado[0]
            '''
            
            # Listar endereços disponíveis para envio
            query_enderecos = '''
                    SELECT *
                    FROM Enderecos E
                    JOIN EnderecosCliente EC ON E.id_enderecos = EC.id_enderecos
                    WHERE E.id_cliente = %s;
                    '''
            valores_enderecos = (id_cliente,)

            mycursor.execute(query_enderecos, valores_enderecos)
            enderecos = mycursor.fetchall()

            print("Endereços disponíveis para envio:")
            print("ID_endereço | CEP | Rua | Bairro | Cidade | Número")
            for i, endereco in enumerate(enderecos, start=1):
                print(f"{i}. {endereco[2]}, {endereco[3]}, {endereco[4]}, {endereco[5]}, {endereco[6]}, {endereco[7]}")
            print(" ")
            while True:
                escolha_endereco = input("Escolha o número do endereço para envio: ")
                if escolha_endereco.isdigit():
                    escolha_endereco = int(escolha_endereco)
                    break
                else:
                  print("Opção inválida. Tente novamente.")
            
            query_sousa = '''
                    SELECT ec.cidade
                    FROM EnderecosCliente ec
                    INNER JOIN Enderecos e ON ec.id_enderecos = e.id_enderecos
                    WHERE e.id_cliente = %s
                    AND e.id_enderecos = %s;
                    '''
            endereco_sousa = (id_cliente, escolha_endereco)
            mycursor.execute(query_sousa, endereco_sousa)
            resultado = mycursor.fetchone()  # Use fetchone para obter uma única linha
            cidade_sousa = resultado[0]
            
            # Inicializar as variáveis para o carrinho
            carrinho = []
            total_carrinho = 0

            while True:
                print("Menu de Compra:")
                print("1. Adicionar Livro ao Carrinho")
                print("2. Finalizar Compra")
                print("3. Sair")
                escolha = input("Escolha uma opção (1/2/3): ")
                print(" ")

                if escolha == '1':
                    livro_nome = input("Digite o nome do livro: ")
                    escritor = input("Digite o nome do escritor: ")
                    quantidade = int(input("Digite a quantidade que você deseja comprar: "))

                    # Verificar se o livro está disponível no estoque
                    id_livro = self.obter_id_livro(livro_nome, escritor)
                    estoque_atual = self.obter_estoque_atual(id_livro)

                    query_valor_total = """
                        SELECT SUM(L.valor * %s) AS valor_total
                        FROM Livraria AS L
                        WHERE L.livro_id = %s;
                    """
                    
                    valores_valor_total = (quantidade, id_livro)
                    mycursor = db.cursor()
                    mycursor.execute(query_valor_total, valores_valor_total)
                    resultado = mycursor.fetchone()

                    if resultado:
                        valor_total = resultado[0]
                        carrinho.append((id_livro, quantidade, valor_total))
                        total_carrinho += valor_total
                        print(f"{quantidade} cópia(s) do livro foram adicionadas ao seu carrinho. Valor total: R$ {valor_total:.2f}")
                    else:
                        print("Livro não encontrado no estoque.")

                    db.commit()

                elif escolha == '2':
                    if not carrinho:
                        print("Seu carrinho está vazio. Adicione itens antes de finalizar a compra.")
                    else:
                        # Gerar um ID de compra
                        id_compra = self.gerar_id_compra()
        
                        # Inserir dados da compra em DadosCompra
                        for item in carrinho:
                            id_dados = self.gerar_id()
                            livro_id, quantidade, valor_total = item
                            query_dados_compra = 'INSERT INTO DadosCompra (id_dados, id_compra, id_livro, quantidade_por_livro) VALUES (%s, %s, %s, %s);'
                            valores_dados_compra = (id_dados, id_compra, livro_id, quantidade)
                            mycursor.execute(query_dados_compra, valores_dados_compra)

                        # Inserir dados da compra em Vendas
                        query_vendas = 'INSERT INTO Vendas (id_compra, quantidade_total, valor_total) VALUES (%s, %s, %s);'
                        valores_vendas = (id_compra, sum(item[1] for item in carrinho), total_carrinho)
                        mycursor.execute(query_vendas, valores_vendas)

                        # Inserir dados da compra em Compra
                        query_compra = 'INSERT INTO Compra (id_compra, id_cliente) VALUES (%s, %s);'
                        valores_compra = (id_compra, id_cliente)
                        mycursor.execute(query_compra, valores_compra)

                        # Atualizar o estoque dos livros
                        for livro_id, quantidade, _ in carrinho:
                            estoque_atual = self.obter_estoque_atual(livro_id)
                            novo_estoque = estoque_atual - quantidade

                        query_atualizar_estoque = 'UPDATE livraria SET estoque_atual = %s WHERE livro_id = %s;'
                        valores_atualizar_estoque = (novo_estoque, livro_id)
                        mycursor.execute(query_atualizar_estoque, valores_atualizar_estoque)
                        
                        # Atualizar o histórico de compras do cliente
                        query_historico_compra = 'INSERT INTO historicodecompras (id_cliente, quantidade_total, valor_total) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE quantidade_total = quantidade_total + %s, valor_total = valor_total + %s;'
                        valores_historico_compra = (id_cliente, sum(item[1] for item in carrinho), total_carrinho, sum(item[1] for item in carrinho), total_carrinho)
                        mycursor.execute(query_historico_compra, valores_historico_compra)

                        # Verificar se o cliente é de Sousa e aplicar o desconto se aplicável
                        if cidade_sousa == 'Sousa':
                            self.calcular_desconto_sousa(cpf)

                    # Limpar o carrinho
                    carrinho = []
                    total_carrinho = 0
                    
                    db.commit()
                    
                    print("Compra finalizada. Obrigado!")

                elif escolha == '3':
                    print("Saindo do Menu de Compra.")
                    break

                else:
                    print("Opção inválida. Tente novamente.")

        except mysql.connector.Error as err:
            db.rollback()
            print(f"Erro ao realizar a compra: {err}")

        finally:
            mycursor.close()
           
    def obter_preco_livro(self, livro_nome, escritor):
        try:
            query = 'SELECT valor FROM livraria WHERE livro_nome = %s AND escritor = %s;'
            valores = (livro_nome, escritor)

            mycursor = db.cursor()
            mycursor.execute(query, valores)
            resultado = mycursor.fetchone()

            if resultado:
                return resultado
            else:
                print(f"O livro '{livro_nome}' do escritor '{escritor}' não foi encontrado no catálogo.")
                return None

        except mysql.connector.Error as err:
            print(f"Erro ao obter o preço do livro: {err}")
            return None

  
    def obter_id_livro(self, livro_nome, escritor):
        try:
            query = 'SELECT livro_id FROM Livraria WHERE livro_nome = %s AND escritor = %s;'
            valores = (livro_nome, escritor)

            mycursor = db.cursor()
            mycursor.execute(query, valores)
            resultado = mycursor.fetchone()

            if resultado:
                return resultado[0]
            else:
                print(f"O livro '{livro_nome}' do escritor '{escritor}' não foi encontrado no catálogo.")
                return None

        except mysql.connector.Error as err:
            print(f"Erro ao obter o ID do livro: {err}")
            return None
            
    def obter_estoque_atual(self, livro_id):
        try:
            # Execute a consulta para obter o estoque atual do livro
            query = 'SELECT estoque_atual FROM Livraria WHERE livro_id = %s;'
            valores = (livro_id,)

            mycursor = db.cursor()
            mycursor.execute(query, valores)
            resultado = mycursor.fetchone()

            if resultado:
                estoque_atual = resultado[0]
                return estoque_atual
            else:
                print("Livro não encontrado.")
                return None

        except mysql.connector.Error as err:
            print(f"Erro ao obter estoque atual: {err}")
            return None
        
        
    def historico(self, cpf):
        while True:
            try:
                print("Menu de Histórico:")
                print("1. Histórico da compra mais recente")
                print("2. Histórico geral")
                print("3. Histórico no ano")
                print("4. Sair")
                escolha = input("Escolha uma opção (1/2/3/4): ")
                print(" ")

                if escolha == '1':
                    self.historico_compra_recente(cpf)
                elif escolha == '2':
                    self.historico_compra_geral(cpf)
                elif escolha == '3':
                    self.historico_compra_no_ano(cpf)
                elif escolha == '4':
                    print("Saindo do menu de histórico.")
                    break
                else:
                    print("Opção inválida. Tente novamente.")
            except mysql.connector.Error as err:
                print(f"Erro ao acessar o histórico: {err}")

    def historico_compra_recente(self, cpf):
        # Consulta SQL para obter histórico da compra mais recente
        query = '''
            SELECT v.*
                FROM Vendas v
                JOIN Compra c ON v.id_compra = c.id_compra
                JOIN DadosCompra dc ON c.id_compra = dc.id_compra
                JOIN Cliente cli ON c.id_cliente = cli.id_cliente
                WHERE cli.CPF = %s
                ORDER BY dc.data_compra DESC
                LIMIT 1;

        '''

        mycursor = db.cursor()
        mycursor.execute(query, (cpf,))
        historico = mycursor.fetchone()
        mycursor.close()

        if historico:
            id_compra, quantidade_total, valor_total = historico
            print("Histórico da compra mais recente:")
            print(f"ID da Compra: {id_compra}")
            print(f"Quantidade Total: {quantidade_total}")
            print(f"Valor Total: {valor_total}")
            print(" ")
        else:
            print("Nenhum histórico de compra mais recente encontrado.")

    def historico_compra_geral(self, cpf):
        # Consulta SQL para obter histórico geral
        query = '''
            SELECT H.id_cliente, H.quantidade_total, H.valor_total
            FROM historicodecompras AS H
            WHERE H.id_cliente = (SELECT id_cliente FROM Cliente WHERE cpf = %s);
        '''

        mycursor = db.cursor()
        mycursor.execute(query, (cpf,))
        historico = mycursor.fetchall()
        mycursor.close()

        if historico:
            print("Histórico Geral de Compras:")
            for item in historico:
                id_cliente, quantidade_total, valor_total = item
                print(f"ID do Cliente: {id_cliente}")
                print(f"Quantidade Total: {quantidade_total}")
                print(f"Valor Total: {valor_total}")
                print(" ")
                print("----")
        else:
            print("Nenhum histórico geral de compra encontrado.")

    def historico_compra_no_ano(self, cpf):
        # Consulta SQL para obter histórico no ano
        query = '''
            SELECT *
            FROM ComprasClienteNoAno AS CC
            WHERE CC.id_cliente = (SELECT id_cliente FROM Cliente WHERE cpf = %s);
        '''

        mycursor = db.cursor()
        mycursor.execute(query, (cpf,))
        historico = mycursor.fetchall()
        mycursor.close()

        if historico:
            print("Histórico de Compras no Ano:")
            for item in historico:
                id_cliente, nome, quantidade_total, valor_total = item
                print(f"ID do Cliente: {id_cliente}")
                print(f"Nome do Cliente: {nome}")
                print(f"Quantidade Total de livros comprados no ano: {quantidade_total}")
                valor = "{:.2f}".format(valor_total)
                print(f"Valor Total no Ano: {valor}")
                print(" ")
                print("----")
        else:
            print("Nenhum histórico de compras no ano encontrado.")
            
    def calcular_desconto_sousa(self, cliente_CPF):
            try:
                
                mycursor = db.cursor()
                mycursor.callproc('CD4', (cliente_CPF,))
                db.commit()
                print("Desconto aplicado com sucesso")

            except mysql.connector.Error as err:
                db.rollback()
                print(f"Erro ao calcular desconto: {err}")

            finally:
                mycursor.close()         

    def menu_compra(self, cpf):
            while True:
                try:
                    print("Menu Principal:")
                    print("1. Realizar Compra")
                    print("2. Visualizar Histórico")
                    print("3. Sair")
                    escolha = input("Escolha uma opção (1/2/3): ")
                    print(" ")

                    if escolha == '1':
                        self.comprar(cpf)
                    elif escolha == '2':
                        self.historico(cpf)
                    elif escolha == '3':
                        print("Saindo do menu.")
                        break
                    else:
                        print("Opção inválida. Tente novamente.")
                except mysql.connector.Error as err:
                    print(f"Erro: {err}")


                
###############################################################################
#cliente = Compra()
#cliente.comprar("08424591461")
#cliente.historico("08424591461")
'''
if __name__ == "__main__":
    cpf = input("Digite o seu CPF: ")
    compra = Compra()
    compra.menu(cpf)
'''