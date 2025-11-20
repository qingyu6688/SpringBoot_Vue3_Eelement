import { createRouter, createWebHistory } from 'vue-router'
import Layout from '@/layout/index.vue'
import { useUserStore } from '@/stores/user'
import { ElMessage } from 'element-plus'

/**
 * 路由配置
 * meta 参数说明：
 * - title: 页面标题，用于面包屑和标签页
 * - icon: 菜单图标（Element Plus Icons）
 * - requiresAuth: 是否需要登录（默认true）
 * - roles: 允许访问的角色数组
 * - keepAlive: 是否缓存页面
 * - hidden: 是否在菜单中隐藏
 */

const routes = [
  // ==================== 前台页面 ====================
  {
    path: '/front',
    component: () => import('@/layout/FrontLayout.vue'),
    meta: { 
      requiresAuth: false 
    },
    children: [
      {
        path: '',
        name: 'FrontHome',
        component: () => import('@/views/front/index.vue'),
        meta: { 
          title: '前台首页'
        }
      },
      {
        path: 'profile',
        name: 'FrontProfile',
        component: () => import('@/views/front/profile.vue'),
        meta: { 
          title: '个人中心',
          requiresAuth: true
        }
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/auth/Login.vue'),
    meta: { 
      title: '登录',
      requiresAuth: false 
    }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/auth/Register.vue'),
    meta: { 
      title: '注册',
      requiresAuth: false 
    }
  },
  {
    path: '/forgot-password',
    name: 'ForgotPassword',
    component: () => import('@/views/auth/ForgotPassword.vue'),
    meta: { 
      title: '找回密码',
      requiresAuth: false 
    }
  },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    meta: { title: '首页' },
    children: [
      // ==================== 首页 ====================
      {
        path: '/dashboard',
        name: 'Dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        meta: { 
          title: '首页',
          icon: 'HomeFilled',
          keepAlive: true
        }
      },

      // ==================== 系统管理 ====================
      {
        path: '/system',
        redirect: '/system/user',
        meta: { 
          title: '系统管理',
          icon: 'Setting'
        }
      },
      {
        path: '/system/user',
        name: 'User',
        component: () => import('@/views/system/user/index.vue'),
        meta: { 
          title: '用户管理',
          icon: 'User',
          keepAlive: true
        }
      },
      {
        path: '/system/role',
        name: 'Role',
        component: () => import('@/views/system/role/index.vue'),
        meta: { 
          title: '角色管理',
          icon: 'Avatar',
          keepAlive: true
        }
      },
      {
        path: '/system/menu',
        name: 'Menu',
        component: () => import('@/views/system/menu/index.vue'),
        meta: { 
          title: '菜单管理',
          icon: 'Menu',
          keepAlive: true
        }
      },

      // ==================== 数据管理 ====================
      {
        path: '/data',
        redirect: '/data/file',
        meta: { 
          title: '数据管理',
          icon: 'DataLine'
        }
      },
      {
        path: '/data/file',
        name: 'File',
        component: () => import('@/views/data/file/index.vue'),
        meta: { 
          title: '文件管理',
          icon: 'Folder',
          keepAlive: true
        }
      },
      {
        path: '/data/dict',
        name: 'Dict',
        component: () => import('@/views/data/dict/index.vue'),
        meta: { 
          title: '字典管理',
          icon: 'Collection',
          keepAlive: true
        }
      },

      // ==================== 个人中心 ====================
      {
        path: '/profile',
        name: 'Profile',
        component: () => import('@/views/profile/index.vue'),
        meta: { 
          title: '个人中心',
          icon: 'User',
          hidden: true
        }
      }
    ]
  },

  // ==================== 404 页面 ====================
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/views/error/404.vue'),
    meta: { 
      title: '页面不存在',
      requiresAuth: false,
      hidden: true
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  // 路由跳转后滚动到顶部
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0 }
    }
  }
})

// 白名单：不需要登录就可以访问的页面
const whiteList = ['/login', '/register']

// 全局前置守卫
router.beforeEach(async (to, from, next) => {
  // 设置页面标题
  document.title = to.meta.title ? `${to.meta.title} - TechFlow管理系统` : 'TechFlow管理系统'

  const token = localStorage.getItem('token')
  const userStore = useUserStore()

  // 判断是否需要登录
  const requiresAuth = to.meta.requiresAuth !== false

  if (token) {
    // 已登录
    if (to.path === '/login') {
      // 已登录访问登录页，重定向到首页
      next('/dashboard')
    } else {
      // 检查是否有用户信息
      if (!userStore.userInfo) {
        try {
          // 获取用户信息
          await userStore.fetchUserInfo()
          next()
        } catch (error) {
          // 获取用户信息失败，清除token并跳转到登录页
          console.error('获取用户信息失败:', error)
          userStore.token = ''
          localStorage.removeItem('token')
          ElMessage.error('登录状态已过期，请重新登录')
          next(`/login?redirect=${to.path}`)
        }
      } else {
        // 已有用户信息，直接放行
        next()
      }
    }
  } else {
    // 未登录
    if (whiteList.includes(to.path) || !requiresAuth) {
      // 在白名单中或不需要登录，直接放行
      next()
    } else {
      // 需要登录，重定向到登录页
      next(`/login?redirect=${to.path}`)
    }
  }
})

// 全局后置守卫
router.afterEach((to, from) => {
  // 可以在这里添加页面访问统计等逻辑
  console.log(`路由跳转: ${from.path} -> ${to.path}`)
})

// 路由错误处理
router.onError((error) => {
  console.error('路由错误:', error)
  ElMessage.error('页面加载失败，请刷新重试')
})

export default router
