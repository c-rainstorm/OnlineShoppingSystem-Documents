# eclipse 配置指北

<!-- TOC -->

- [eclipse 配置指北](#eclipse-%E9%85%8D%E7%BD%AE%E6%8C%87%E5%8C%97)
    - [Git 配置更改](#git-%E9%85%8D%E7%BD%AE%E6%9B%B4%E6%94%B9)
    - [添加代码规范配置文件](#%E6%B7%BB%E5%8A%A0%E4%BB%A3%E7%A0%81%E8%A7%84%E8%8C%83%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)
    - [自动补全](#%E8%87%AA%E5%8A%A8%E8%A1%A5%E5%85%A8)
    - [获取工程文件](#%E8%8E%B7%E5%8F%96%E5%B7%A5%E7%A8%8B%E6%96%87%E4%BB%B6)
    - [导入工程以后应该达到的效果](#%E5%AF%BC%E5%85%A5%E5%B7%A5%E7%A8%8B%E4%BB%A5%E5%90%8E%E5%BA%94%E8%AF%A5%E8%BE%BE%E5%88%B0%E7%9A%84%E6%95%88%E6%9E%9C)
    - [Tomcat 配置](#tomcat-%E9%85%8D%E7%BD%AE)
        - [配置环境变量（已经做过的可以跳过）](#%E9%85%8D%E7%BD%AE%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F%E5%B7%B2%E7%BB%8F%E5%81%9A%E8%BF%87%E7%9A%84%E5%8F%AF%E4%BB%A5%E8%B7%B3%E8%BF%87)
        - [配置 Tomcat 到 eclipse](#%E9%85%8D%E7%BD%AE-tomcat-%E5%88%B0-eclipse)

<!-- /TOC -->

---

## Git 配置更改

- `~/.gitconfig` 中 `savecrlf = true --> autocrlf = true` **（仅限 Windows 平台）**

## 添加代码规范配置文件

1. 从文档库根目录获取 `GroupNineStyle.xml`。
1. Windows --> Preferences --> Java --> Code Style --> Formatter.
    - 点击 `Import`, 导入 `GroupNineStyle.xml`。
    - `Apply`。
1. Windows --> Preferences --> Java --> Editor --> Save Actions.
    - 选中 `Perform the selected actions on save`。
    - 选中 `Format source code`。
    - 选中 `Format all lines`。
    - `Apply`。

## 自动补全

- Windows --> Preferences --> Java --> Editor --> Content Asist.
- Auto activation triggers for Java 后面的文本框内容改为
    - .abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ    

## 获取工程文件

1. `git clone git@github.com:c-rainstorm/OnlineShoppingSystem.git`。

## 导入工程以后应该达到的效果

- 进入 `project --> Properties`
1. Resource --> Text file encoding 为 UTF-8。
1. Java Code Style --> Formatter --> Active profile 为 `GroupNineStyle`。
1. Java Editor --> Save Actions --> Format all lines 被选中。

## Tomcat 配置

### 配置环境变量（已经做过的可以跳过）

1. 获取 [Tomcat 8.0](http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.0.39/bin/apache-tomcat-8.0.39-windows-x64.zip)
1. 添加环境变量
    - `JAVA_HOME` -- JDK 根目录
    - `CATALINA_HOME` -- Tomcat 根目录。

### 配置 Tomcat 到 eclipse

1. Window --> show view --> servers
1. 点击选项卡中出现的连接
1. server type 为 `Tomcat v8.0 Server`, next -->
1. 如果右边有已经配置的工程，则将其删除。Finish -->
1. 右击已经创建的服务器， open -->
1. Server Locations --> Use Tomcat installation
1. 保存
