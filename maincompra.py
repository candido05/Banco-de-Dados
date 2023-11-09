from compra import Compra
from cliente import CrudCliente

class MainCompra:
    
    def __init__(self):
        self.compra = Compra()
        self.cliente = CrudCliente()
    
    def menu_principal(self):
        while True:
            print("Menu Principal:")
            print("1. Acesso Cliente")
            print("2. Realizar Compra")
            print("3. Sair")
            escolha = input("Escolha uma opção (1/2/3): ")

            if escolha == '1':
                self.menu_cliente()
            elif escolha == '2':
                cpf = input("Digite o seu CPF: ")
                self.compra.menu_compra(cpf)
            elif escolha == '3':
                print("Saindo. Até logo!")
                break
            else:
                print("Opção inválida. Tente novamente.")

    def menu_cliente(self):
        while True:
            print("Menu Cliente:")
            print("1. Login")
            print("2. Fazer Cadastro")
            print("3. Sair")
            escolha = input("Escolha uma opção (1/2/3): ")

            if escolha == '1':
                cpf = input("Digite seu CPF para fazer login: ")
                if self.cliente.validar_id_cliente(cpf):
                    self.menu_logado_cliente(cpf)
                else:
                    print("CPF não encontrado ou incorreto.")
            elif escolha == '2':
                self.cliente.cadastro()
            elif escolha == '3':
                print("Saindo do menu Cliente.")
                break
            else:
                print("Opção inválida. Tente novamente.")

    def menu_logado_cliente(self, cpf):
        while True:
            print("Menu Logado Cliente:")
            print("1. Cadastrar Endereço")
            print("2. Atualizar Dados")
            print("3. Exibir Dados do Cliente")
            print("4. Exibir Endereços do Cliente")
            print("5. Sair")

            escolha = input("Escolha uma opção (1/2/3/4/5): ")

            if escolha == '1':
                self.cliente.cadastrar_endereco(cpf)
            elif escolha == '2':
                self.cliente.atualizar_dados(cpf)
            elif escolha == '3':
                self.cliente.exibir_dados_cliente(cpf )
            elif escolha == '4':
                self.cliente.exibir_enderecos_cliente(cpf)
            elif escolha == '5':
                print("Saindo do Menu Logado Cliente.")
                break
            else:
                print("Opção inválida. Tente novamente.")

    def main(self):
        
        while True:
            print("Bem-vindo ao programa de compras!")
            print("1. Acesso Cliente")
            print("2. Realizar Compra")
            print("3. Sair")

            escolha = input("Escolha uma opção (1/2/3): ")

            if escolha == '1':
                self.cliente.menu_cliente()
            elif escolha == '2':
                cpf = input("Digite o seu CPF: ")
                self.compra.menu_compra(cpf)
            elif escolha == '3':
                print("Saindo. Até logo!")
                break
            else:
                print("Opção inválida. Tente novamente.")

if __name__ == "__main__":
    main = MainCompra()
    main.main()