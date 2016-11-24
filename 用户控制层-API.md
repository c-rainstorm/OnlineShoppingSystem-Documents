# OSS 用户控制层部分编程接口

<!-- TOC -->

- [OSS 用户控制层部分编程接口](#oss-%E7%94%A8%E6%88%B7%E6%8E%A7%E5%88%B6%E5%B1%82%E9%83%A8%E5%88%86%E7%BC%96%E7%A8%8B%E6%8E%A5%E5%8F%A3)
    - [模板](#%E6%A8%A1%E6%9D%BF)
    - [登录](#%E7%99%BB%E5%BD%95)
    - [注册](#%E6%B3%A8%E5%86%8C)
    - [订单](#%E8%AE%A2%E5%8D%95)

<!-- /TOC -->

---

## 模板

1. [接口描述]
    - url: [url]
    - parameter list:
        1. [parameter name] ; [parameter description]
        1. [parameter name] ; [parameter description]
        1. [parameter name] ; [parameter description]
    - return: 
        1. [dataItem] ; [description]
        1. [dataItem] ; [description]
        1. [dataItem] ; [description]
    - option:
        - JSON: 
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

## 登录

1. 检测用户登录信息
    - url: /checkUserLogin.action
    - parameter list:
        1. username ; 用户名
        1. phone ; 手机号       username == phone
        1. password ; 密码
    - return:
        1. true ; 验证成功
        1. false; 验证失败
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

##　注册

1. 检测用户名是否可用
    - url: /checkUsername.action
    - parameter list:
        1. username ; 用户名
    - return:
        1. true ; 用户名可用
        1. false; 用户名不可用
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 检测手机号是否可用
    - url: /checkPhone.action
    - parameter list:
        1. phone ; 手机号
    - return:
        1. true ; 手机号可用
        1. false; 手机号不可用
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 添加新用户
    - url: /addNewUser.action
    - parameter list:
        1. username ; 用户名
        1. phone ; 手机号
        1. password ; 密码
    - return:
        1. true ; 添加成功
        1. false; 添加失败
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

## 订单

1. 通过订单号获取订单详情
    - url: /getOrderById.action
    - parameter list:
        1. orderId ; 订单号
    - return:
        - 关于该订单的所有信息
            - //TODO: 继续补充
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish