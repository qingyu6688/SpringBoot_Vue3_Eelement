# Swagger API文档使用说明

## 访问地址

项目启动后，通过以下地址访问Swagger文档：

### Swagger UI界面
```
http://localhost:8080/swagger-ui.html
```

### OpenAPI JSON
```
http://localhost:8080/v3/api-docs
```

## 功能说明

### 已配置的API模块

1. **认证管理** (`/api/auth`)
   - 用户登录
   - 获取当前用户信息
   - 用户登出

2. **用户管理** (`/api/user`)
   - 分页查询用户列表
   - 查询所有用户
   - 根据ID查询用户
   - 新增用户
   - 修改用户
   - 删除用户
   - 批量删除用户
   - 修改用户状态
   - 重置密码

3. **角色管理** (`/api/role`)
4. **菜单管理** (`/api/menu`)
5. **字典管理** (`/api/dict`)
6. **文件管理** (`/api/file`)

## 使用方法

### 1. 启动项目
```bash
mvn spring-boot:run
```

### 2. 访问Swagger UI
在浏览器中打开：`http://localhost:8080/swagger-ui.html`

### 3. 测试接口
- 点击任意接口展开详情
- 点击 "Try it out" 按钮
- 填写请求参数
- 点击 "Execute" 执行请求
- 查看响应结果

## 配置说明

### application.yml配置
```yaml
springdoc:
  api-docs:
    enabled: true
    path: /v3/api-docs
  swagger-ui:
    enabled: true
    path: /swagger-ui.html
    tags-sorter: alpha
    operations-sorter: alpha
  packages-to-scan: com.example.controller
  paths-to-match: /api/**
```

### 注解说明

#### @Tag
用于Controller类，定义API分组
```java
@Tag(name = "用户管理", description = "用户增删改查接口")
```

#### @Operation
用于方法，定义接口说明
```java
@Operation(summary = "分页查询用户列表", description = "支持用户名、昵称、状态筛选")
```

#### @Parameter
用于参数，定义参数说明
```java
@Parameter(description = "用户ID") @PathVariable Long id
```

## 其他Controller添加Swagger注解示例

如需为其他Controller添加Swagger文档，参考以下模板：

```java
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "模块名称", description = "模块描述")
@RestController
@RequestMapping("/api/xxx")
public class XxxController {

    @Operation(summary = "接口摘要", description = "接口详细描述")
    @GetMapping("/{id}")
    public Result<Xxx> getById(
        @Parameter(description = "参数说明") @PathVariable Long id) {
        // ...
    }
}
```

## 注意事项

1. Swagger UI仅在开发环境使用，生产环境建议关闭
2. 可通过配置 `springdoc.api-docs.enabled=false` 禁用API文档
3. 所有 `/api/**` 路径下的接口都会自动生成文档
4. 建议为所有接口添加详细的注解说明
