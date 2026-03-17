
# 视频解析项目搭建说明

## 环境要求
- 操作系统：Windows / Linux
- Python 版本：3.8+
- 推荐使用 Python 虚拟环境 (venv)

## 快速开始

### 1. 解压文件
将 `deploy_package.zip` 解压到目标目录，例如 `C:\Users\YourName\Documents\VideoParse`。

### 2. 安装依赖
打开命令行（CMD 或 PowerShell），进入项目目录，运行以下命令安装必要的 Python 库：
```bash
pip install -r requirements.txt
```

### 3. 启动服务
运行以下命令启动服务：
```bash
python main.py
```
或者指定端口（如果默认端口 12304 被占用）：
```bash
uvicorn main:app --reload --port 12304 --host 127.0.0.1
```

### 4. 访问测试
在浏览器中访问 `http://127.0.0.1:12304/` 即可看到解析页面。

## 宝塔面板配置说明

### 1. 部署 Python 项目
建议使用宝塔面板的 "Python项目管理器" 插件，或者手动通过 SSH 运行上述启动命令。

### 2. 反向代理配置
在宝塔面板 -> 网站 -> 设置 -> 反向代理 -> 添加反向代理：
- 代理名称：`parse-video` (自定义)
- 目标URL：`http://127.0.0.1:12304`
- 发送域名：`$host`

或者在 Nginx 配置文件中添加如下 location 块（支持相对路径访问，如 `/jiexi/`）：

```nginx
location /jiexi/ {
    proxy_pass http://127.0.0.1:12304/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

### 注意事项
- 确保服务器防火墙已放行对应端口（如果是直接访问）。
- 如果使用相对路径访问（如 `/jiexi/`），请确保 `proxy_pass` 末尾带有 `/`。
