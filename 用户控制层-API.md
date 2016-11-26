# OSS 用户控制层部分编程接口

<!-- TOC -->

- [OSS 用户控制层部分编程接口](#oss-%E7%94%A8%E6%88%B7%E6%8E%A7%E5%88%B6%E5%B1%82%E9%83%A8%E5%88%86%E7%BC%96%E7%A8%8B%E6%8E%A5%E5%8F%A3)
    - [模板](#%E6%A8%A1%E6%9D%BF)
    - [登录](#%E7%99%BB%E5%BD%95)
    - [注册](#%E6%B3%A8%E5%86%8C)
    - [浏览信息](#%E6%B5%8F%E8%A7%88%E4%BF%A1%E6%81%AF)
    - [购物车管理](#%E8%B4%AD%E7%89%A9%E8%BD%A6%E7%AE%A1%E7%90%86)
    - [订单管理](#%E8%AE%A2%E5%8D%95%E7%AE%A1%E7%90%86)

<!-- /TOC -->

---

## 模板

1. [接口描述]
    - url: [url]
    - parameter list:
        1. [type]:[parameter name] ; [parameter description]
        1. [type]:[parameter name] ; [parameter description]
        1. [type]:[parameter name] ; [parameter description]
    - return: 
        1. [type]:[dataItem] ; [description]
        1. [type]:[dataItem] ; [description]
        1. [type]:[dataItem] ; [description]
    - option:
        - JSON:  //TODO: 后端开发人员给出一个示例
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

## 登录

1. 检测用户登录信息
    - url: /checkUserLogin.action
    - parameter list:
        1. String:username ; 用户名
        1. String:phone ; 手机号       username == phone
        1. String:password ; 密码
    - return:
        1. String:result ;   成功后返回网站首页, 否则返回 false
    - option:
        - JSON: {"result":"true"}
    - side-effect:
        - 登录成功后，设置 session 属性
            1. userLoginStatus = true      
            1. shopHasOpend = true         //若该用户已开店   
            1. username = ..               //实际用户名
            1. registrationId = ..         //shopHasOpend = false 时无意义
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish


## 注册

1. 检测用户名是否可用
    - url: /checkUsername.action
    - parameter list:
        1. String:username ; 用户名
    - return:
        1. String:result ;   true 可用, false 不可用
    - option:
        - JSON: {"result":"true"}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 检测手机号是否可用
    - url: /checkPhone.action
    - parameter list:
        1. String:phone ; 手机号
    - return:
        1. String:result ;   true 可用, false 不可用
    - option:
        - JSON: {"result":"true"}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 添加新用户
    - url: /addNewUser.action
    - parameter list:
        1. String:username ; 用户名
        1. String:phone ; 手机号
        1. String:password ; 密码
    - return:
        1. String:result ;   成功后返回网站首页, 否则返回 false
    - option:
        - JSON: {"result":"false"}
    - side-effect:
        - 添加成功后，设置 session 属性
            1. userLoginStatus = true      
            1. shopHasOpend = true         //若该用户已开店   
            1. username = ..               //实际用户名
            1. registrationId = ..         //shopHasOpend = false 时无意义
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish
        
## 浏览信息

1. 获取分类信息
    - url: /getCa
    - parameter list:
        1. [type]:[parameter name] ; [parameter description]
        1. [type]:[parameter name] ; [parameter description]
        1. [type]:[parameter name] ; [parameter description]
    - return: 
        1. [type]:[dataItem] ; [description]
        1. [type]:[dataItem] ; [description]
        1. [type]:[dataItem] ; [description]
    - option:
        - JSON:  //TODO: 后端开发人员给出一个示例
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 获取 5 个大类下
 
## 购物车管理

1. 获取购物车信息（所有商品）

   若本地购物车为不为空，则先将本地购物车添加到数据库并**清空该 Cookie**。

    - url: /getShoppingCart.action
    - parameter list:
        1. String:username     ; 用户名
        1. Cookie:localShoppingCart  ; 本地购物车  
            - 数据格式：[{"goodsId": 11111, "attributeId": 11, "goodsNum": 3}]
    - return:
        - []                          ; 购物车中商品数组
            1. long:id                ; 购物车记录编号
            1. goods 
                - String:goodsName      ; 商品名
                - String:goodsDescribe  ; 商品描述
                - goodsImages[]  ; 图像地址数组
                    - String:imageAddr  ; 图像地址
                - goodsAttrs[]   ; 商品属性数组
                    - int:attributeid        ; 商品属性编号
                    - String:attributeValue     ; 商品属性值
                    - double:price              ; 商品价格，打折以后的
                    - int:inventory          ; 库存量
            1. int:attributeid        ; 欲购属性编号
            1. int:goodsNum           ; 欲购数量
    - option:
        - JSON: 
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 添加到购物车
    - url: /addToShoppingCart.action
    - parameter list:
        1. String:username         ; 用户名
        1. int:goodsId             ; 商品编号
        1. int:attributeid         ; 属性编号
        1. int:goodsNum            ; 商品数量
    - return:
        1. String:result ;   true 成功, false 失败
    - option:
        - JSON: {"result":"true"}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 删除购物车中商品
    - url: /deleteFromShoppingCart.action
    - parameter list:
        1. String:username     ; 用户名
        1. long:id             ; 购物车记录编号
    - return:
        1. String:result ;   true 成功, false 失败
    - option:
        - JSON: {"result":"true"}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 商品数量加一
    - url: /increaseGoodsNumInShoppingCart.action
    - parameter list:
        1. String:username     ; 用户名
        1. long:id             ; 购物车记录编号
    - return: 
        1. int:goodsNum ; 失败返回旧值，成功返回新值
    - option:
        - JSON: {"goodsNum":1}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 商品数量减一
    - url: /decreaseGoodsNumInShoppingCart.action
    - parameter list:
        1. String:username     ; 用户名
        1. long:id             ; 购物车记录编号
    - return: 
        1. int:goodsNum ; 失败返回旧值，成功返回新值
    - option:
        - JSON: {"goodsNum":1}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 直接修改商品数量
    - url: /updateGoodsNumInShoppingCart.action
    - parameter list:
        1. String:username     ; 用户名
        1. long:id             ; 购物车记录编号
        1. int:goodsNum        ; 新的商品数量
    - return: 
        1. int:goodsNum ; 失败返回旧值，成功返回新值
    - option:
        - JSON: {"goodsNum":1}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish

1. 修改商品属性
    - url: /updateGoodsAttrInShoppingCart.action
    - parameter list:
        1. String:username     ; 用户名
        1. long:id             ; 购物车记录编号
        1. int:attributeid     ; 新的商品属性
    - return: 
        1. int:attributeid ; 失败返回旧值，成功返回新值
    - option:
        - JSON: {"attributeid":1111}
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish


## 订单管理

1. 通过订单号获取订单详情
    - url: /getOrderById.action
    - parameter list:
        1. String:orderId ; 订单号
    - return:
        1. String:orderId      ; 订单号
        1. long:trackingNumber ; 运单号
        1. String:orderStatus  ; 订单状态
        1. receiver     ; 收货人
            - String:name 
            - String:address
            - String:phone
        1. goodsInOrder[] ; 订单中商品数组
            - goods 
                - String:goodsName      ; 商品名
                - String:goodsDescribe  ; 商品描述
                - goodsImages[]         ; 图像地址数组
                    - String:imageAddr  ; 图像地址 
            - String:attributeValue     ; 商品属性值
            - int:goodsNum              ; 购买数量
            - double:actualPrice        ; 成交价
        1. String:payMethod    ; 支付方式
        1. String:orderTime    ; 下单时间
        1. String:completeTime ; 完成时间
        1. String:annotation   ; 备注
        1. double:total        ; 总金额
    - option:
        - JSON:  
    - status:
        1. [ ] 前端  ; Unfinish
        1. [ ] 后端  ; Unfinish
        1. [ ] 联调  ; Unfinish