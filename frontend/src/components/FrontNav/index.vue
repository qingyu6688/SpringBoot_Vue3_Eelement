<template>
  <header class="front-header" :class="{ 'is-scrolled': isScrolled }">
    <div class="header-content">
      <div class="logo-section">
        <h1 class="logo">TechFlow</h1>
      </div>
      <nav class="nav-menu">
        <a href="#home" class="nav-item" :class="{ active: activeSection === 'home' }">首页</a>
        <a href="#features" class="nav-item" :class="{ active: activeSection === 'features' }">功能特性</a>
        <a href="#about" class="nav-item" :class="{ active: activeSection === 'about' }">关于我们</a>
        <a href="#contact" class="nav-item" :class="{ active: activeSection === 'contact' }">联系我们</a>
      </nav>
      <div class="header-actions">
        <!-- 只有管理员才显示进入后台按钮 -->
        <el-button v-if="userInfo?.roleId === 1" class="cta-btn" @click="goToAdmin">
          进入后台
        </el-button>
        
        <!-- 用户信息下拉框 -->
        <el-dropdown v-if="userInfo" @command="handleCommand" class="user-dropdown">
          <div class="user-info">
            <el-avatar :size="36" :src="userInfo?.avatar || ''">
              <el-icon v-if="!userInfo?.avatar"><User /></el-icon>
              <span v-else>{{ userInfo?.nickname?.charAt(0) || 'U' }}</span>
            </el-avatar>
            <span class="username">{{ userInfo?.nickname || '用户' }}</span>
          </div>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item command="profile">
                <el-icon><User /></el-icon>
                个人中心
              </el-dropdown-item>
              <el-dropdown-item divided command="logout">
                <el-icon><SwitchButton /></el-icon>
                退出登录
              </el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
        
        <!-- 未登录状态 -->
        <el-button v-else class="login-btn" @click="goToLogin">
          登录
        </el-button>
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'
import { ElMessageBox } from 'element-plus'
import { User, SwitchButton } from '@element-plus/icons-vue'

const router = useRouter()
const userStore = useUserStore()
const isScrolled = ref(false)
const activeSection = ref('home')

// 获取用户信息
const userInfo = computed(() => userStore.userInfo)

// 监听滚动事件
const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})

// 前往后台管理
const goToAdmin = () => {
  // 如果已登录，直接进入后台首页
  if (userInfo.value) {
    router.push('/dashboard')
  } else {
    // 未登录，跳转到登录页
    router.push('/login')
  }
}

// 前往登录
const goToLogin = () => {
  router.push('/login')
}

// 下拉菜单命令处理
const handleCommand = async (command) => {
  switch (command) {
    case 'profile':
      router.push('/front/profile')
      break
    case 'logout':
      ElMessageBox.confirm('确定要退出登录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        await userStore.logout()
        router.push('/login')
      })
      break
  }
}
</script>

<style scoped>
/* 顶部导航 - 固定白色背景 */
.front-header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 70px;
  background: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(20px);
  box-shadow: 0 2px 16px rgba(0, 0, 0, 0.08);
  z-index: 1000;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
}

.logo-section {
  display: flex;
  align-items: center;
  gap: 12px;
}

.logo {
  font-size: 28px;
  font-weight: 700;
  margin: 0;
  cursor: pointer;
  background: linear-gradient(135deg, #2563EB 0%, #001529 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.cta-btn {
  background: #2563EB;
  color: white;
  border: none;
  padding: 10px 24px;
  font-weight: 600;
  transition: all 0.3s;
}

.cta-btn:hover {
  background: #1D4ED8;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 16px;
}

.login-btn {
  background: transparent;
  color: #2563EB;
  border: 2px solid #2563EB;
  padding: 8px 20px;
  font-weight: 600;
  transition: all 0.3s;
}

.login-btn:hover {
  background: #2563EB;
  color: white;
}

.user-dropdown {
  cursor: pointer;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 4px 12px;
  border-radius: 20px;
  transition: all 0.3s;
}

.user-info:hover {
  background: rgba(37, 99, 235, 0.1);
}

.user-info .el-avatar {
  border: 2px solid rgba(37, 99, 235, 0.3);
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.username {
  color: #1f2937;
  font-weight: 500;
  font-size: 14px;
}

.nav-menu {
  display: flex;
  gap: 32px;
}

.nav-item {
  color: #1f2937;
  text-decoration: none;
  font-weight: 500;
  transition: all 0.3s;
  position: relative;
  padding: 8px 0;
}

.nav-item:hover,
.nav-item.active {
  color: #2563EB;
}

.nav-item.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: currentColor;
}

/* 响应式 */
@media (max-width: 768px) {
  .nav-menu {
    display: none;
  }

  .username {
    display: none;
  }

  .header-actions {
    gap: 8px;
  }

  .cta-btn {
    padding: 8px 16px;
    font-size: 14px;
  }
}
</style>
