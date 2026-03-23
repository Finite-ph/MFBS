-- 多因子量化投资分析系统数据库表结构
-- 数据库名: stock_cursor
-- 字符集: utf8mb4

-- ----------------------------
-- 1. 股票基础信息表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_basic` (
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `symbol` VARCHAR(20) DEFAULT NULL COMMENT '交易代码',
  `name` VARCHAR(100) DEFAULT NULL COMMENT '股票名称',
  `area` VARCHAR(50) DEFAULT NULL COMMENT '地域',
  `industry` VARCHAR(50) DEFAULT NULL COMMENT '所属行业',
  `market` VARCHAR(50) DEFAULT NULL COMMENT '市场类型',
  `list_date` VARCHAR(20) DEFAULT NULL COMMENT '上市日期',
  `is_hs` VARCHAR(10) DEFAULT NULL COMMENT '是否沪深港通',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ts_code`),
  KEY `idx_market` (`market`),
  KEY `idx_industry` (`industry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='股票基础信息表';

-- ----------------------------
-- 2. 日线行情数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_daily_history` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `open` DECIMAL(10,2) DEFAULT NULL COMMENT '开盘价',
  `high` DECIMAL(10,2) DEFAULT NULL COMMENT '最高价',
  `low` DECIMAL(10,2) DEFAULT NULL COMMENT '最低价',
  `close` DECIMAL(10,2) DEFAULT NULL COMMENT '收盘价',
  `pre_close` DECIMAL(10,2) DEFAULT NULL COMMENT '前收盘价',
  `vol` BIGINT DEFAULT NULL COMMENT '成交量(手)',
  `amount` DECIMAL(20,2) DEFAULT NULL COMMENT '成交额(千元)',
  `pct_chg` DECIMAL(10,4) DEFAULT NULL COMMENT '涨跌幅(%)',
  `float_share` BIGINT DEFAULT NULL COMMENT '流通股本(万股)',
  `total_share` BIGINT DEFAULT NULL COMMENT '总股本(万股)',
  `total_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '总市值(万元)',
  `float_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '流通市值(万元)',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date` (`ts_code`, `trade_date`),
  KEY `idx_trade_date` (`trade_date`),
  KEY `idx_ts_code` (`ts_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日线行情数据表';

-- ----------------------------
-- 3. 日线基本数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_daily_basic` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `close` DECIMAL(10,2) DEFAULT NULL COMMENT '收盘价',
  `turnover_rate` DECIMAL(10,4) DEFAULT NULL COMMENT '换手率(%)',
  `turnover_rate_f` DECIMAL(10,4) DEFAULT NULL COMMENT '换手率(自由流通)(%)',
  `pe` DECIMAL(10,4) DEFAULT NULL COMMENT '市盈率(总市值)',
  `pe_ttm` DECIMAL(10,4) DEFAULT NULL COMMENT '市盈率(TTM)',
  `pb` DECIMAL(10,4) DEFAULT NULL COMMENT '市净率(MRQ)',
  `ps` DECIMAL(10,4) DEFAULT NULL COMMENT '市销率(TTM)',
  `ps_ttm` DECIMAL(10,4) DEFAULT NULL COMMENT '市销率(TTM)',
  `total_share` BIGINT DEFAULT NULL COMMENT '总股本(万股)',
  `float_share` BIGINT DEFAULT NULL COMMENT '流通股本(万股)',
  `free_share` BIGINT DEFAULT NULL COMMENT '自由流通股本(万股)',
  `total_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '总市值(万元)',
  `float_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '流通市值(万元)',
  `net_profit_ttm` DECIMAL(20,2) DEFAULT NULL COMMENT '净利润TTM(万元)',
  `revenue_ttm` DECIMAL(20,2) DEFAULT NULL COMMENT '营业收入TTM(万元)',
  `operate_income_ttm` DECIMAL(20,2) DEFAULT NULL COMMENT '经营活动现金净流量TTM(万元)',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date` (`ts_code`, `trade_date`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日线基本数据表';

-- ----------------------------
-- 4. 技术因子数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_factor` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `close` DECIMAL(10,2) DEFAULT NULL COMMENT '收盘价',
  `pe` DECIMAL(10,4) DEFAULT NULL COMMENT '市盈率',
  `pb` DECIMAL(10,4) DEFAULT NULL COMMENT '市净率',
  `ps` DECIMAL(10,4) DEFAULT NULL COMMENT '市销率',
  `ps_ttm` DECIMAL(10,4) DEFAULT NULL COMMENT '市销率TTM',
  `total_share` BIGINT DEFAULT NULL COMMENT '总股本(万股)',
  `float_share` BIGINT DEFAULT NULL COMMENT '流通股本(万股)',
  `free_share` BIGINT DEFAULT NULL COMMENT '自由流通股本(万股)',
  `total_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '总市值(万元)',
  `float_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '流通市值(万元)',
  `net_profit_ttm` DECIMAL(20,2) DEFAULT NULL COMMENT '净利润TTM(万元)',
  `revenue_ttm` DECIMAL(20,2) DEFAULT NULL COMMENT '营业收入TTM(万元)',
  `turnover_rate` DECIMAL(10,4) DEFAULT NULL COMMENT '换手率',
  `turnover_rate_f` DECIMAL(10,4) DEFAULT NULL COMMENT '换手率(自由流通)',
  `pct_chg` DECIMAL(10,4) DEFAULT NULL COMMENT '涨跌幅',
  `vol` BIGINT DEFAULT NULL COMMENT '成交量',
  `amount` DECIMAL(20,2) DEFAULT NULL COMMENT '成交额',
  `macd` DECIMAL(10,4) DEFAULT NULL COMMENT 'MACD',
  `macd_dif` DECIMAL(10,4) DEFAULT NULL COMMENT 'MACD_DIF',
  `macd_dea` DECIMAL(10,4) DEFAULT NULL COMMENT 'MACD_DEA',
  `kdj_k` DECIMAL(10,4) DEFAULT NULL COMMENT 'KDJ_K',
  `kdj_d` DECIMAL(10,4) DEFAULT NULL COMMENT 'KDJ_D',
  `kdj_j` DECIMAL(10,4) DEFAULT NULL COMMENT 'KDJ_J',
  `rsi_6` DECIMAL(10,4) DEFAULT NULL COMMENT 'RSI6',
  `rsi_12` DECIMAL(10,4) DEFAULT NULL COMMENT 'RSI12',
  `rsi_24` DECIMAL(10,4) DEFAULT NULL COMMENT 'RSI24',
  `boll_upper` DECIMAL(10,2) DEFAULT NULL COMMENT '布林带上轨',
  `boll_mid` DECIMAL(10,2) DEFAULT NULL COMMENT '布林带中轨',
  `boll_lower` DECIMAL(10,2) DEFAULT NULL COMMENT '布林带下轨',
  `ma5` DECIMAL(10,2) DEFAULT NULL COMMENT '5日均线',
  `ma10` DECIMAL(10,2) DEFAULT NULL COMMENT '10日均线',
  `ma20` DECIMAL(10,2) DEFAULT NULL COMMENT '20日均线',
  `ma30` DECIMAL(10,2) DEFAULT NULL COMMENT '30日均线',
  `ma60` DECIMAL(10,2) DEFAULT NULL COMMENT '60日均线',
  `vol_ratio` DECIMAL(10,4) DEFAULT NULL COMMENT '量比',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date` (`ts_code`, `trade_date`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='技术因子数据表';

-- ----------------------------
-- 5. 均线数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_ma_data` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `ma_type` VARCHAR(10) NOT NULL COMMENT '均线类型',
  `ma_period` INT DEFAULT NULL COMMENT '周期',
  `ma_value` DECIMAL(10,2) DEFAULT NULL COMMENT '均线值',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date_type` (`ts_code`, `trade_date`, `ma_type`, `ma_period`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='均线数据表';

-- ----------------------------
-- 6. 资金流向数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_moneyflow` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `buy_sm_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '小单买入金额(万元)',
  `buy_sm_vol` BIGINT DEFAULT NULL COMMENT '小单买入量(手)',
  `buy_md_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '中单买入金额(万元)',
  `buy_md_vol` BIGINT DEFAULT NULL COMMENT '中单买入量(手)',
  `buy_lg_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '大单买入金额(万元)',
  `buy_lg_vol` BIGINT DEFAULT NULL COMMENT '大单买入量(手)',
  `buy_elg_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '特大单买入金额(万元)',
  `buy_elg_vol` BIGINT DEFAULT NULL COMMENT '特大单买入量(手)',
  `sell_sm_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '小单卖出金额(万元)',
  `sell_sm_vol` BIGINT DEFAULT NULL COMMENT '小单卖出量(手)',
  `sell_md_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '中单卖出金额(万元)',
  `sell_md_vol` BIGINT DEFAULT NULL COMMENT '中单卖出量(手)',
  `sell_lg_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '大单卖出金额(万元)',
  `sell_lg_vol` BIGINT DEFAULT NULL COMMENT '大单卖出量(手)',
  `sell_elg_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '特大单卖出金额(万元)',
  `sell_elg_vol` BIGINT DEFAULT NULL COMMENT '特大单卖出量(手)',
  `net_mf_amount` DECIMAL(20,2) DEFAULT NULL COMMENT '净流入金额(万元)',
  `net_mf_vol` BIGINT DEFAULT NULL COMMENT '净流入量(手)',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date` (`ts_code`, `trade_date`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资金流向数据表';

-- ----------------------------
-- 7. 筹码分布数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_cyq_perf` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `cost_5pct` DECIMAL(10,2) DEFAULT NULL COMMENT '5%筹码价位',
  `cost_95pct` DECIMAL(10,2) DEFAULT NULL COMMENT '95%筹码价位',
  `cost_50pct` DECIMAL(10,2) DEFAULT NULL COMMENT '50%筹码价位',
  `chip_concentration` DECIMAL(10,4) DEFAULT NULL COMMENT '筹码集中度',
  `winner_rate` DECIMAL(10,4) DEFAULT NULL COMMENT '胜率',
  `avg_cost` DECIMAL(10,2) DEFAULT NULL COMMENT '平均成本',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date` (`ts_code`, `trade_date`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='筹码分布数据表';

-- ----------------------------
-- 8. 股票业务数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_business` (
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `stock_name` VARCHAR(100) DEFAULT NULL COMMENT '股票名称',
  `daily_close` DECIMAL(10,2) DEFAULT NULL COMMENT '收盘价',
  `factor_pct_change` DECIMAL(10,4) DEFAULT NULL COMMENT '涨跌幅(%)',
  `vol` BIGINT DEFAULT NULL COMMENT '成交量(手)',
  `amount` DECIMAL(20,2) DEFAULT NULL COMMENT '成交额(万元)',
  `pe_ttm` DECIMAL(10,4) DEFAULT NULL COMMENT '市盈率TTM',
  `pb` DECIMAL(10,4) DEFAULT NULL COMMENT '市净率',
  `ps_ttm` DECIMAL(10,4) DEFAULT NULL COMMENT '市销率TTM',
  `pcf_ncf_ttm` DECIMAL(10,4) DEFAULT NULL COMMENT '市现率TTM',
  `total_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '总市值(万元)',
  `circ_mv` DECIMAL(20,2) DEFAULT NULL COMMENT '流通市值(万元)',
  `trade_date` VARCHAR(20) DEFAULT NULL COMMENT '交易日期',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ts_code`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='股票业务数据表';

-- ----------------------------
-- 9. 因子定义表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `factor_definition` (
  `factor_id` VARCHAR(50) NOT NULL COMMENT '因子ID',
  `factor_name` VARCHAR(100) NOT NULL COMMENT '因子名称',
  `factor_type` VARCHAR(20) DEFAULT NULL COMMENT '因子类型',
  `factor_formula` TEXT DEFAULT NULL COMMENT '因子公式',
  `description` TEXT DEFAULT NULL COMMENT '因子描述',
  `params` JSON DEFAULT NULL COMMENT '因子参数',
  `is_active` TINYINT(1) DEFAULT 1 COMMENT '是否启用',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`factor_id`),
  KEY `idx_factor_type` (`factor_type`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='因子定义表';

-- ----------------------------
-- 10. 因子值数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `factor_values` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `factor_id` VARCHAR(50) NOT NULL COMMENT '因子ID',
  `factor_value` DECIMAL(20,6) DEFAULT NULL COMMENT '因子值',
  `z_score` DECIMAL(20,6) DEFAULT NULL COMMENT 'Z-Score标准化值',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date_factor` (`ts_code`, `trade_date`, `factor_id`),
  KEY `idx_trade_date` (`trade_date`),
  KEY `idx_factor_id` (`factor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='因子值数据表';

-- ----------------------------
-- 11. 机器学习模型定义表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `ml_model_definition` (
  `model_id` VARCHAR(50) NOT NULL COMMENT '模型ID',
  `model_name` VARCHAR(100) NOT NULL COMMENT '模型名称',
  `model_type` VARCHAR(30) NOT NULL COMMENT '模型类型',
  `factor_list` JSON DEFAULT NULL COMMENT '使用的因子列表',
  `target_type` VARCHAR(20) NOT NULL COMMENT '预测目标类型',
  `model_params` JSON DEFAULT NULL COMMENT '模型参数',
  `training_config` JSON DEFAULT NULL COMMENT '训练配置',
  `is_active` TINYINT(1) DEFAULT 1 COMMENT '是否启用',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`model_id`),
  KEY `idx_model_type` (`model_type`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='机器学习模型定义表';

-- ----------------------------
-- 12. 机器学习预测结果表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `ml_predictions` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `model_id` VARCHAR(50) NOT NULL COMMENT '模型ID',
  `predicted_return` DECIMAL(10,6) DEFAULT NULL COMMENT '预测收益率',
  `probability_score` DECIMAL(10,6) DEFAULT NULL COMMENT '概率分数',
  `rank_score` INT DEFAULT NULL COMMENT '排名分数',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date_model` (`ts_code`, `trade_date`, `model_id`),
  KEY `idx_trade_date` (`trade_date`),
  KEY `idx_model_id` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='机器学习预测结果表';

-- ----------------------------
-- 13. 利润表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_income_statement` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `ann_date` VARCHAR(20) DEFAULT NULL COMMENT '公告日期',
  `end_date` VARCHAR(20) DEFAULT NULL COMMENT '报告期末',
  `report_type` VARCHAR(10) DEFAULT NULL COMMENT '报告类型',
  `revenue` DECIMAL(20,2) DEFAULT NULL COMMENT '营业收入(万元)',
  `revenue_ttm` DECIMAL(20,2) DEFAULT NULL COMMENT '营业收入TTM(万元)',
  `operate_income` DECIMAL(20,2) DEFAULT NULL COMMENT '营业利润(万元)',
  `n_income` DECIMAL(20,2) DEFAULT NULL COMMENT '净利润(万元)',
  `n_income_attr_p` DECIMAL(20,2) DEFAULT NULL COMMENT '归属于母公司净利润(万元)',
  `total_hldr_eqy_exc_min_int` DECIMAL(20,2) DEFAULT NULL COMMENT '母公司股东权益(万元)',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ts_code` (`ts_code`),
  KEY `idx_end_date` (`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='利润表';

-- ----------------------------
-- 14. 资产负债表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_balance_sheet` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `ann_date` VARCHAR(20) DEFAULT NULL COMMENT '公告日期',
  `end_date` VARCHAR(20) DEFAULT NULL COMMENT '报告期末',
  `report_type` VARCHAR(10) DEFAULT NULL COMMENT '报告类型',
  `total_assets` DECIMAL(20,2) DEFAULT NULL COMMENT '资产总计(万元)',
  `total_liab` DECIMAL(20,2) DEFAULT NULL COMMENT '负债合计(万元)',
  `total_cur_assets` DECIMAL(20,2) DEFAULT NULL COMMENT '流动资产合计(万元)',
  `total_cur_liab` DECIMAL(20,2) DEFAULT NULL COMMENT '流动负债合计(万元)',
  `total_hldr_eqy_exc_min_int` DECIMAL(20,2) DEFAULT NULL COMMENT '母公司股东权益(万元)',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ts_code` (`ts_code`),
  KEY `idx_end_date` (`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产负债表';

-- ----------------------------
-- 15. 分钟级数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `stock_minute_data` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `datetime` DATETIME NOT NULL COMMENT '日期时间',
  `period_type` VARCHAR(10) NOT NULL COMMENT '周期类型',
  `open` DECIMAL(10,2) DEFAULT NULL COMMENT '开盘价',
  `high` DECIMAL(10,2) DEFAULT NULL COMMENT '最高价',
  `low` DECIMAL(10,2) DEFAULT NULL COMMENT '最低价',
  `close` DECIMAL(10,2) DEFAULT NULL COMMENT '收盘价',
  `vol` BIGINT DEFAULT NULL COMMENT '成交量',
  `amount` DECIMAL(20,2) DEFAULT NULL COMMENT '成交额',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_datetime_period` (`ts_code`, `datetime`, `period_type`),
  KEY `idx_datetime` (`datetime`),
  KEY `idx_period_type` (`period_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分钟级数据表';

-- ----------------------------
-- 16. 实时指标数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `realtime_indicators` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `indicator_type` VARCHAR(50) NOT NULL COMMENT '指标类型',
  `indicator_value` DECIMAL(20,6) DEFAULT NULL COMMENT '指标值',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_date_type` (`ts_code`, `trade_date`, `indicator_type`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实时指标数据表';

-- ----------------------------
-- 17. 实时报告数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `realtime_report` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `report_type` VARCHAR(50) NOT NULL COMMENT '报告类型',
  `report_date` VARCHAR(20) NOT NULL COMMENT '报告日期',
  `content` TEXT DEFAULT NULL COMMENT '报告内容',
  `summary` TEXT DEFAULT NULL COMMENT '报告摘要',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ts_code` (`ts_code`),
  KEY `idx_report_date` (`report_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实时报告数据表';

-- ----------------------------
-- 18. 交易信号数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `trading_signals` (
  `id` BIGINT AUTO_INCREMENT,
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `signal_type` VARCHAR(50) NOT NULL COMMENT '信号类型',
  `signal_value` VARCHAR(20) NOT NULL COMMENT '信号值',
  `signal_strength` DECIMAL(10,4) DEFAULT NULL COMMENT '信号强度',
  `trade_date` VARCHAR(20) NOT NULL COMMENT '交易日期',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ts_code` (`ts_code`),
  KEY `idx_trade_date` (`trade_date`),
  KEY `idx_signal_type` (`signal_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易信号数据表';

-- ----------------------------
-- 19. 组合持仓数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `portfolio_position` (
  `id` BIGINT AUTO_INCREMENT,
  `portfolio_id` VARCHAR(50) NOT NULL COMMENT '组合ID',
  `ts_code` VARCHAR(20) NOT NULL COMMENT '股票代码',
  `hold_date` VARCHAR(20) NOT NULL COMMENT '持仓日期',
  `shares` INT DEFAULT NULL COMMENT '持仓数量',
  `avg_cost` DECIMAL(10,2) DEFAULT NULL COMMENT '平均成本',
  `close_price` DECIMAL(10,2) DEFAULT NULL COMMENT '收盘价',
  `market_value` DECIMAL(20,2) DEFAULT NULL COMMENT '市值',
  `profit_loss` DECIMAL(20,2) DEFAULT NULL COMMENT '盈亏金额',
  `profit_rate` DECIMAL(10,4) DEFAULT NULL COMMENT '盈亏比例',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_portfolio_code_date` (`portfolio_id`, `ts_code`, `hold_date`),
  KEY `idx_hold_date` (`hold_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='组合持仓数据表';

-- ----------------------------
-- 20. 风险预警数据表
-- ----------------------------
CREATE TABLE IF NOT EXISTS `risk_alert` (
  `id` BIGINT AUTO_INCREMENT,
  `portfolio_id` VARCHAR(50) NOT NULL COMMENT '组合ID',
  `alert_type` VARCHAR(50) NOT NULL COMMENT '预警类型',
  `alert_level` VARCHAR(20) NOT NULL COMMENT '预警级别',
  `alert_message` TEXT DEFAULT NULL COMMENT '预警消息',
  `alert_date` VARCHAR(20) NOT NULL COMMENT '预警日期',
  `is_handled` TINYINT(1) DEFAULT 0 COMMENT '是否已处理',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_portfolio_id` (`portfolio_id`),
  KEY `idx_alert_date` (`alert_date`),
  KEY `idx_is_handled` (`is_handled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='风险预警数据表';

-- ----------------------------
-- 21. Text2SQL元数据表 - 表信息
-- ----------------------------
CREATE TABLE IF NOT EXISTS `table_metadata` (
  `table_name` VARCHAR(100) NOT NULL COMMENT '表名',
  `table_alias` VARCHAR(100) DEFAULT NULL COMMENT '表别名',
  `description` TEXT DEFAULT NULL COMMENT '表描述',
  `business_domain` VARCHAR(50) DEFAULT NULL COMMENT '业务领域',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Text2SQL表元数据';

-- ----------------------------
-- 22. Text2SQL元数据表 - 字段信息
-- ----------------------------
CREATE TABLE IF NOT EXISTS `field_metadata` (
  `id` BIGINT AUTO_INCREMENT,
  `table_name` VARCHAR(100) NOT NULL COMMENT '表名',
  `field_name` VARCHAR(100) NOT NULL COMMENT '字段名',
  `field_alias` VARCHAR(100) DEFAULT NULL COMMENT '字段别名',
  `field_type` VARCHAR(50) DEFAULT NULL COMMENT '字段类型',
  `description` TEXT DEFAULT NULL COMMENT '字段描述',
  `business_meaning` TEXT DEFAULT NULL COMMENT '业务含义',
  `synonyms` JSON DEFAULT NULL COMMENT '同义词列表',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_table_field` (`table_name`, `field_name`),
  KEY `idx_table_name` (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Text2SQL字段元数据';

-- ----------------------------
-- 23. Text2SQL元数据表 - 查询模板
-- ----------------------------
CREATE TABLE IF NOT EXISTS `query_template` (
  `template_id` VARCHAR(50) NOT NULL COMMENT '模板ID',
  `template_name` VARCHAR(100) NOT NULL COMMENT '模板名称',
  `intent_pattern` TEXT DEFAULT NULL COMMENT '意图匹配模式',
  `sql_template` TEXT DEFAULT NULL COMMENT 'SQL模板',
  `parameters` JSON DEFAULT NULL COMMENT '参数列表',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Text2SQL查询模板';

-- ----------------------------
-- 24. Text2SQL元数据表 - 查询历史
-- ----------------------------
CREATE TABLE IF NOT EXISTS `query_history` (
  `id` BIGINT AUTO_INCREMENT,
  `query_text` TEXT DEFAULT NULL COMMENT '查询文本',
  `generated_sql` TEXT DEFAULT NULL COMMENT '生成的SQL',
  `result_count` INT DEFAULT NULL COMMENT '结果数量',
  `is_success` TINYINT(1) DEFAULT 1 COMMENT '是否成功',
  `error_message` TEXT DEFAULT NULL COMMENT '错误信息',
  `query_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_query_time` (`query_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Text2SQL查询历史';

-- ----------------------------
-- 25. Text2SQL元数据表 - 业务词典
-- ----------------------------
CREATE TABLE IF NOT EXISTS `business_dictionary` (
  `id` BIGINT AUTO_INCREMENT,
  `category` VARCHAR(50) NOT NULL COMMENT '分类',
  `standard_term` VARCHAR(100) NOT NULL COMMENT '标准术语',
  `synonyms` JSON DEFAULT NULL COMMENT '同义词列表',
  `description` TEXT DEFAULT NULL COMMENT '描述',
  `mapping_field` VARCHAR(100) DEFAULT NULL COMMENT '映射字段',
  `mapping_table` VARCHAR(100) DEFAULT NULL COMMENT '映射表',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_category_term` (`category`, `standard_term`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Text2SQL业务词典';
