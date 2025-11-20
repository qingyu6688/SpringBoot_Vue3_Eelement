<template>
  <div class="front-profile-container">
    <!-- 顶部横幅 -->
    <div class="profile-banner">
      <div class="banner-bg"></div>
      <div class="banner-content">
        <div class="avatar-wrapper">
          <el-upload
            class="avatar-uploader"
            :action="uploadUrl"
            :headers="uploadHeaders"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload"
          >
            <el-avatar :size="140" :src="avatarUrl" class="user-avatar">
              <el-icon :size="70"><User /></el-icon>
            </el-avatar>
            <div class="avatar-overlay">
              <el-icon :size="28"><Camera /></el-icon>
              <span>更换头像</span>
            </div>
          </el-upload>
        </div>
        <div class="user-info">
          <h1 class="user-name">{{ userInfo?.username || '用户名' }}</h1>
          <p class="user-role">
            <el-tag type="primary" size="large" effect="plain">{{ userInfo?.roleName || '普通用户' }}</el-tag>
          </p>
        </div>
      </div>
    </div>

    <!-- 信息卡片区域 -->
    <div class="info-cards">
      <div class="info-card">
        <div class="card-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
          <el-icon :size="32"><Message /></el-icon>
        </div>
        <div class="card-content">
          <div class="card-label">邮箱</div>
          <div class="card-value">{{ userInfo?.email || '未设置' }}</div>
        </div>
      </div>
      <div class="info-card">
        <div class="card-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
          <el-icon :size="32"><Phone /></el-icon>
        </div>
        <div class="card-content">
          <div class="card-label">手机号</div>
          <div class="card-value">{{ userInfo?.phone || '未设置' }}</div>
        </div>
      </div>
      <div class="info-card">
        <div class="card-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
          <el-icon :size="32"><Calendar /></el-icon>
        </div>
        <div class="card-content">
          <div class="card-label">注册时间</div>
          <div class="card-value">{{ userInfo?.createTime || '-' }}</div>
        </div>
      </div>
    </div>

    <!-- 编辑区域 -->
    <div class="edit-section">
      <el-tabs v-model="activeTab" class="profile-tabs">
        <el-tab-pane label="编辑资料" name="profile">
          <el-form :model="profileForm" :rules="profileRules" ref="profileFormRef" label-width="100px" class="profile-form">
        <el-form-item label="昵称" prop="nickname">
          <el-input v-model="profileForm.nickname" placeholder="请输入昵称">
            <template #prefix>
              <el-icon><User /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="profileForm.email" placeholder="请输入邮箱">
            <template #prefix>
              <el-icon><Message /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="profileForm.phone" placeholder="请输入手机号">
            <template #prefix>
              <el-icon><Phone /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleUpdateProfile" :loading="loading">
            保存修改
          </el-button>
          <el-button @click="resetProfileForm">
            重置
          </el-button>
        </el-form-item>
      </el-form>
        </el-tab-pane>

        <el-tab-pane label="修改密码" name="password">
          <el-form :model="passwordForm" :rules="passwordRules" ref="passwordFormRef" label-width="100px" class="profile-form">
        <el-alert
          title="为了您的账号安全，建议定期更换密码"
          type="info"
          :closable="false"
          style="margin-bottom: 20px;"
        />
        <el-form-item label="原密码" prop="oldPassword">
          <el-input v-model="passwordForm.oldPassword" type="password" placeholder="请输入原密码" show-password>
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input v-model="passwordForm.newPassword" type="password" placeholder="请输入新密码" show-password>
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="passwordForm.confirmPassword" type="password" placeholder="请再次输入新密码" show-password>
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleUpdatePassword" :loading="loading">
            修改密码
          </el-button>
          <el-button @click="resetPasswordForm">
            重置
          </el-button>
        </el-form-item>
      </el-form>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import {
  User, Camera, Message, Phone, Calendar, Edit, Lock
} from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()
const userInfo = computed(() => userStore.userInfo)

const activeTab = ref('profile')
const loading = ref(false)
const profileFormRef = ref(null)
const passwordFormRef = ref(null)
const avatarUrl = ref('')

// 上传配置
const uploadUrl = computed(() => '/api/file/upload')
const uploadHeaders = computed(() => {
  const token = localStorage.getItem('token')
  return {
    Authorization: token ? `Bearer ${token}` : ''
  }
})

const profileForm = reactive({
  nickname: '',
  email: '',
  phone: ''
})

const passwordForm = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const profileRules = {
  nickname: [
    { required: true, message: '请输入昵称', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
  ],
  phone: [
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ]
}

const passwordRules = {
  oldPassword: [
    { required: true, message: '请输入原密码', trigger: 'blur' }
  ],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请再次输入新密码', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        if (value !== passwordForm.newPassword) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
}

// 更新资料
const handleUpdateProfile = async () => {
  if (!profileFormRef.value) return
  
  await profileFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        const { updateUser } = await import('@/api/user')
        await updateUser({
          id: userInfo.value.id,
          nickname: profileForm.nickname,
          email: profileForm.email,
          phone: profileForm.phone
        })
        
        // 更新Store中的用户信息
        await userStore.fetchUserInfo()
        
        ElMessage.success('资料更新成功')
      } catch (error) {
        console.error('资料更新失败:', error)
        ElMessage.error('资料更新失败')
      } finally {
        loading.value = false
      }
    }
  })
}

// 修改密码
const handleUpdatePassword = async () => {
  if (!passwordFormRef.value) return
  
  await passwordFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        const { updatePassword } = await import('@/api/user')
        await updatePassword(
          userInfo.value.id,
          passwordForm.oldPassword,
          passwordForm.newPassword
        )
        
        ElMessage.success('密码修改成功，请重新登录')
        
        // 延迟1秒后退出登录并跳转到登录页
        setTimeout(async () => {
          await userStore.logout()
          router.push('/login')
        }, 1000)
      } catch (error) {
        console.error('密码修改失败:', error)
        ElMessage.error(error.response?.data?.message || '密码修改失败')
      } finally {
        loading.value = false
      }
    }
  })
}

// 重置表单
const resetProfileForm = () => {
  profileFormRef.value?.resetFields()
}

const resetPasswordForm = () => {
  passwordFormRef.value?.resetFields()
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

// 头像上传成功
const handleAvatarSuccess = async (response) => {
  if (response.code === 200) {
    const newAvatarUrl = response.data.url
    avatarUrl.value = newAvatarUrl
    
    // 更新数据库中的头像
    try {
      const { updateAvatar } = await import('@/api/user')
      await updateAvatar(userInfo.value.id, newAvatarUrl)
      
      // 更新Store中的用户信息
      userStore.updateAvatar(newAvatarUrl)
      
      ElMessage.success('头像更新成功')
    } catch (error) {
      console.error('头像更新失败:', error)
      ElMessage.error('头像更新失败')
    }
  } else {
    ElMessage.error('头像上传失败')
  }
}

onMounted(() => {
  // 初始化表单数据
  if (userInfo.value) {
    profileForm.nickname = userInfo.value.nickname || ''
    profileForm.email = userInfo.value.email || ''
    profileForm.phone = userInfo.value.phone || ''
    avatarUrl.value = userInfo.value.avatar || ''
  }
})
</script>

<style scoped>
.front-profile-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 90px 24px 60px;
}

/* 顶部横幅 */
.profile-banner {
  position: relative;
  margin-bottom: 40px;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.banner-bg {
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.banner-content {
  position: relative;
  background: white;
  padding: 0 40px 32px;
  display: flex;
  align-items: flex-end;
  gap: 32px;
}

.avatar-wrapper {
  position: relative;
  margin-top: -70px;
}

.avatar-uploader {
  position: relative;
  cursor: pointer;
  display: inline-block;
}

.user-avatar {
  border: 6px solid white;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  transition: all 0.3s;
}

.avatar-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 140px;
  height: 140px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 6px;
  color: white;
  opacity: 0;
  transition: all 0.3s;
  font-size: 14px;
  font-weight: 500;
}

.avatar-uploader:hover .avatar-overlay {
  opacity: 1;
}

.avatar-uploader:hover .user-avatar {
  transform: scale(1.05);
}

.user-info {
  flex: 1;
  padding-bottom: 8px;
}

.user-name {
  font-size: 32px;
  font-weight: 700;
  color: #1f2937;
  margin: 0 0 12px 0;
}

.user-role {
  margin: 0;
}

/* 信息卡片 */
.info-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  margin-bottom: 40px;
}

.info-card {
  background: white;
  border-radius: 16px;
  padding: 28px;
  display: flex;
  align-items: center;
  gap: 20px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.3s;
  cursor: pointer;
}

.info-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.card-icon {
  width: 72px;
  height: 72px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  flex-shrink: 0;
}

.card-content {
  flex: 1;
}

.card-label {
  font-size: 14px;
  color: #6b7280;
  margin-bottom: 6px;
}

.card-value {
  font-size: 18px;
  font-weight: 600;
  color: #1f2937;
  word-break: break-all;
}

/* 编辑区域 */
.edit-section {
  background: white;
  border-radius: 20px;
  padding: 32px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
}

.profile-tabs :deep(.el-tabs__header) {
  margin-bottom: 32px;
}

.profile-tabs :deep(.el-tabs__item) {
  font-size: 16px;
  font-weight: 600;
  padding: 0 24px;
  height: 48px;
  line-height: 48px;
}

.profile-tabs :deep(.el-tabs__active-bar) {
  height: 3px;
}

.profile-form {
  max-width: 600px;
  margin: 0 auto;
}

.profile-form :deep(.el-input),
.profile-form :deep(.el-textarea) {
  border-radius: 8px;
}

.profile-form :deep(.el-button) {
  border-radius: 8px;
  padding: 12px 28px;
  font-weight: 600;
}

.profile-form :deep(.el-form-item__label) {
  font-weight: 600;
  color: #1f2937;
}

/* 响应式 */
@media (max-width: 768px) {
  .front-profile-container {
    padding: 80px 16px 40px;
  }

  .banner-content {
    flex-direction: column;
    align-items: center;
    text-align: center;
    padding: 0 24px 24px;
  }

  .avatar-wrapper {
    margin-top: -70px;
  }

  .user-name {
    font-size: 24px;
  }

  .info-cards {
    grid-template-columns: 1fr;
  }

  .profile-form {
    max-width: 100%;
  }
}
</style>
