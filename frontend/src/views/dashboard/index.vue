<template>
  <div class="dashboard-container">
    <!-- 欢迎卡片 -->
    <el-card class="welcome-card">
      <div class="welcome-content">
        <div class="welcome-text">
          <h1>👋 欢迎回来，{{ userInfo?.nickname || '用户' }}！</h1>
          <p class="welcome-desc">{{ greeting }}，今天也要元气满满哦~</p>
          <div class="welcome-time">
            <el-icon><Clock /></el-icon>
            <span>{{ currentTime }}</span>
          </div>
        </div>
        <div class="welcome-image">
          <img src="https://img.icons8.com/clouds/200/000000/dashboard.png" alt="Dashboard" />
        </div>
      </div>
    </el-card>

    <!-- 数据统计卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card stat-card-blue" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon">
              <el-icon><User /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.userCount }}</div>
              <div class="stat-label">用户总数</div>
            </div>
          </div>
          <div class="stat-footer">
            <span class="stat-trend up">
              <el-icon><CaretTop /></el-icon>
              12%
            </span>
            <span class="stat-desc">较上周</span>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card stat-card-green" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon">
              <el-icon><Document /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.fileCount }}</div>
              <div class="stat-label">文件数量</div>
            </div>
          </div>
          <div class="stat-footer">
            <span class="stat-trend up">
              <el-icon><CaretTop /></el-icon>
              8%
            </span>
            <span class="stat-desc">较上周</span>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card stat-card-orange" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon">
              <el-icon><View /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.visitCount }}</div>
              <div class="stat-label">访问次数</div>
            </div>
          </div>
          <div class="stat-footer">
            <span class="stat-trend up">
              <el-icon><CaretTop /></el-icon>
              15%
            </span>
            <span class="stat-desc">较上周</span>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :sm="12" :lg="6">
        <el-card class="stat-card stat-card-purple" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon">
              <el-icon><MessageBox /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.messageCount }}</div>
              <div class="stat-label">消息通知</div>
            </div>
          </div>
          <div class="stat-footer">
            <span class="stat-trend down">
              <el-icon><CaretBottom /></el-icon>
              3%
            </span>
            <span class="stat-desc">较上周</span>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 快捷操作和通知 -->
    <el-row :gutter="20" class="content-row">
      <el-col :xs="24" :lg="12">
        <el-card class="quick-actions-card">
          <template #header>
            <div class="card-header">
              <span>⚡ 快捷操作</span>
            </div>
          </template>
          <div class="quick-actions">
            <div class="action-item" @click="goToPage('/system/user')">
              <el-icon class="action-icon" color="#2563EB"><UserFilled /></el-icon>
              <div class="action-text">
                <div class="action-title">用户管理</div>
                <div class="action-desc">管理系统用户</div>
              </div>
            </div>
            <div class="action-item" @click="goToPage('/system/role')">
              <el-icon class="action-icon" color="#10B981"><Avatar /></el-icon>
              <div class="action-text">
                <div class="action-title">角色管理</div>
                <div class="action-desc">配置用户角色</div>
              </div>
            </div>
            <div class="action-item" @click="goToPage('/data/file')">
              <el-icon class="action-icon" color="#F59E0B"><FolderOpened /></el-icon>
              <div class="action-text">
                <div class="action-title">文件管理</div>
                <div class="action-desc">管理上传文件</div>
              </div>
            </div>
            <div class="action-item" @click="goToPage('/system/menu')">
              <el-icon class="action-icon" color="#8B5CF6"><Menu /></el-icon>
              <div class="action-text">
                <div class="action-title">菜单管理</div>
                <div class="action-desc">配置系统菜单</div>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :lg="12">
        <el-card class="notice-card">
          <template #header>
            <div class="card-header">
              <span>📢 系统通知</span>
            </div>
          </template>
          <el-timeline>
            <el-timeline-item
              v-for="(notice, index) in notices"
              :key="index"
              :timestamp="notice.time"
              placement="top"
              :color="notice.color"
            >
              <div class="notice-item">
                <div class="notice-title">{{ notice.title }}</div>
                <div class="notice-content">{{ notice.content }}</div>
              </div>
            </el-timeline-item>
          </el-timeline>
        </el-card>
      </el-col>
    </el-row>

    <!-- 系统信息 -->
    <el-row :gutter="20">
      <el-col :span="24">
        <el-card class="system-info-card">
          <template #header>
            <div class="card-header">
              <span>💻 系统信息</span>
            </div>
          </template>
          <el-descriptions :column="3" border>
            <el-descriptions-item label="系统名称">TechFlow管理系统</el-descriptions-item>
            <el-descriptions-item label="系统版本">v1.0.0</el-descriptions-item>
            <el-descriptions-item label="后端框架">Spring Boot 2.7.18</el-descriptions-item>
            <el-descriptions-item label="前端框架">Vue 3 + Element Plus</el-descriptions-item>
            <el-descriptions-item label="数据库">MySQL 5.7+</el-descriptions-item>
            <el-descriptions-item label="JDK版本">JDK 17</el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'
import {
  Clock,
  User,
  Document,
  View,
  MessageBox,
  CaretTop,
  CaretBottom,
  UserFilled,
  Avatar,
  FolderOpened,
  Menu
} from '@element-plus/icons-vue'

const router = useRouter()
const userStore = useUserStore()

const userInfo = computed(() => userStore.userInfo)
const currentTime = ref('')
let timer = null

// 统计数据
const stats = ref({
  userCount: 1234,
  fileCount: 567,
  visitCount: 8901,
  messageCount: 23
})

// 通知列表
const notices = ref([
  {
    title: '系统更新',
    content: '系统已更新到v1.0.0版本，新增多项功能',
    time: '2025-11-20 10:30',
    color: '#2563EB'
  },
  {
    title: '安全提醒',
    content: '请定期修改密码，保护账号安全',
    time: '2025-11-19 15:20',
    color: '#F59E0B'
  },
  {
    title: '功能上线',
    content: '文件管理功能已上线，支持文件上传下载',
    time: '2025-11-18 09:00',
    color: '#10B981'
  }
])

// 问候语
const greeting = computed(() => {
  const hour = new Date().getHours()
  if (hour < 6) return '夜深了'
  if (hour < 9) return '早上好'
  if (hour < 12) return '上午好'
  if (hour < 14) return '中午好'
  if (hour < 18) return '下午好'
  if (hour < 22) return '晚上好'
  return '夜深了'
})

// 更新时间
const updateTime = () => {
  const now = new Date()
  currentTime.value = now.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: false
  })
}

// 跳转页面
const goToPage = (path) => {
  router.push(path)
}

onMounted(() => {
  updateTime()
  timer = setInterval(updateTime, 1000)
})

onUnmounted(() => {
  if (timer) {
    clearInterval(timer)
  }
})
</script>

<style lang="scss" scoped>
@use '@/styles/variables.scss' as *;

.dashboard-container {
  padding: $spacing-lg;
}

// 欢迎卡片
.welcome-card {
  margin-bottom: $spacing-lg;
  background: linear-gradient(135deg, $primary-color 0%, $primary-hover 100%);
  color: $bg-white;

  :deep(.el-card__body) {
    padding: $spacing-xl;
  }

  .welcome-content {
    display: flex;
    justify-content: space-between;
    align-items: center;

    .welcome-text {
      h1 {
        font-size: 28px;
        margin: 0 0 $spacing-sm 0;
        font-weight: 600;
      }

      .welcome-desc {
        font-size: 16px;
        opacity: 0.9;
        margin-bottom: $spacing-md;
      }

      .welcome-time {
        display: flex;
        align-items: center;
        gap: $spacing-xs;
        font-size: 14px;
        opacity: 0.8;
      }
    }

    .welcome-image {
      img {
        width: 150px;
        height: 150px;
      }
    }
  }
}

// 统计卡片
.stats-row {
  margin-bottom: $spacing-lg;
}

.stat-card {
  margin-bottom: $spacing-md;
  transition: all $transition-base;

  &:hover {
    transform: translateY(-4px);
  }

  .stat-content {
    display: flex;
    align-items: center;
    gap: $spacing-md;
    margin-bottom: $spacing-md;

    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: $radius-lg;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      color: $bg-white;
    }

    .stat-info {
      flex: 1;

      .stat-value {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: $spacing-xs;
      }

      .stat-label {
        font-size: 14px;
        color: $text-secondary;
      }
    }
  }

  .stat-footer {
    display: flex;
    align-items: center;
    gap: $spacing-sm;
    font-size: 12px;

    .stat-trend {
      display: flex;
      align-items: center;
      gap: 2px;
      font-weight: 500;

      &.up {
        color: $success-color;
      }

      &.down {
        color: $danger-color;
      }
    }

    .stat-desc {
      color: $text-secondary;
    }
  }
}

.stat-card-blue .stat-icon {
  background: linear-gradient(135deg, #2563EB 0%, #1D4ED8 100%);
}

.stat-card-green .stat-icon {
  background: linear-gradient(135deg, #10B981 0%, #059669 100%);
}

.stat-card-orange .stat-icon {
  background: linear-gradient(135deg, #F59E0B 0%, #D97706 100%);
}

.stat-card-purple .stat-icon {
  background: linear-gradient(135deg, #8B5CF6 0%, #7C3AED 100%);
}

// 内容行
.content-row {
  margin-bottom: $spacing-lg;
}

// 快捷操作
.quick-actions-card {
  height: 100%;

  .quick-actions {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: $spacing-md;

    .action-item {
      display: flex;
      align-items: center;
      gap: $spacing-md;
      padding: $spacing-md;
      border-radius: $radius-lg;
      background: $bg-color;
      cursor: pointer;
      transition: all $transition-fast;

      &:hover {
        background: $primary-color;
        color: $bg-white;
        transform: translateY(-2px);
        box-shadow: $shadow-level-1;

        .action-icon {
          color: $bg-white !important;
        }

        .action-desc {
          color: rgba(255, 255, 255, 0.8);
        }
      }

      .action-icon {
        font-size: 32px;
      }

      .action-text {
        .action-title {
          font-size: 15px;
          font-weight: 500;
          margin-bottom: 4px;
        }

        .action-desc {
          font-size: 12px;
          color: $text-secondary;
        }
      }
    }
  }
}

// 通知卡片
.notice-card {
  height: 100%;

  .notice-item {
    .notice-title {
      font-weight: 500;
      margin-bottom: 4px;
    }

    .notice-content {
      font-size: 13px;
      color: $text-secondary;
    }
  }
}

// 系统信息
.system-info-card {
  :deep(.el-descriptions__label) {
    font-weight: 500;
  }
}

.card-header {
  font-size: 16px;
  font-weight: 600;
}

@media (max-width: 768px) {
  .welcome-content {
    flex-direction: column;
    text-align: center;

    .welcome-image {
      margin-top: $spacing-md;
    }
  }

  .quick-actions {
    grid-template-columns: 1fr !important;
  }
}
</style>
