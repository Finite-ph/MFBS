#!/usr/bin/env python3
"""查看数据库表结构"""

import sys
sys.path.insert(0, 'd:/quantitative_analysis-master/app/utils')
from db_utils import DatabaseUtils

conn, cursor = DatabaseUtils.connect_to_mysql()

# 显示所有表
cursor.execute('SHOW TABLES')
tables = cursor.fetchall()
print('\n=== 数据库中的表 ===')
for i, t in enumerate(tables, 1):
    print(f'{i:2}. {t[0]}')

# 统计各表数据量
print('\n=== 各表数据量 ===')
for t in tables:
    table_name = t[0]
    try:
        cursor.execute(f'SELECT COUNT(*) FROM {table_name}')
        count = cursor.fetchone()[0]
        cursor.execute(f'SELECT COUNT(DISTINCT ts_code) FROM {table_name}' if 'ts_code' in ['ts_code', 'trade_date'] else f'SELECT COUNT(*) FROM {table_name}')
        cursor.execute(f'SELECT COUNT(DISTINCT ts_code) FROM {table_name}')
        distinct = cursor.fetchone()[0]
        print(f'{table_name}: {count:,} rows, {distinct:,} stocks')
    except:
        try:
            cursor.execute(f'SELECT COUNT(*) FROM {table_name}')
            count = cursor.fetchone()[0]
            print(f'{table_name}: {count:,} rows')
        except:
            print(f'{table_name}: error')

cursor.close()
conn.close()