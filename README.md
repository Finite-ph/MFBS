# 多因子量化投资分析系统

一个功能完整的量化投资分析平台，集成了因子计算、机器学习建模、股票筛选、组合优化、回测验证和实时市场分析等功能。

## 功能完成情况

### ✅ 已完成且可用的功能

| 模块 | 功能 | 状态 |
|------|------|------|
| **单股票回测** | MA交叉、MACD、KDJ、RSI、布林带策略 | ✅ 可用 |
| **Text2SQL** | 自然语言转SQL查询股票 | ✅ 可用 |
| **数据库** | 基础数据模型和存储 | ✅ 可用 |

### ⚠️ 框架完成但需初始化/配置

| 模块 | 功能 | 状态 |
|------|------|------|
| **因子管理** | 框架完成，需运行初始化 | 内置因子定义已写好，需初始化创建 |
| **ML模型** | 框架完成，需运行初始化 | 模型定义已写好，需初始化创建演示模型 |
| **多因子回测** | 框架完成，需数据支持 | 需因子数据、股票数据 |
| **股票评分** | 框架完成，需数据支持 | 需因子数据 |
| **组合优化** | 框架完成，需数据支持 | 需持仓数据 |
| **实时行情** | 框架完成 | 需配置 Tushare/Baostock API |
| **实时指标** | 框架完成 | 需数据同步服务 |
| **交易信号** | 框架完成 | 需历史数据支持 |
| **风险预警** | 框架完成 | 需持仓数据 |
| **WebSocket推送** | 框架完成 | 可用但无数据源 |

### ❌ 未完成的功能（仅有框架/TODO）

| 功能 | 位置 | 说明 |
|------|------|------|
| 自定义因子公式解析 | `factor_engine.py` | TODO: 实现自定义因子公式解析和计算 |
| 因子中性优化 | `portfolio_optimizer.py` | TODO: 实现因子中性优化 |
| Black-Litterman模型 | `portfolio_optimizer.py` | TODO: 实现Black-Litterman模型 |
| 行业约束优化 | `portfolio_optimizer.py` | TODO: 实现行业约束 |
| ML集成评分 | `stock_scoring.py` | TODO: 实现基于多个ML模型的集成评分 |
| 动态权重评分 | `stock_scoring.py` | TODO: 实现基于历史Rank IC的动态权重评分 |
| 基准指数对比 | `backtest_engine.py` | 返回空列表，未实现 |

### 🔧 初始化步骤

部分功能需要运行初始化才能使用：

```bash
# 使用系统管理器初始化数据库（创建因子和演示ML模型）
python run_system.py
# 选择 2. 初始化数据库
```

初始化后会创建：
- 12个内置因子定义
- 3个演示ML模型（随机森林、XGBoost、LightGBM）

## 技术架构

| 层级 | 技术 |
|------|------|
| 后端 | Python 3.8+ / Flask / SQLAlchemy |
| 数据处理 | Pandas / NumPy / Scikit-learn |
| 机器学习 | XGBoost / LightGBM |
| 前端 | Bootstrap 5 / ECharts / JavaScript |
| 数据库 | MySQL |
| 实时通信 | WebSocket / SocketIO |

## 快速开始

### 环境要求

- Python 3.8+
- MySQL 5.7+

### 安装依赖

```bash
pip install -r requirements.txt
```

### 配置数据源

在 `.env` 文件中配置：

```env
# 数据库配置
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=stock_cursor

# Tushare API Token（可选，用于获取实时数据）
TUSHARE_TOKEN=your_token_here
```

### 启动系统

```bash
# 方式1: 使用系统管理器
python run_system.py

# 方式2: 直接运行
python run.py
```

### 访问地址

- Web界面: http://localhost:5001
- 多因子系统: http://localhost:5001/ml-factor/
- 实时分析: http://localhost:5001/realtime-analysis/

## 系统模块

### 1. 多因子模型系统 (`/ml-factor/`)

| 模块 | 功能 |
|------|------|
| 因子管理 | 内置因子查看、自定义因子创建、因子计算 |
| 模型管理 | 创建/训练/预测ML模型 |
| 股票评分 | 因子评分、ML评分，综合排名 |
| 组合管理 | 组合优化、再平衡、综合选股 |
| 回测验证 | 策略回测、绩效评估 |

### 2. 策略回测 (`/backtest/`)

支持的策略：
- **MA交叉** - 短期均线上穿/下穿长期均线
- **MACD** - MACD金叉/死叉
- **KDJ** - KDJ超买超卖
- **RSI** - RSI超买超卖
- **布林带** - 价格触及布林带上下轨

### 3. 实时分析系统 (`/realtime-analysis/`)

| 模块 | 功能 |
|------|------|
| 数据管理 | 分钟级数据同步、多周期聚合、数据质量监控 |
| 技术指标 | MA、EMA、MACD、RSI、KDJ、BOLL等指标 |
| 交易信号 | 策略信号生成、信号融合 |
| 实时监控 | 行情监控、板块轮动 |
| 风险管理 | VaR/CVaR、止损止盈、风险预警 |
| WebSocket管理 | 实时推送服务管理 |

### 4. Text2SQL查询系统

支持自然语言查询数据库：
- 股票筛选（价格、涨跌幅、成交量等）
- 技术指标分析（MACD金叉、RSI超买等）
- 基本面筛选（市盈率、市净率等）
- 资金流向分析

## API接口

### 股票数据

```python
# 获取股票列表
GET /api/stocks

# 股票详情
GET /api/stocks/{ts_code}
```

### 多因子API

```python
# 因子列表
GET /api/ml-factor/factors/list

# 创建因子
POST /api/ml-factor/factors/custom

# 计算因子
POST /api/ml-factor/factors/calculate

# 模型列表
GET /api/ml-factor/models/list

# 创建模型
POST /api/ml-factor/models/create

# 训练模型
POST /api/ml-factor/models/train

# 股票评分
POST /api/ml-factor/scoring/factor-based
```

### 回测API

```python
# 单股票策略回测
POST /api/analysis/backtest
{
    "ts_code": "000001.SZ",
    "strategy_type": "ma_cross",
    "start_date": "2025-01-01",
    "end_date": "2026-01-01",
    "initial_capital": 100000,
    "params": {"ma_short": 5, "ma_long": 20}
}

# 多因子组合回测
POST /api/ml-factor/backtest/run
{
    "strategy_config": {
        "selection_method": "factor_based",
        "factor_list": ["momentum_5d", "volatility_20d"],
        "top_n": 50,
        "optimization": {"method": "equal_weight"}
    },
    "start_date": "2025-01-01",
    "end_date": "2026-01-01",
    "initial_capital": 1000000,
    "rebalance_frequency": "monthly"
}
```

## 内置因子

### 技术面因子 (4个)
- `momentum_1d/5d/20d` - 价格动量
- `volatility_20d` - 波动率
- `rsi_14` - RSI指标
- `turnover_rate` - 换手率

### 基本面因子 (6个)
- `pe_ratio` - 市盈率
- `pb_ratio` - 市净率
- `roe` - 净资产收益率
- `debt_ratio` - 资产负债率
- `current_ratio` - 流动比率
- `gross_margin` - 毛利率

## 目录结构

```
quantitative_analysis/
├── app/
│   ├── __init__.py          # Flask应用工厂
│   ├── extensions.py         # 扩展初始化
│   ├── api/                 # REST API接口
│   ├── models/              # 数据模型
│   ├── services/            # 业务逻辑
│   ├── routes/              # 页面路由
│   ├── main/                # 主页蓝图
│   ├── websocket/           # WebSocket服务
│   ├── utils/               # 工具函数
│   └── templates/           # HTML模板
├── init/                    # 数据库初始化脚本
├── docs/                   # 开发文档
├── config.py               # 配置文件
├── requirements.txt        # 依赖列表
├── run.py                  # 应用入口
└── run_system.py           # 系统管理器
```

## 回测指标

系统支持的回测性能指标：
- 总收益率、年化收益率
- 夏普比率、卡尔玛比率
- 最大回撤、胜率
- 波动率

## 数据要求

### 必要数据表
- `stock_basic` - 股票基本信息
- `stock_daily_history` - 日线行情
- `stock_factor` - 技术指标
- `stock_moneyflow` - 资金流向

### 可选数据表
- `stock_income_statement` - 利润表
- `stock_balance_sheet` - 资产负债表
- `stock_cash_flow` - 现金流量表

## 配置说明

### 数据库配置 (.env)

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=stock_cursor
DB_CHARSET=utf8mb4
```

### Redis配置

```env
REDIS_HOST=localhost
REDIS_PORT=6379
```

### Tushare配置

```env
TUSHARE_TOKEN=your_token_here
```

## 常见问题

### 1. 依赖包安装失败

```bash
# 使用国内镜像
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/
```

### 2. TA-Lib安装失败

系统已移除TA-Lib依赖，使用纯pandas实现技术指标。

### 3. 数据库连接失败

检查MySQL服务是否启动，以及`.env`配置是否正确。

### 4. 回测没有数据

需要先导入股票历史数据到数据库，才能进行回测。

## 开发指南

### 添加自定义策略

在 `app/api/analysis_api.py` 的 `BacktestEngine` 类中添加新策略：

```python
# 1. 在 _calculate_signals 方法中添加策略分支
elif self.strategy_type == '你的策略名':
    df = self._你的策略名_strategy(df)

# 2. 实现策略方法
def _你的策略名_strategy(self, df):
    # 你的策略逻辑
    return df
```

### 扩展ML模型

在 `app/services/ml_models.py` 中添加新算法支持。

## 许可证

MIT License

## 系统截图

### 多因子系统
![多因子系统](docs/images/screenshot1.png)

### 策略回测
![策略回测](docs/images/screenshot2.png)

### 实时分析
![实时分析](docs/images/screenshot3.png)


