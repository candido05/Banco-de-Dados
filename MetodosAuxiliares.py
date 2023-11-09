import mysql.connector

# Conecteca ao banco de dados MySQL usando mysql.connector
db = mysql.connector.connect(user='root', password='clqb050302',
                              host='localhost', database='banco_de_dados')

class MetodosAuxiliares:
    @staticmethod
    def existe_livro(livro_id):
        # Verifica se o livro com o ID fornecido existe na tabela
        query = 'SELECT livro_id FROM livraria WHERE livro_id = %s;'
        mycursor = db.cursor()
        mycursor.execute(query, (livro_id,))
        resultado = mycursor.fetchone()
        mycursor.close()
        return resultado is not None
    
    def executa_pesquisa(self, coluna, termo):
        query = f'SELECT * FROM livraria WHERE {coluna} = %s;'
        mycursor = db.cursor()
        mycursor.execute(query, (termo,))
        resultados = mycursor.fetchall()
        mycursor.close()
        
        if resultados:
          for r in resultados:
            print(r)
        else:
          print("Nenhum valor encontrado")

    def executar_pesquisa_valor(self, coluna, valor_min, valor_max):
        query = f'SELECT * FROM livraria WHERE {coluna} BETWEEN %s AND %s;'
        mycursor = db.cursor()
        mycursor.execute(query, (valor_min, valor_max))
        resultados = mycursor.fetchall()
        mycursor.close()

        if resultados:
            for resultado in resultados:
                print(resultado)
        else:
            print("Nenhum resultado encontrado.")
    