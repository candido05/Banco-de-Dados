from livraria import livraria

class Main:
    
    def __init__(self):
        self.operacoes = livraria()
    
    def exibir_menu(self):
        while True:
            print("Menu:")
            print("1. Inserir Livro")
            print("2. Alterar dados da tabela")
            print("3. Pesquisar por atributos da tabela")
            print("4. Exibir dados de um livro")
            print("5. Exibir Todos os Livros")
            print("6. Remover Livro")
            print("7. Sair")

            escolha = input("Escolha uma operação: ")

            if escolha == '1':
                self.operacoes.inserir_livro()
            elif escolha == '2':
                self.operacoes.alterar()
            elif escolha == '3':
                self.operacoes.pesquisar_por_nome()
            elif escolha == '4':
                self.operacoes.exibir_um()
            elif escolha == '5':
                self.operacoes.exibir_todos()
            elif escolha == '6':
                self.operacoes.remover_livro()
            elif escolha == '7':
                print("Saindo do programa.")
                break
            else:
                print("Escolha inválida. Por favor, escolha uma opção válida.")

            escolha = input("Deseja fazer outra operção7? (S/N): ").strip().lower()
            if escolha != 's':
                break

if __name__ == "__main__":
    main = Main()
    main.exibir_menu()
