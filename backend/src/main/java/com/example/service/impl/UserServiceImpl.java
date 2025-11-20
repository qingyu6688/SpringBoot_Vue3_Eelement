package com.example.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.common.ResultCode;
import com.example.entity.User;
import com.example.exception.ServiceException;
import com.example.mapper.UserMapper;
import com.example.service.UserService;
import org.springframework.stereotype.Service;

/**
 * 用户服务实现类
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public User getByUsername(String username) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, username);
        return this.getOne(wrapper);
    }

    @Override
    public User getByEmail(String email) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getEmail, email);
        return this.getOne(wrapper);
    }

    @Override
    public User login(String username, String password) {
        User user = getByUsername(username);
        if (user == null) {
            throw new ServiceException(ResultCode.USER_NOT_EXIST);
        }
        if (!password.equals(user.getPassword())) {
            throw new ServiceException(ResultCode.USERNAME_OR_PASSWORD_ERROR);
        }
        if (user.getStatus() == 0) {
            throw new ServiceException(ResultCode.USER_ACCOUNT_DISABLED);
        }
        return user;
    }
}
