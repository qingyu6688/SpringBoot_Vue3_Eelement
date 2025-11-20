package com.example.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.entity.User;

/**
 * 用户服务接口
 */
public interface UserService extends IService<User> {

    /**
     * 根据用户名查询用户
     */
    User getByUsername(String username);

    /**
     * 根据邮箱查询用户
     */
    User getByEmail(String email);

    /**
     * 用户登录
     */
    User login(String username, String password);
}
