# OSS 用户控制层部分编程接口

参数传递全部使用字符串，所以接口参数类型不再标注。

<!-- TOC -->

- [OSS 用户控制层部分编程接口](#oss-%E7%94%A8%E6%88%B7%E6%8E%A7%E5%88%B6%E5%B1%82%E9%83%A8%E5%88%86%E7%BC%96%E7%A8%8B%E6%8E%A5%E5%8F%A3)
    - [模板](#%E6%A8%A1%E6%9D%BF)
        - [[接口描述]](#%E6%8E%A5%E5%8F%A3%E6%8F%8F%E8%BF%B0)
    - [登录](#%E7%99%BB%E5%BD%95)
        - [检测用户登录信息](#%E6%A3%80%E6%B5%8B%E7%94%A8%E6%88%B7%E7%99%BB%E5%BD%95%E4%BF%A1%E6%81%AF)
    - [注册](#%E6%B3%A8%E5%86%8C)
        - [检测用户名是否可用](#%E6%A3%80%E6%B5%8B%E7%94%A8%E6%88%B7%E5%90%8D%E6%98%AF%E5%90%A6%E5%8F%AF%E7%94%A8)
        - [检测手机号是否可用](#%E6%A3%80%E6%B5%8B%E6%89%8B%E6%9C%BA%E5%8F%B7%E6%98%AF%E5%90%A6%E5%8F%AF%E7%94%A8)
        - [添加新用户](#%E6%B7%BB%E5%8A%A0%E6%96%B0%E7%94%A8%E6%88%B7)
    - [页面共享](#%E9%A1%B5%E9%9D%A2%E5%85%B1%E4%BA%AB)
        - [获取购物车中商品数量](#%E8%8E%B7%E5%8F%96%E8%B4%AD%E7%89%A9%E8%BD%A6%E4%B8%AD%E5%95%86%E5%93%81%E6%95%B0%E9%87%8F)
        - [退出登录](#%E9%80%80%E5%87%BA%E7%99%BB%E5%BD%95)
        - [收藏商品](#%E6%94%B6%E8%97%8F%E5%95%86%E5%93%81)
    - [首页](#%E9%A6%96%E9%A1%B5)
        - [获取分类信息](#%E8%8E%B7%E5%8F%96%E5%88%86%E7%B1%BB%E4%BF%A1%E6%81%AF)
        - [获取商品图像通过一级分类](#%E8%8E%B7%E5%8F%96%E5%95%86%E5%93%81%E5%9B%BE%E5%83%8F%E9%80%9A%E8%BF%87%E4%B8%80%E7%BA%A7%E5%88%86%E7%B1%BB)
    - [商品列表页](#%E5%95%86%E5%93%81%E5%88%97%E8%A1%A8%E9%A1%B5)
        - [通过分类获取商品基本信息](#%E9%80%9A%E8%BF%87%E5%88%86%E7%B1%BB%E8%8E%B7%E5%8F%96%E5%95%86%E5%93%81%E5%9F%BA%E6%9C%AC%E4%BF%A1%E6%81%AF)
        - [通过关键词获取商品基本信息](#%E9%80%9A%E8%BF%87%E5%85%B3%E9%94%AE%E8%AF%8D%E8%8E%B7%E5%8F%96%E5%95%86%E5%93%81%E5%9F%BA%E6%9C%AC%E4%BF%A1%E6%81%AF)
    - [商品详情页](#%E5%95%86%E5%93%81%E8%AF%A6%E6%83%85%E9%A1%B5)
        - [获取商品详细信息](#%E8%8E%B7%E5%8F%96%E5%95%86%E5%93%81%E8%AF%A6%E7%BB%86%E4%BF%A1%E6%81%AF)
        - [获取商品所在店铺信息](#%E8%8E%B7%E5%8F%96%E5%95%86%E5%93%81%E6%89%80%E5%9C%A8%E5%BA%97%E9%93%BA%E4%BF%A1%E6%81%AF)
    - [购物车管理](#%E8%B4%AD%E7%89%A9%E8%BD%A6%E7%AE%A1%E7%90%86)
        - [获取购物车信息（所有商品）](#%E8%8E%B7%E5%8F%96%E8%B4%AD%E7%89%A9%E8%BD%A6%E4%BF%A1%E6%81%AF%E6%89%80%E6%9C%89%E5%95%86%E5%93%81)
        - [添加到购物车](#%E6%B7%BB%E5%8A%A0%E5%88%B0%E8%B4%AD%E7%89%A9%E8%BD%A6)
        - [删除购物车中商品](#%E5%88%A0%E9%99%A4%E8%B4%AD%E7%89%A9%E8%BD%A6%E4%B8%AD%E5%95%86%E5%93%81)
        - [直接修改商品数量](#%E7%9B%B4%E6%8E%A5%E4%BF%AE%E6%94%B9%E5%95%86%E5%93%81%E6%95%B0%E9%87%8F)
    - [结算页](#%E7%BB%93%E7%AE%97%E9%A1%B5)
        - [收货人管理](#%E6%94%B6%E8%B4%A7%E4%BA%BA%E7%AE%A1%E7%90%86)
        - [确认下单](#%E7%A1%AE%E8%AE%A4%E4%B8%8B%E5%8D%95)
    - [收银页](#%E6%94%B6%E9%93%B6%E9%A1%B5)
        - [确认支付](#%E7%A1%AE%E8%AE%A4%E6%94%AF%E4%BB%98)
        - [取消订单](#%E5%8F%96%E6%B6%88%E8%AE%A2%E5%8D%95)
    - [个人中心](#%E4%B8%AA%E4%BA%BA%E4%B8%AD%E5%BF%83)
        - [个人信息管理](#%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E7%AE%A1%E7%90%86)
            - [获取用户信息](#%E8%8E%B7%E5%8F%96%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF)
            - [更新昵称](#%E6%9B%B4%E6%96%B0%E6%98%B5%E7%A7%B0)
            - [更新手机号](#%E6%9B%B4%E6%96%B0%E6%89%8B%E6%9C%BA%E5%8F%B7)
            - [更新性别](#%E6%9B%B4%E6%96%B0%E6%80%A7%E5%88%AB)
            - [更新生日](#%E6%9B%B4%E6%96%B0%E7%94%9F%E6%97%A5)
        - [订单管理](#%E8%AE%A2%E5%8D%95%E7%AE%A1%E7%90%86)
            - [通过订单状态获取订单](#%E9%80%9A%E8%BF%87%E8%AE%A2%E5%8D%95%E7%8A%B6%E6%80%81%E8%8E%B7%E5%8F%96%E8%AE%A2%E5%8D%95)
            - [通过订单号获取订单详情](#%E9%80%9A%E8%BF%87%E8%AE%A2%E5%8D%95%E5%8F%B7%E8%8E%B7%E5%8F%96%E8%AE%A2%E5%8D%95%E8%AF%A6%E6%83%85)
            - [更新订单状态](#%E6%9B%B4%E6%96%B0%E8%AE%A2%E5%8D%95%E7%8A%B6%E6%80%81)
        - [收藏管理](#%E6%94%B6%E8%97%8F%E7%AE%A1%E7%90%86)
            - [获取已收藏商品](#%E8%8E%B7%E5%8F%96%E5%B7%B2%E6%94%B6%E8%97%8F%E5%95%86%E5%93%81)
            - [获取已收藏店铺](#%E8%8E%B7%E5%8F%96%E5%B7%B2%E6%94%B6%E8%97%8F%E5%BA%97%E9%93%BA)
            - [删除已收藏商品](#%E5%88%A0%E9%99%A4%E5%B7%B2%E6%94%B6%E8%97%8F%E5%95%86%E5%93%81)
            - [删除已收藏店铺](#%E5%88%A0%E9%99%A4%E5%B7%B2%E6%94%B6%E8%97%8F%E5%BA%97%E9%93%BA)
        - [收货人管理](#%E6%94%B6%E8%B4%A7%E4%BA%BA%E7%AE%A1%E7%90%86)
            - [获取所有收货人信息](#%E8%8E%B7%E5%8F%96%E6%89%80%E6%9C%89%E6%94%B6%E8%B4%A7%E4%BA%BA%E4%BF%A1%E6%81%AF)
            - [添加收货人](#%E6%B7%BB%E5%8A%A0%E6%94%B6%E8%B4%A7%E4%BA%BA)
            - [修改收货人信息](#%E4%BF%AE%E6%94%B9%E6%94%B6%E8%B4%A7%E4%BA%BA%E4%BF%A1%E6%81%AF)
            - [删除收货人](#%E5%88%A0%E9%99%A4%E6%94%B6%E8%B4%A7%E4%BA%BA)

<!-- /TOC -->

---

## 模板

### [接口描述]

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
    - JSON:  //TODO: 后端开发人员给出一个示例

## 登录

### 检测用户登录信息

- url: /checkUserLogin.action
- parameter list:
    1. username / phone ; 用户名 / 手机号
    1. password         ; 密码
- return:
    1. 成功后重定向至网站首页
    1. 失败后重定向会登录页面
- side-effect:
    - 登录成功后，设置 session 属性
        1. userLoginStatus = "true"
        1. shopHasOpend = "true"         //若该用户已开店
        1. userId = ".."                 //实际用户 id
        1. nickname = ".."               //昵称
        1. shopId = ".."                 //shopHasOpend = "false" 时无意义
        1. userAvatarAddr = ""               //用户头像地址
    - 登录失败后，设置 session 属性
        1. userLoginStatus = "false"

## 注册

### 检测用户名是否可用

- url: /checkUsername.action
- parameter list:
    1. username ; 用户名
- return:
    1. result   ;   "true" 可用, "false" 不可用
- option:
    - JSON: {"result":"true"}

### 检测手机号是否可用

- url: /checkPhone.action
- parameter list:
    1. phone    ; 手机号
- return:
    1. result   ;   "true" 可用, "false" 不可用
- option:
    - JSON: {"result":"true"}

### 添加新用户

- url: /addNewUser.action
- parameter list:
    1. username     ; 用户名
    1. phone        ; 手机号
    1. password     ; 密码
- return:
    1. 成功后重定向至网站首页
    1. 失败后重定向至注册页面
- side-effect:
    - 添加成功后，设置 session 属性
        1. userLoginStatus = "true"
        1. shopHasOpend = "true"         //若该用户已开店
        1. userId = ".."                 //实际用户 id
        1. nickname = ".."               //昵称
        1. shopId = ".."                 //shopHasOpend = false 时无意义

## 页面共享

### 获取购物车中商品数量

- url: /getGoodsNumInShoppingCart.action
- parameter list:
- return:
    - goodsNum           ; 商品数量
- option:
    - JSON:  {"goodsNum":"3"}

### 退出登录

- url: /userLogout.action
- parameter list:
- return:
    1. session 属性 userLoginStatus = "setAttr"  //设置为垃圾值
    1. result   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

### 收藏商品

- url: /addGoodsToFavorite.action
- parameter list:
    - goodsId
- return:
    1. result   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

## 首页

### 获取分类信息

- url: /getCategory.action
- parameter list:
- return:
    - levelOne[]          ; 第一级分类数组
        - name            ; 第一级分类名
        - levelTwo[]      ; 该一级分类下的二级分类数组
            - name        ; 二级分类名

### 获取商品图像通过一级分类

- url: /getGoodsImagesByLevelOne.action
- parameter list:
    1. levelOne           ; 一级分类名
    1. imageNum           ; 需要的图像数量，选销量最高的商品的图像
- return:
    1. goods[]
        - goodsId         ; 商品编号
        - imageAddr       ; 商品图像
- option:
    - JSON:

## 商品列表页

### 通过分类获取商品基本信息

- url: /getGoodsBriefByCategory.action
- parameter list:
    1. levelOne        ; 一级分类
    1. levelTwo        ; 二级分类（可选）
    1. maxNumInOnPage  ; 一页中最多含有的商品数量
    1. pageNum     ; 要获取的页码
    1. sortByPrice     ; 'true' 先按价格，再按销量排序；'false' 按销量由高到低排序
    1. priceUp         ; sortByPrice = 'true' 时有效。priceUp = 'true' 时由低到高排序，'false' 时相反
- return:
    - goods[]
        - goodsId                       ; 商品编号
        - attributeId (随便一个即可)     ; 属性编号
        - goodsName                     ; 商品名
        - goodsDescribe                 ; 商品描述
        - imageAddr                     ; 图像地址
        - sales                         ; 销量
        - price                         ; 价格
- option:
    - JSON:

### 通过关键词获取商品基本信息

- url: /getGoodsBriefByCategory.action
- parameter list:
    1. keyword         ; 关键词
    1. maxNumInOnPage  ; 一页中最多含有的商品数量
    1. pageNum     ; 要获取的页码
    1. sortByPrice     ; 'true' 先按价格，再按销量排序；'false' 按销量由高到低排序
    1. priceUp         ; sortByPrice = 'true' 时有效。priceUp = 'true' 时由低到高排序，'false' 时相反
- return:
    - goods[]
        - goodsId                       ; 商品编号
        - attributeId (随便一个即可)     ; 属性编号
        - goodsName                     ; 商品名
        - goodsDescribe                 ; 商品描述
        - imageAddr                     ; 图像地址
        - sales                         ; 销量
        - price                         ; 价格
- option:
    - JSON:

## 商品详情页

### 获取商品详细信息

- url: /getGoodsDetail.action
- parameter list:
    - goodsId                       ; 商品编号
- return:
    - goods
        - goodsId                   ; 商品编号
        - goodsName                 ; 商品名称
        - goodsDescribe             ; 商品描述
        - discountDeadline          ; 打折截止时间
        - discountRate              ; 打折比例
        - attributes[]
            - attributeId           ; 属性编号
            - attributeValue        ; 属性值
            - price                 ; 价格
            - inventory             ; 库存
        - images[]
            - imageAddr             ; 图像地址
        - levelOne                  ; 所在一级分类
        - levelTwo                  ; 所在二级分类
- option:
    - JSON:

### 获取商品所在店铺信息

- url: /getShopInfoByGoodsId.action
- parameter list:
    - goodsId                       ; 商品编号
- return:
    1. shopName                     ; 店铺名称
    1. shopId                       ; 店铺编号
- option:
    - JSON:

## 购物车管理

### 获取购物车信息（所有商品）

按 shopId 排序
- url: /getShoppingCart.action
- parameter list: none
- return:
    - shop[]                        ; 购物车中商品所在店铺数组
        1. shopId                   ; 店铺编号
        1. shopName                 ; 店铺名称
        1. goodsInThisShop[]        ; 购物车中商品在店铺 shopId 中的商品数组
            1. id                   ; 购物车记录编号
            1. goods
                - goodsId           ; 商品编号
                - goodsName         ; 商品名
                - goodsDescribe     ; 商品描述
                - imageAddr         ; 图像地址
                - goodsAttrs[]      ; 商品属性数组
                    - attributeId        ; 商品属性编号
                    - attributeValue     ; 商品属性值
                    - price              ; 商品价格，打折以后的
                    - inventory          ; 库存量
            1. attributeId        ; 欲购属性编号
            1. goodsNum           ; 欲购数量
- option:
    - JSON:

### 添加到购物车

- url: /addToShoppingCart.action
- parameter list:
    1. goodsId             ; 商品编号
    1. attributeId         ; 属性编号
    1. goodsNum            ; 商品数量
- return:
    1. result ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

### 删除购物车中商品

- url: /deleteFromShoppingCart.action
- parameter list:
    1. id             ; 购物车记录编号
- return:
    1. result ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

### 直接修改商品数量

- url: /updateGoodsNumInShoppingCart.action
- parameter list:
    1. id           ; 购物车记录编号
    1. goodsNum     ; 新的商品数量
- return:
    1. goodsNum     ; 失败返回旧值，成功返回新值
- option:
    - JSON: {"goodsNum":"1"}

## 结算页

### 收货人管理

见个人中心收货人管理

### 确认下单

- url: /confirmOrder.action
- parameter list:
    - shop[]                    ; 店铺列表
        - shopId                ; 店铺编号
        - attributeIds[]        ; 属性编号列表
            - attributeId       ; 属性编号
- return:
    1. orderId[]                ; 订单编号列表
        - orderId               ; 订单编号

## 收银页

### 确认支付

- url: /payOrder.action
- parameter list:
    1. orderId[]                ; 订单编号列表
        - orderId               ; 订单编号
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

### 取消订单

- url: /cancelOrder.action
- parameter list:
    1. orderId[]                ; 订单编号列表
        - orderId               ; 订单编号
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

## 个人中心

### 个人信息管理
####　获取用户信息

- url: /getUserInfo.action
- parameter list:
- return:
    1. username
    1. nickname
    1. phone
    1. sex
    1. birthday
- option:
    - JSON:

#### 更新昵称

- url: /updateNickname.action
- parameter list:
    1. nickname                 ; 新昵称
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

#### 更新手机号

- url: /updatePhone.action
- parameter list:
    1. phone                    ; 手机号
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

#### 更新性别

- url: /updateSex.action
- parameter list:
    1. sex                      ; 性别
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

#### 更新生日

- url: /updateBirthday.action
- parameter list:
    1. birthday                 ; 生日
- return:
    1. result                   ; "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

### 订单管理

#### 通过订单状态获取订单

- url: /getOrderByStatus.action
- parameter list:
    1. orderStatus
    1. maxNumInOnPage
    1. pageNum
- return:
    1. orderId
    1. orderStatus
- option:
    - JSON:  //TODO: 后端开发人员给出一个示例

#### 通过订单号获取订单详情

- url: /getOrderById.action
- parameter list:
    1. orderId ; 订单号
- return:
    1. orderId               ; 订单号
    1. trackingNumber        ; 运单号
    1. orderStatus           ; 订单状态
    1. username              ; 下单用户用户名
    1. receiver              ; 收货人
        - name
        - address
        - phone
    1. goodsInOrder[]        ; 订单中商品数组
        - goods
            - goodsId        ; 商品编号
            - goodsName      ; 商品名
            - goodsDescribe  ; 商品描述
            - imageAddr      ; 图像地址
        - attributeValue     ; 商品属性值
        - goodsNum           ; 购买数量
        - actualPrice        ; 成交价
    1. payMethod    ; 支付方式
    1. orderTime    ; 下单时间
    1. completeTime ; 完成时间
    1. annotation   ; 备注
    1. total        ; 总金额
- option:
    - JSON:

#### 更新订单状态

- url: /updateOrderStatus.action
- parameter list:
    1. orderId              ; 订单编号
    1. orderStatus          ; 未更改之前的订单状态
- return:
    1. result               ; "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

### 收藏管理

#### 获取已收藏商品

以时间排序（收藏编号），最近的优先。
- url: /getGoodsFavorite.action
- parameter list:
    1. maxNumInOnPage  ; 一页中最多含有的商品数量
    1. pageNum         ; 要获取的页码
- return:
    - goods[]
        - goodsId                       ; 商品编号
        - goodsName                     ; 商品名
        - goodsDescribe                 ; 商品描述
        - imageAddr                     ; 图像地址
        - sales                         ; 销量
        - price                         ; 价格
- option:
    - JSON:

#### 获取已收藏店铺

以时间排序（收藏编号），最近的优先。
- url: /getShopFavorite.action
- parameter list:
    1. maxNumInOnPage  ; 一页中最多含有的店铺数量
    1. pageNum         ; 要获取的页码
- return:
    - shops[]
        - shopId                       ; 商品编号
        - shopName                     ; 商品名
- option:
    - JSON:

#### 删除已收藏商品

- url: /deleteGoodsFromFavorite.action
- parameter list:
    1. goodsId              ; 商品编号
- return:
    1. result               ; "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

#### 删除已收藏店铺

- url: /deleteGoodsFromFavorite.action
- parameter list:
    1. shopId              ; 商品编号
- return:
    1. result               ; "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

### 收货人管理

#### 获取所有收货人信息

- url: /getReceivers.action
- parameter list:
- return:
    - receivers[]
        1. receiverId               ; 收货人编号
        1. receiverName             ; 收货人姓名
        1. receiverAddress          ; 收货人地址
        1. receiverPhone            ; 收货人手机号
- option:
    - JSON:

#### 添加收货人

- url: /addReceiver.action
- parameter list:
    1. receiverId               ; 收货人编号
    1. receiverName             ; 收货人姓名
    1. receiverAddress          ; 收货人地址
    1. receiverPhone            ; 收货人手机号
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

#### 修改收货人信息

- url: /modifyReceiver.action
- parameter list:
    1. receiverId               ; 收货人编号
    1. receiverName             ; 收货人姓名
    1. receiverAddress          ; 收货人地址
    1. receiverPhone            ; 收货人手机号
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}

####　删除收货人

- url: /deleteReceiver.action
- parameter list:
    1. receiverId               ; 收货人编号
- return:
    1. result                   ;   "true" 成功, "false" 失败
- option:
    - JSON: {"result":"true"}
