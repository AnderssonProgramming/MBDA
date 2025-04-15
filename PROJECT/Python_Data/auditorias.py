from sys import stdin
def main():
    n = 2000
    for i in range(n):
        line = stdin.readline().split(",")
        constante = "insert into auditorias_delizia (nitEmpresa, platos_vendidos, platos_por_vender, ganancias, perdidas, fecha_auditoria) values ("
        # print(constante + line[0] + ","+ line[1] + ", '0-0-0', 1000, 0);")
        # print(line)
        print(constante + line[0] + "," + line[1] + "," + line[2]+ "," + line[3]+ "," + line[4]+ ",TO_DATE('2024-12-31', 'YYYY-MM-DD'));")
main()