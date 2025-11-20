# 管理系统

基于 Spring Boot + Vue3 + Element Plus 的前后端分离管理系统

## 技术栈

### 后端
- Spring Boot 2.7.14
- MyBatis Plus 3.5.3.1
- MySQL 5.7
- Lombok
- Hutool
- JWT

### 前端
- Vue 3.3.4
- Element Plus 2.3.14
- Vue Router 4.2.4
- Pinia 2.1.6
- Axios 1.5.0
- Vite 4.4.9

## 项目结构

```
SpringBoot_Vue3_Eelement/
├── backend/                    # 后端项目
│   ├── src/
│   │   └── main/
│   │       ├── java/
│   │       │   └── com/
│   │       │       └── example/
│   │       │           ├── ManagementSystemApplication.java  # 启动类
│   │       │           ├── common/                          # 公共类
│   │       │           │   └── Result.java                  # 统一返回结果
│   │       │           ├── config/                          # 配置类
│   │       │           │   └── CorsConfig.java              # 跨域配置
│   │       │           ├── controller/                      # 控制器
│   │       │           │   └── TestController.java          # 测试控制器
│   │       │           └── exception/                       # 异常处理
│   │       │               ├── GlobalExceptionHandler.java  # 全局异常处理
│   │       │               └── ServiceException.java        # 业务异常
│   │       └── resources/
│   │           └── application.yml                          # 配置文件
│   └── pom.xml                                              # Maven配置
│
├── frontend/                   # 前端项目
│   ├── src/
│   │   ├── views/              # 页面
│   │   │   ├── Layout.vue      # 布局页面
│   │   │   ├── Home.vue        # 首页
│   │   │   └── Login.vue       # 登录页
│   │   ├── router/             # 路由
│   │   │   └── index.js
│   │   ├── utils/              # 工具类
│   │   │   └── request.js      # axios封装
│   │   ├── App.vue             # 根组件
│   │   └── main.js             # 入口文件
│   ├── index.html
│   ├── vite.config.js          # Vite配置
│   └── package.json            # 依赖配置
│
└── README.md                   # 项目说明
```

## 环境要求

- JDK 1.8+
- Maven 3.6+
- Node.js 16+
- MySQL 5.7

## 快速开始

### 1. 数据库配置

创建数据库：
```sql
CREATE DATABASE SpringBoot_Vue3 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

修改后端配置文件 `backend/src/main/resources/application.yml`：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/SpringBoot_Vue3?useUnicode=true&characterEncoding=utf-8&useSSL=false
    username: root      # 修改为你的数据库用户名
    password: root      # 修改为你的数据库密码
```

### 2. 启动后端

```bash
cd backend
mvn clean install
mvn spring-boot:run
```

后端服务将在 http://localhost:8080 启动

### 3. 启动前端

```bash
cd frontend
npm install
npm run dev
```

前端服务将在 http://localhost:3000 启动

## 功能特性

### 已实现
- ✅ 项目基础架构搭建
- ✅ 前后端分离
- ✅ 统一返回结果封装
- ✅ 全局异常处理
- ✅ 跨域配置
- ✅ Axios请求封装
- ✅ 路由配置
- ✅ 登录页面（前端模拟）
- ✅ 后台布局框架
- ✅ 首页数据展示

### 待开发
- ⬜ 用户管理
- ⬜ 角色管理
- ⬜ 权限管理
- ⬜ JWT认证
- ⬜ 菜单管理
- ⬜ 日志管理

## 接口文档

### 测试接口
- **GET** `/api/test/hello`
  - 描述：测试接口
  - 返回：`{ "code": 200, "message": "操作成功", "data": "Hello, Management System!" }`

## 开发说明

### 后端开发规范
1. 所有接口返回使用 `Result` 统一封装
2. 业务异常使用 `ServiceException` 抛出
3. 使用 MyBatis Plus 简化数据库操作
4. 遵循 RESTful API 设计规范

### 前端开发规范
1. 使用 Composition API 编写组件
2. 统一使用 `request.js` 发送请求
3. 路由懒加载提升性能
4. 使用 Element Plus 组件库

## 常见问题

### 1. 后端启动失败
- 检查 JDK 版本是否为 1.8+
- 检查 MySQL 服务是否启动
- 检查数据库连接配置是否正确

### 2. 前端启动失败
- 检查 Node.js 版本是否为 16+
- 删除 `node_modules` 重新安装依赖
- 检查端口 3000 是否被占用

### 3. 接口调用失败
- 检查后端服务是否正常启动
- 检查浏览器控制台网络请求
- 检查跨域配置是否正确

## 许可证

MIT License
