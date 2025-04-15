from sys import stdin
def main():
    n = 2000
    for i in range(n):
        line = stdin.readline().split(",")
        constante = "insert into envios (fecha, fechaEntrega, estado, idDomiciliario, costo, idPedido) values ("
        # print(constante + line[0] + ","+ line[1] + ", '0-0-0', 1000, 0);")
        # print(line)
        print(constante + "TO_DATE('2024-12-31', 'YYYY-MM-DD')" + "," + "TO_DATE('2025-12-31', 'YYYY-MM-DD')" + "," + line[2]+ "," + line[3]+ "," + line[4]+ "," + line[5] + ")")
main()