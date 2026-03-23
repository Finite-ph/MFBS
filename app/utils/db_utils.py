import os
import pymysql
import tushare as ts

class DatabaseUtils:
    # 数据库连接信息 - 请在环境变量或.env文件中配置
    _host = os.getenv('DB_HOST', 'localhost')
    _user = os.getenv('DB_USER', 'root')
    _password = os.getenv('DB_PASSWORD', '')
    _database = os.getenv('DB_NAME', 'stock_cursor')
    _charset = 'utf8mb4'

    # Tushare API token - 请在环境变量TUSHARE_TOKEN中配置
    tushare_token = os.getenv('TUSHARE_TOKEN', '')

    @classmethod
    def init_tushare_api(cls):
        """
        初始化Tushare API
        :return: Tushare pro API对象
        """
        if not cls.tushare_token:
            raise ValueError("未设置TUSHARE_TOKEN环境变量")
        pro = ts.pro_api(cls.tushare_token)
        pro._DataApi__http_url = "http://121.40.135.59:8010/"
        return pro

    @classmethod
    def connect_to_mysql(cls):
        """
        连接到MySQL数据库
        :return: MySQL连接对象和游标
        """
        conn = pymysql.connect(
            host=cls._host,
            user=cls._user,
            password=cls._password,
            database=cls._database,
            charset=cls._charset
        )
        cursor = conn.cursor()
        return conn, cursor