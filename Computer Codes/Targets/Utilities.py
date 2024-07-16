import random

import xlwings as xw

def OutputExcel(sheetname: str, title: str, reference: list, inital_row: int, df=[], fig=[]):
    wb = xw.Book(r"C:\Users\fuqih\Documents\GitHub\DatabaseCodes_QF\Computer Codes\Database.xlsx")
    sht = wb.sheets[sheetname]

    if df:
        sht.range('A' + str(inital_row)).value = df[0]
        inital_row += df[0].shape[0] + 3

    if fig:
        sht.pictures.add(
            fig[0],
            name=title,
            update=True,
            left=sht.range('B' + str(inital_row)).left,
            top=sht.range('B' + str(inital_row)).top
        )
        inital_row += 24

    sht.range('A' + str(inital_row)).value = (title)
    for index, ref in enumerate(reference):
        sht.range("A" + str(inital_row + int(index) + 1)).value = (ref)

    wb.save()
    print("finished")
    return None

def clear_sheet(sheetname):
    wb = xw.Book(r"C:\Users\fuqih\Documents\GitHub\DatabaseCodes_QF\Computer Codes\Database.xlsx")
    sht = wb.sheets[sheetname]
    sht.clear_contents()

    for shape in sht.shapes:
        shape.delete()

    wb.save()
    print("finished")
    return None