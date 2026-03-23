#!/usr/bin/env python3
"""
实时交易分析数据库初始化脚本
创建分钟级数据表和相关索引
"""

import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app import create_app
from app.extensions import db
from app.models.stock_minute_data import StockMinuteData
from app.services.realtime_data_manager import RealtimeDataManager
from app.utils.db_utils import DatabaseUtils
import logging

# 配置日志
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def init_realtime_database():
    """初始化实时分析数据库"""
    app = create_app()
    
    with app.app_context():
        try:
            logger.info("开始初始化实时分析数据库...")
            
            # 创建表
            db.create_all()
            logger.info("✅ 数据库表创建成功")
            
            # 验证表是否创建成功
            inspector = db.inspect(db.engine)
            tables = inspector.get_table_names()
            
            if 'stock_minute_data' in tables:
                logger.info("✅ stock_minute_data 表创建成功")
                
                # 检查索引
                indexes = inspector.get_indexes('stock_minute_data')
                logger.info(f"📊 创建了 {len(indexes)} 个索引")
                for idx in indexes:
                    logger.info(f"   - {idx['name']}: {idx['column_names']}")
            else:
                logger.error("❌ stock_minute_data 表创建失败")
                return False
            
            logger.info("🎉 实时分析数据库初始化完成！")
            return True
            
        except Exception as e:
            logger.error(f"❌ 数据库初始化失败: {str(e)}")
            return False

def create_sample_data():
    """创建示例数据"""
    app = create_app()
    
    with app.app_context():
        try:
            logger.info("开始创建示例数据...")
            
            # 初始化数据管理器
            data_manager = RealtimeDataManager(DatabaseUtils.tushare_token)
            
            # 创建几只股票的示例数据
            sample_stocks = ['000001.SZ', '000002.SZ', '600000.SH']
            
            for stock_code in sample_stocks:
                logger.info(f"正在为 {stock_code} 创建示例数据...")
                
                # 同步最近3天的数据
                result = data_manager.sync_minute_data(stock_code)
                
                if result['success']:
                    logger.info(f"✅ {stock_code} 示例数据创建成功: {result['data_count']} 条记录")
                else:
                    logger.warning(f"⚠️ {stock_code} 示例数据创建失败: {result['message']}")
            
            logger.info("🎉 示例数据创建完成！")
            return True
            
        except Exception as e:
            logger.error(f"❌ 示例数据创建失败: {str(e)}")
            return False

def check_database_status():
    """检查数据库状态"""
    app = create_app()
    
    with app.app_context():
        try:
            logger.info("检查数据库状态...")
            
            # 检查表是否存在
            inspector = db.inspect(db.engine)
            tables = inspector.get_table_names()
            
            if 'stock_minute_data' not in tables:
                logger.error("❌ stock_minute_data 表不存在")
                return False
            
            # 统计数据量
            total_records = StockMinuteData.query.count()
            logger.info(f"📊 总记录数: {total_records}")
            
            # 统计各周期数据量
            periods = StockMinuteData.get_period_types()
            for period in periods:
                count = StockMinuteData.query.filter_by(period_type=period).count()
                logger.info(f"   - {period}: {count} 条记录")
            
            # 统计股票数量
            stock_count = db.session.query(StockMinuteData.ts_code).distinct().count()
            logger.info(f"📈 股票数量: {stock_count}")
            
            # 获取时间范围
            latest_time = db.session.query(db.func.max(StockMinuteData.datetime)).scalar()
            earliest_time = db.session.query(db.func.min(StockMinuteData.datetime)).scalar()
            
            if latest_time and earliest_time:
                logger.info(f"⏰ 数据时间范围: {earliest_time} ~ {latest_time}")
            
            logger.info("✅ 数据库状态检查完成")
            return True
            
        except Exception as e:
            logger.error(f"❌ 数据库状态检查失败: {str(e)}")
            return False

def main():
    """主函数"""
    print("=" * 60)
    print("实时交易分析数据库初始化工具")
    print("=" * 60)
    
    while True:
        print("\n请选择操作:")
        print("1. 初始化数据库")
        print("2. 创建示例数据")
        print("3. 检查数据库状态")
        print("4. 全部执行")
        print("0. 退出")
        
        choice = input("\n请输入选择 (0-4): ").strip()
        
        if choice == '0':
            print("👋 再见！")
            break
        elif choice == '1':
            init_realtime_database()
        elif choice == '2':
            create_sample_data()
        elif choice == '3':
            check_database_status()
        elif choice == '4':
            print("执行全部操作...")
            if init_realtime_database():
                create_sample_data()
                check_database_status()
        else:
            print("❌ 无效选择，请重新输入")

if __name__ == '__main__':
    main() 