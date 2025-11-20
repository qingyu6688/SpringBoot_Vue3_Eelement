<template>
  <footer class="front-footer">
    <div class="footer-content">
      <div class="footer-section">
        <h3>TechFlow</h3>
        <p>现代化管理系统解决方案</p>
      </div>
      <div class="footer-section">
        <h4>快速链接</h4>
        <a href="#home">首页</a>
        <a href="#features">功能特性</a>
        <a href="#about">关于我们</a>
      </div>
      <div class="footer-section">
        <h4>联系我们</h4>
        <p>邮箱: admin@techflow.com</p>
        <p>电话: 400-123-4567</p>
      </div>
    </div>
    <div class="footer-bottom">
      <p>© 2025 TechFlow Team. All rights reserved.</p>
    </div>
  </footer>
</template>

<script setup>
</script>

<style scoped>
/* 页脚 - 深色背景 */
.front-footer {
  background: #111827;
  color: white;
  padding: 80px 24px 32px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto 40px;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 40px;
}

.footer-section h3,
.footer-section h4 {
  margin: 0 0 16px 0;
}

.footer-section p,
.footer-section a {
  color: #9ca3af;
  margin: 8px 0;
  display: block;
  text-decoration: none;
}

.footer-section a:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 24px;
  border-top: 1px solid #374151;
  color: #9ca3af;
}

/* 响应式 */
@media (max-width: 768px) {
  .footer-content {
    grid-template-columns: 1fr;
  }
}
</style>
