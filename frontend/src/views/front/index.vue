<template>
  <div class="front-container">

    <!-- Hero 区域 - 深色渐变背景 -->
    <section class="hero-section" id="home">
      <div class="hero-container">
        <div class="hero-content">
          <h1 class="hero-title">
            科技驱动未来<br>
            <span class="highlight-text">连接无限可能</span>
          </h1>
          <p class="hero-subtitle">
            基于 Vue 3 + Spring Boot 3 构建的企业级管理平台
          </p>
          <p class="hero-description">
            提供完整的用户管理、权限控制、文件管理等核心功能，助力企业数字化转型
          </p>
          <div class="hero-actions">
            <el-button class="primary-cta" size="large" @click="goToAdmin">
              立即体验
            </el-button>
            <el-button class="secondary-cta" size="large">
              了解更多
            </el-button>
          </div>
        </div>
        <div class="hero-visual">
          <div class="visual-card card-1">
            <div class="card-icon">
              <el-icon :size="48"><User /></el-icon>
            </div>
            <div class="card-info">
              <div class="card-label">活跃用户</div>
              <div class="card-number">10K+</div>
            </div>
          </div>
          <div class="visual-card card-2">
            <div class="card-icon">
              <el-icon :size="48"><Document /></el-icon>
            </div>
            <div class="card-info">
              <div class="card-label">文件存储</div>
              <div class="card-number">50TB+</div>
            </div>
          </div>
          <div class="visual-card card-3">
            <div class="card-icon">
              <el-icon :size="48"><DataAnalysis /></el-icon>
            </div>
            <div class="card-info">
              <div class="card-label">数据处理</div>
              <div class="card-number">99.9%</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 功能特性 -->
    <section class="features-section" id="features">
      <div class="section-header">
        <h2 class="section-title">核心功能</h2>
        <p class="section-subtitle">强大的功能模块，满足您的各种需求</p>
      </div>
      <div class="features-grid">
        <div class="feature-card">
          <div class="feature-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
            <el-icon :size="32"><User /></el-icon>
          </div>
          <h3 class="feature-title">用户管理</h3>
          <p class="feature-desc">完善的用户管理系统，支持用户增删改查、角色分配等功能</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
            <el-icon :size="32"><Lock /></el-icon>
          </div>
          <h3 class="feature-title">权限控制</h3>
          <p class="feature-desc">基于角色的权限管理，灵活配置菜单和按钮权限</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
            <el-icon :size="32"><Menu /></el-icon>
          </div>
          <h3 class="feature-title">菜单管理</h3>
          <p class="feature-desc">动态菜单配置，支持树形结构和图标选择</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
            <el-icon :size="32"><Document /></el-icon>
          </div>
          <h3 class="feature-title">文件管理</h3>
          <p class="feature-desc">文件上传下载、预览、分类管理等完整功能</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);">
            <el-icon :size="32"><DataAnalysis /></el-icon>
          </div>
          <h3 class="feature-title">数据字典</h3>
          <p class="feature-desc">灵活的数据字典管理，支持类型和数据维护</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon" style="background: linear-gradient(135deg, #30cfd0 0%, #330867 100%);">
            <el-icon :size="32"><Setting /></el-icon>
          </div>
          <h3 class="feature-title">系统配置</h3>
          <p class="feature-desc">丰富的系统配置选项，个性化定制您的系统</p>
        </div>
      </div>
    </section>

    <!-- 技术栈 -->
    <section class="tech-section">
      <div class="section-header">
        <h2 class="section-title">技术栈</h2>
        <p class="section-subtitle">采用最新的技术栈，保证系统的稳定性和可扩展性</p>
      </div>
      <div class="tech-grid">
        <div class="tech-item">
          <div class="tech-name">Vue 3</div>
          <div class="tech-desc">渐进式JavaScript框架</div>
        </div>
        <div class="tech-item">
          <div class="tech-name">Spring Boot 3</div>
          <div class="tech-desc">Java企业级开发框架</div>
        </div>
        <div class="tech-item">
          <div class="tech-name">Element Plus</div>
          <div class="tech-desc">Vue 3 UI组件库</div>
        </div>
        <div class="tech-item">
          <div class="tech-name">MyBatis Plus</div>
          <div class="tech-desc">增强的持久层框架</div>
        </div>
        <div class="tech-item">
          <div class="tech-name">MySQL</div>
          <div class="tech-desc">关系型数据库</div>
        </div>
        <div class="tech-item">
          <div class="tech-name">Redis</div>
          <div class="tech-desc">高性能缓存数据库</div>
        </div>
      </div>
    </section>

  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import {
  User, Document, Lock, Menu, DataAnalysis
} from '@element-plus/icons-vue'

const router = useRouter()

// 前往后台管理
const goToAdmin = () => {
  router.push('/home')
}
</script>

<style scoped>
/* Hero 区域 - 深色渐变背景 */
.hero-section {
  background: linear-gradient(135deg, #001529 0%, #2563EB 100%);
  padding: 160px 0 120px;
  min-height: 100vh;
  display: flex;
  align-items: center;
}

.hero-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 24px;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 80px;
  align-items: center;
}

.hero-title {
  font-size: 56px;
  font-weight: 700;
  color: white;
  margin: 0 0 24px 0;
  line-height: 1.2;
}

.highlight-text {
  color: #F59E0B;
  font-weight: 800;
}

.hero-subtitle {
  font-size: 20px;
  color: rgba(255, 255, 255, 0.9);
  margin: 0 0 16px 0;
  line-height: 1.6;
}

.hero-description {
  font-size: 16px;
  color: rgba(255, 255, 255, 0.7);
  margin: 0 0 40px 0;
  line-height: 1.8;
}

.hero-actions {
  display: flex;
  gap: 20px;
}

.primary-cta {
  background: #F59E0B;
  color: white;
  border: none;
  padding: 14px 32px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 8px;
  transition: all 0.3s;
}

.primary-cta:hover {
  background: #D97706;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(245, 158, 11, 0.4);
}

.secondary-cta {
  background: white;
  color: #1f2937;
  border: none;
  padding: 14px 32px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 8px;
  transition: all 0.3s;
}

.secondary-cta:hover {
  background: rgba(255, 255, 255, 0.9);
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(255, 255, 255, 0.3);
}

.hero-visual {
  position: relative;
  height: 500px;
}

.visual-card {
  position: absolute;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 32px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  animation: float 4s ease-in-out infinite;
  transition: all 0.3s;
}

.visual-card:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-8px) !important;
}

.card-1 {
  top: 40px;
  left: 0;
  width: 200px;
  animation-delay: 0s;
}

.card-2 {
  top: 180px;
  right: 20px;
  width: 220px;
  animation-delay: 1.3s;
}

.card-3 {
  bottom: 60px;
  left: 80px;
  width: 200px;
  animation-delay: 2.6s;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-20px);
  }
}

.card-icon {
  width: 80px;
  height: 80px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.card-label {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.8);
  margin-bottom: 4px;
}

.card-number {
  font-size: 32px;
  font-weight: 700;
  color: white;
}

/* 功能特性 - 白色背景 */
.features-section {
  padding: 100px 24px;
  background: #FFFFFF;
}

.section-header {
  text-align: center;
  margin-bottom: 80px;
}

.section-title {
  font-size: 36px;
  font-weight: 600;
  color: #1f2937;
  margin: 0 0 16px 0;
}

.section-subtitle {
  font-size: 18px;
  color: #6b7280;
  margin: 0;
  line-height: 1.6;
}

.features-grid {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 32px;
}

.feature-card {
  background: #F9FAFB;
  border-radius: 16px;
  padding: 40px 32px;
  text-align: center;
  transition: all 0.3s;
  cursor: pointer;
  border: 1px solid transparent;
}

.feature-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.12);
  background: white;
  border-color: #2563EB;
}

.feature-icon {
  width: 80px;
  height: 80px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 24px;
  color: white;
  transition: all 0.3s;
}

.feature-card:hover .feature-icon {
  transform: scale(1.1);
}

.feature-title {
  font-size: 20px;
  font-weight: 600;
  color: #1f2937;
  margin: 0 0 12px 0;
}

.feature-desc {
  font-size: 16px;
  color: #6b7280;
  line-height: 1.8;
  margin: 0;
}

/* 技术栈 - 浅灰背景 */
.tech-section {
  padding: 100px 24px;
  background: #F9FAFB;
  max-width: 1200px;
  margin: 0 auto;
}

.tech-grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 24px;
}

.tech-item {
  text-align: center;
  padding: 24px;
  background: white;
  border-radius: 12px;
  border: 2px solid #f0f0f0;
  transition: all 0.3s;
}

.tech-item:hover {
  border-color: #667eea;
  transform: translateY(-4px);
}

.tech-name {
  font-size: 16px;
  font-weight: 600;
  color: #1f2937;
  margin-bottom: 8px;
}

.tech-desc {
  font-size: 12px;
  color: #6b7280;
}

/* 响应式 */
@media (max-width: 768px) {
  .hero-section {
    padding: 120px 0 80px;
    min-height: auto;
  }

  .hero-container {
    grid-template-columns: 1fr;
    gap: 40px;
  }

  .hero-title {
    font-size: 36px;
  }

  .hero-visual {
    height: 300px;
  }

  .features-section,
  .tech-section {
    padding: 60px 24px;
  }

  .section-title {
    font-size: 28px;
  }

  .features-grid {
    grid-template-columns: 1fr;
  }

  .tech-grid {
    grid-template-columns: repeat(2, 1fr);
  }

}
</style>
