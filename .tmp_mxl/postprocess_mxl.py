# -*- coding: utf-8 -*-
import json
import sys
import uuid
from xml.etree import ElementTree as ET

NS = "http://v8.1c.ru/8.2/data/spreadsheet"
ET.register_namespace("", NS)
ET.register_namespace("style", "http://v8.1c.ru/8.1/data/ui/style")
ET.register_namespace("v8", "http://v8.1c.ru/8.1/data/core")
ET.register_namespace("v8ui", "http://v8.1c.ru/8.1/data/ui")
ET.register_namespace("xs", "http://www.w3.org/2001/XMLSchema")
ET.register_namespace("xsi", "http://www.w3.org/2001/XMLSchema-instance")


def q(tag):
    return "{%s}%s" % (NS, tag)


def el(tag, text=None):
    node = ET.Element(q(tag))
    if text is not None:
        node.text = str(text)
    return node


def main(json_path, xml_path):
    with open(json_path, "r", encoding="utf-8") as f:
        spec = json.load(f)

    area_cols = {}
    for area in spec["areas"]:
        max_col = 0
        for row in area["rows"]:
            for cell in row.get("cells", []):
                max_col = max(max_col, int(cell["col"]) - 1)
        area_cols[area["name"]] = max_col

    tree = ET.parse(xml_path)
    root = tree.getroot()

    for ni in root.findall(q("namedItem")):
        name = ni.find(q("name")).text
        area = ni.find(q("area"))
        area.find(q("type")).text = "Rectangle"
        area.find(q("beginColumn")).text = "0"
        area.find(q("endColumn")).text = str(area_cols.get(name, 0))

    conn_id = str(uuid.uuid4())
    conn_cols = el("columns")
    conn_cols.append(el("id", conn_id))
    conn_cols.append(el("size", "1"))
    ci = el("columnsItem")
    ci.append(el("index", "0"))
    col = el("column")
    col.append(el("formatIndex", "1"))
    ci.append(col)
    conn_cols.append(ci)

    first_cols = root.find(q("columns"))
    idx = list(root).index(first_cols)
    root.insert(idx + 1, conn_cols)

    fmt_conn = el("format")
    fmt_conn.append(el("width", "24"))
    formats = root.findall(q("format"))
    last_fmt = formats[-1]
    root.insert(list(root).index(last_fmt) + 1, fmt_conn)
    conn_fmt_index = len(root.findall(q("format")))
    col.find(q("formatIndex")).text = str(conn_fmt_index)

    named = {}
    for ni in root.findall(q("namedItem")):
        named[ni.find(q("name")).text] = ni

    conn_names = [
        "КоннекторВерхПравоНиз",
        "КоннекторВерхПраво",
        "КоннекторВерхНиз",
        "Отступ",
    ]
    rows_by_index = {}
    for ri in root.findall(q("rowsItem")):
        rows_by_index[int(ri.find(q("index")).text)] = ri

    for cn in conn_names:
        ni = named[cn]
        br = int(ni.find(q("area")).find(q("beginRow")).text)
        row = rows_by_index[br].find(q("row"))
        cid = el("columnsID", conn_id)
        row.insert(0, cid)

    pics = [
        "v8ui:КоннекторВерхПравоНиз",
        "v8ui:КоннекторВерхПраво",
        "v8ui:КоннекторВерхНиз",
    ]
    for i, ref in enumerate(pics):
        pic = el("picture")
        pic.append(el("index", str(i)))
        inner = el("picture")
        inner.set("t", "false")
        inner.set("ref", ref)
        pic.append(inner)
        root.append(pic)

    draw_fmt = el("format")
    draw_fmt.append(el("drawingBorder", "0"))
    draw_fmt.append(el("hyperLink", "false"))
    root.append(draw_fmt)
    draw_fmt_index = len(root.findall(q("format")))

    first_named = root.find(q("namedItem"))
    insert_at = list(root).index(first_named)
    picture_index = 1
    draw_id = 1
    for cn in conn_names[:3]:
        br = int(named[cn].find(q("area")).find(q("beginRow")).text)
        dr = el("drawing")
        dr.append(el("drawingType", "Picture"))
        dr.append(el("id", str(draw_id)))
        dr.append(el("formatIndex", str(draw_fmt_index)))
        dr.append(el("beginRow", str(br)))
        dr.append(el("beginRowOffset", "0"))
        dr.append(el("endRow", str(br)))
        dr.append(el("endRowOffset", "57"))
        dr.append(el("beginColumn", "0"))
        dr.append(el("beginColumnOffset", "0"))
        dr.append(el("endColumn", "0"))
        dr.append(el("endColumnOffset", "57"))
        dr.append(el("autoSize", "false"))
        dr.append(el("pictureSize", "Proportionally"))
        dr.append(el("zOrder", str(draw_id)))
        dr.append(el("pictureIndex", str(picture_index)))
        root.insert(insert_at, dr)
        insert_at += 1
        draw_id += 1
        picture_index += 1

    tree.write(xml_path, encoding="utf-8", xml_declaration=True)
    dest = r"c:\repo\Aurum.ut\ut\src\Reports\АУ_КонтрольЗаказовКлиентов\Templates\МакетМонитора\Template.mxlx"
    import os
    import shutil
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    shutil.copy2(xml_path, dest)
    print("[OK] postprocess", xml_path)
    print("[OK] copied", dest)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
