<template>
  <div class="page-container">
    <div class="page-header">
      <h1>用户管理</h1>
    </div>

    <el-card class="search-card">
      <el-form :model="searchForm" inline>
        <el-form-item label="用户名">
          <el-input v-model="searchForm.username" placeholder="请输入用户名" clearable />
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="searchForm.nickname" placeholder="请输入昵称" clearable />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="请选择状态" clearable>
            <el-option label="启用" :value="1" />
            <el-option label="禁用" :value="0" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">
            <el-icon>
              <Search />
            </el-icon>
            查询
          </el-button>
          <el-button @click="handleReset">
            <el-icon>
              <Refresh />
            </el-icon>
            重置
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card class="table-card">
      <template #header>
        <div class="card-header">
          <span>用户列表</span>
          <el-button type="primary" @click="handleAdd">
            <el-icon>
              <Plus />
            </el-icon>
            新增用户
          </el-button>
        </div>
      </template>

      <el-table :data="tableData" v-loading="loading" stripe>
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column label="头像" width="80" align="center">
          <template #default="{ row }">
            <el-avatar :size="40" :src="row.avatar">
              <el-icon><User /></el-icon>
            </el-avatar>
          </template>
        </el-table-column>
        <el-table-column prop="username" label="用户名" min-width="100" />
        <el-table-column prop="nickname" label="昵称" min-width="100" />
        <el-table-column prop="email" label="邮箱" min-width="150" />
        <el-table-column prop="phone" label="电话" min-width="120" />
        <el-table-column prop="lastLoginIp" label="最后登录IP" min-width="130" />
        <el-table-column prop="lastLoginTime" label="最后登录时间" min-width="160" />
        <el-table-column prop="status" label="状态" width="80" align="center">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" min-width="160" />
        <el-table-column label="操作" width="240" fixed="right" align="center">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-button type="primary" link size="small" @click="handleEdit(row)">
                <el-icon>
                  <Edit />
                </el-icon>
                <span>编辑</span>
              </el-button>
              <el-button type="warning" link size="small" @click="handleResetPassword(row)">
                <el-icon>
                  <Key />
                </el-icon>
                <span>重置</span>
              </el-button>
              <el-button type="danger" link size="small" @click="handleDelete(row)">
                <el-icon>
                  <Delete />
                </el-icon>
                <span>删除</span>
              </el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination v-model:current-page="pagination.pageNum" v-model:page-size="pagination.pageSize"
        :total="pagination.total" :page-sizes="[10, 20, 50, 100]" layout="total, sizes, prev, pager, next, jumper"
        @size-change="fetchData" @current-change="fetchData" style="margin-top: 20px; justify-content: flex-end" />
    </el-card>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px" @close="handleDialogClose">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="80px">
        <el-form-item label="头像" prop="avatar">
          <div class="avatar-upload-wrapper">
            <el-upload
              class="avatar-uploader"
              :action="uploadUrl"
              :headers="uploadHeaders"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload"
              :auto-upload="true"
            >
              <el-avatar v-if="tempAvatarUrl" :size="100" :src="tempAvatarUrl" />
              <el-avatar v-else :size="100">
                <el-icon :size="50"><User /></el-icon>
              </el-avatar>
              <div class="avatar-upload-overlay">
                <el-icon :size="24"><Camera /></el-icon>
                <span>点击上传</span>
              </div>
            </el-upload>
            <div class="avatar-tip">支持 jpg、png 格式，大小不超过 2MB</div>
          </div>
        </el-form-item>
        <el-form-item label="用户名" prop="username">
          <el-input v-model="formData.username" placeholder="请输入用户名" :disabled="isEdit" />
        </el-form-item>
        <el-form-item label="昵称" prop="nickname">
          <el-input v-model="formData.nickname" placeholder="请输入昵称" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="formData.email" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="formData.phone" placeholder="请输入电话" />
        </el-form-item>
        <el-form-item label="角色" prop="roleId">
          <el-select v-model="formData.roleId" placeholder="请选择角色" style="width: 100%">
            <el-option label="超级管理员" :value="1" />
            <el-option label="普通用户" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item v-if="!isEdit" label="密码" prop="password">
          <el-input v-model="formData.password" type="password" placeholder="请输入密码" show-password />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitLoading">
          确定
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Refresh, Plus, Edit, Delete, Key, User, Camera } from '@element-plus/icons-vue'
import { getUserPage, addUser, updateUser, deleteUser, resetPassword } from '@/api/user'

const loading = ref(false)
const tableData = ref([])
const dialogVisible = ref(false)
const dialogTitle = ref('')
const isEdit = ref(false)
const submitLoading = ref(false)
const formRef = ref(null)
const tempAvatarUrl = ref('') // 临时头像URL，用于预览

// 上传配置
const uploadUrl = '/api/file/upload'
const uploadHeaders = {
  Authorization: `Bearer ${localStorage.getItem('token')}`
}

const searchForm = reactive({
  username: '',
  nickname: '',
  status: null
})

const pagination = reactive({
  pageNum: 1,
  pageSize: 10,
  total: 0
})

const formData = reactive({
  id: null,
  username: '',
  nickname: '',
  email: '',
  phone: '',
  roleId: 2,
  status: 1,
  password: '',
  avatar: ''
})

const formRules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '用户名长度在3-20个字符', trigger: 'blur' }
  ],
  nickname: [
    { required: true, message: '请输入昵称', trigger: 'blur' }
  ],
  email: [
    { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
  ],
  roleId: [
    { required: true, message: '请选择角色', trigger: 'change' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
  ]
}

// 查询
const handleSearch = () => {
  pagination.pageNum = 1
  fetchData()
}

// 重置
const handleReset = () => {
  Object.assign(searchForm, {
    username: '',
    nickname: '',
    status: null
  })
  handleSearch()
}

// 获取数据
const fetchData = async () => {
  loading.value = true
  try {
    const res = await getUserPage({
      ...searchForm,
      pageNum: pagination.pageNum,
      pageSize: pagination.pageSize
    })
    tableData.value = res.data.records
    pagination.total = res.data.total
  } catch (error) {
    console.error('获取数据失败:', error)
    ElMessage.error('获取数据失败')
  } finally {
    loading.value = false
  }
}

// 新增
const handleAdd = () => {
  isEdit.value = false
  dialogTitle.value = '新增用户'
  Object.assign(formData, {
    id: null,
    username: '',
    nickname: '',
    email: '',
    phone: '',
    roleId: 2,
    status: 1,
    password: '',
    avatar: ''
  })
  tempAvatarUrl.value = ''
  dialogVisible.value = true
}

// 编辑
const handleEdit = (row) => {
  isEdit.value = true
  dialogTitle.value = '编辑用户'
  Object.assign(formData, {
    id: row.id,
    username: row.username,
    nickname: row.nickname,
    email: row.email,
    phone: row.phone,
    roleId: row.roleId,
    status: row.status,
    password: '',
    avatar: row.avatar || ''
  })
  tempAvatarUrl.value = row.avatar || ''
  dialogVisible.value = true
}

// 提交
const handleSubmit = async () => {
  if (!formRef.value) return

  await formRef.value.validate(async (valid) => {
    if (valid) {
      submitLoading.value = true
      try {
        if (isEdit.value) {
          await updateUser(formData)
          ElMessage.success('更新成功')
        } else {
          await addUser(formData)
          ElMessage.success('新增成功')
        }
        dialogVisible.value = false
        fetchData()
      } catch (error) {
        console.error('提交失败:', error)
      } finally {
        submitLoading.value = false
      }
    }
  })
}

// 关闭对话框
const handleDialogClose = () => {
  formRef.value?.resetFields()
  tempAvatarUrl.value = ''
}

// 头像上传前验证
const beforeAvatarUpload = (file) => {
  const isImage = file.type.startsWith('image/')
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isImage) {
    ElMessage.error('只能上传图片文件!')
    return false
  }
  if (!isLt2M) {
    ElMessage.error('图片大小不能超过 2MB!')
    return false
  }
  return true
}

// 头像上传成功（只更新临时预览，不保存到数据库）
const handleAvatarSuccess = (response) => {
  if (response.code === 200) {
    tempAvatarUrl.value = response.data.url
    formData.avatar = response.data.url
    ElMessage.success('头像上传成功，请点击确定保存')
  } else {
    ElMessage.error('头像上传失败')
  }
}

// 删除
const handleDelete = (row) => {
  ElMessageBox.confirm('确定要删除该用户吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    try {
      await deleteUser(row.id)
      ElMessage.success('删除成功')
      fetchData()
    } catch (error) {
      console.error('删除失败:', error)
    }
  }).catch(() => { })
}

// 重置密码
const handleResetPassword = (row) => {
  ElMessageBox.confirm(
    `确定要将用户 "${row.username}" 的密码重置为默认密码 123456 吗？`,
    '重置密码',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }
  ).then(async () => {
    try {
      await resetPassword(row.id)
      ElMessage.success('密码重置成功，默认密码为：123456')
    } catch (error) {
      console.error('重置密码失败:', error)
    }
  }).catch(() => { })
}

onMounted(() => {
  fetchData()
})
</script>

<style scoped>
.page-container {
  padding: 24px;
}

.page-header {
  margin-bottom: 24px;
}

.page-header h1 {
  font-size: 24px;
  font-weight: 600;
  color: #1F2937;
  margin: 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.page-header h1::before {
  content: '';
  width: 4px;
  height: 24px;
  background: linear-gradient(135deg, #2563EB 0%, #1D4ED8 100%);
  border-radius: 2px;
}

.search-card {
  margin-bottom: 24px;
}

.search-card :deep(.el-card__body) {
  padding: 24px;
}

.search-card :deep(.el-form-item) {
  margin-bottom: 0;
}

.search-card :deep(.el-input) {
  width: 200px;
}

.search-card :deep(.el-select) {
  width: 150px;
}

.search-card :deep(.el-button) {
  margin-left: 8px;
}

.table-card :deep(.el-card__header) {
  padding: 24px;
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header span {
  font-size: 16px;
  font-weight: 600;
  color: #1F2937;
}

.table-card :deep(.el-table .el-table__header th) {
  background-color: #F3F4F6;
  color: #1F2937;
  font-weight: 600;
}

.table-card :deep(.el-table .el-table__row) {
  transition: all 150ms;
}

.table-card :deep(.el-table .el-table__row:hover) {
  background-color: rgba(37, 99, 235, 0.03);
}

.action-buttons {
  display: flex;
  gap: 4px;
  align-items: center;
}

.action-buttons .el-button.is-link {
  padding: 6px 10px;
  height: auto;
  border-radius: 4px;
  transition: all 150ms;
}

.action-buttons .el-button.is-link .el-icon {
  margin-right: 4px;
}

.action-buttons .el-button.is-link span {
  font-size: 13px;
}

.action-buttons .el-button.is-link.el-button--primary:hover {
  background-color: rgba(37, 99, 235, 0.1) !important;
}

.action-buttons .el-button.is-link.el-button--warning:hover {
  background-color: rgba(245, 158, 11, 0.1) !important;
}

.action-buttons .el-button.is-link.el-button--danger:hover {
  background-color: rgba(239, 68, 68, 0.1) !important;
}

.table-card :deep(.el-pagination) {
  padding: 24px 0;
  display: flex;
  justify-content: flex-end;
}

/* 对话框样式 */
:deep(.el-dialog) {
  border-radius: 8px;
}

:deep(.el-dialog .el-dialog__header) {
  padding: 24px;
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  border-bottom: 1px solid #E5E7EB;
  margin-right: 0;
}

:deep(.el-dialog .el-dialog__title) {
  font-size: 18px;
  font-weight: 600;
  color: #1F2937;
}

:deep(.el-dialog .el-dialog__body) {
  padding: 32px;
}

:deep(.el-dialog .el-dialog__footer) {
  padding: 24px 32px;
  border-top: 1px solid #E5E7EB;
}

:deep(.el-dialog .el-form .el-form-item) {
  margin-bottom: 24px;
}

:deep(.el-dialog .el-form .el-form-item__label) {
  font-weight: 500;
  color: #1F2937;
}

:deep(.el-dialog .el-form .el-input),
:deep(.el-dialog .el-form .el-select) {
  width: 100%;
}

/* 状态标签 */
:deep(.el-tag) {
  border-radius: 4px;
  font-weight: 500;
  padding: 4px 12px;
}

/* 按钮样式 */
:deep(.el-button) {
  border-radius: 4px;
  font-weight: 500;
  transition: all 150ms;
}

:deep(.el-button.el-button--primary) {
  background: linear-gradient(135deg, #2563EB 0%, #1D4ED8 100%);
  border: none;
}

:deep(.el-button.el-button--primary:hover) {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

:deep(.el-button.is-link.el-button--primary:hover) {
  color: #1D4ED8;
  transform: none;
  box-shadow: none;
}

:deep(.el-button.is-link.el-button--warning:hover) {
  color: #D97706;
}

:deep(.el-button.is-link.el-button--danger:hover) {
  color: #DC2626;
}

/* 头像上传样式 */
.avatar-upload-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.avatar-uploader {
  position: relative;
  cursor: pointer;
  display: inline-block;
}

.avatar-uploader :deep(.el-upload) {
  position: relative;
  overflow: hidden;
  border-radius: 50%;
}

.avatar-upload-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 4px;
  color: white;
  opacity: 0;
  transition: all 0.3s;
  font-size: 12px;
}

.avatar-uploader:hover .avatar-upload-overlay {
  opacity: 1;
}

.avatar-tip {
  font-size: 12px;
  color: #909399;
  text-align: center;
}

/* 响应式 */
@media (max-width: 768px) {
  .page-container {
    padding: 16px;
  }

  .search-card :deep(.el-form .el-form-item) {
    display: block;
    margin-bottom: 16px;
  }

  .search-card :deep(.el-form .el-input),
  .search-card :deep(.el-form .el-select) {
    width: 100%;
  }

  .table-card :deep(.el-table) {
    font-size: 12px;
  }
}
</style>
