import sys
from datetime import datetime
from odf.opendocument import OpenDocumentText
from odf.style import Style, TextProperties, ParagraphProperties
from odf.text import P, H, List, ListItem

def create_contract(file_path, tenant_number, mall_name, employee_number, pavilion_number, end_date):
    # Создаем новый документ
    doc = OpenDocumentText()

    # Стиль для заголовков
    title_style = Style(name="TitleStyle", family="paragraph")
    title_style.addElement(TextProperties(fontsize="18pt", fontweight="bold"))
    doc.styles.addElement(title_style)

    # Стиль для пунктов списка
    list_item_style = Style(name="ListItemStyle", family="paragraph")
    list_item_style.addElement(TextProperties(fontsize="12pt"))
    list_item_style.addElement(ParagraphProperties(marginleft="1cm", textindent="-0.5cm"))
    doc.styles.addElement(list_item_style)

    # Текущая дата и время
    current_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Заголовок документа
    title = H(outlinelevel=1, stylename=title_style, text="Договор аренды")
    doc.text.addElement(title)

    # Основные пункты договора
    main_points = List()
    
    point1 = ListItem()
    point1.addElement(P(stylename=list_item_style, text=f"Название фирмы арендатора: {tenant_number}"))
    
    point2 = ListItem()
    point2.addElement(P(stylename=list_item_style, text=f"Название торгового центра: {mall_name}"))
    
    point3 = ListItem()
    point3.addElement(P(stylename=list_item_style, text=f"Email сотрудника: {employee_number}"))
    
    point4 = ListItem()
    point4.addElement(P(stylename=list_item_style, text=f"Номер павильона: {pavilion_number}"))
    
    point5 = ListItem()
    point5.addElement(P(stylename=list_item_style, text=f"Дата и время подписания договора: {current_datetime}"))
    
    point6 = ListItem()
    point6.addElement(P(stylename=list_item_style, text=f"Дата окончания аренды: {end_date}"))
    
    # Добавляем пункты в список
    main_points.addElement(point1)
    main_points.addElement(point2)
    main_points.addElement(point3)
    main_points.addElement(point4)
    main_points.addElement(point5)
    main_points.addElement(point6)

    # Базовый текст договора
    contract_text = P(stylename=list_item_style, text=(
        "Настоящим подтверждается, что арендатор обязуется соблюдать все условия данного договора аренды, "
        "включая своевременную оплату аренды и поддержание чистоты и порядка в арендованном павильоне. "
        "Арендодатель оставляет за собой право расторгнуть договор в случае нарушения арендатором условий "
        "данного договора."
    ))

    # Добавляем основные пункты и базовый текст в документ
    doc.text.addElement(main_points)
    doc.text.addElement(contract_text)

    # Сохраняем документ
    doc.save(file_path)

if __name__ == "__main__":
    if len(sys.argv) != 7:
        print("Usage: create_contract.py <file_path> <tenant_number> <mall_name> <employee_number> <pavilion_number> <end_date>")
        sys.exit(1)

    file_path = sys.argv[1]
    tenant_number = sys.argv[2]
    mall_name = sys.argv[3]
    employee_number = sys.argv[4]
    pavilion_number = sys.argv[5]
    end_date = sys.argv[6]

    create_contract(file_path, tenant_number, mall_name, employee_number, pavilion_number, end_date)

