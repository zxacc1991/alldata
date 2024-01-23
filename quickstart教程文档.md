### 数据市场功能介绍
数据市场的功能主要包含两个部分：数据接口和数据服务，当然还有很多功能（字段脱敏，调用日志等）是对前面两者功能的赋能增强，下面我们来逐一进行介绍。

**一. 数据接口**

  数据接口主要是针对已有数据源进行接口配置，可对单表或者多表进行配置，形成API对外开放调用，同时也会对API的调用频率以及接口鉴权进行管理。下面我们来详细介绍一下。

**1. 数据接口介绍**

1.1 属性配置

点击接口新增，在属性配置页面中可填写API的调用路径，请求方式，返回格式，还可以根据实际情况来配置接口的限流频率以及IP黑名单。

> 注意：这里的API版本以及API路径会形成接口的调用路径，后面接口调用时会提及。

如下图所示：
![接口新增](https://github.com/alldatacenter/alldata/assets/7332353/86dfcffc-bc4b-48b2-a074-b48916d7db70)

1.2 执行配置

执行配置页面中可以填写配置方式（表引导模式/脚本模式），数据源，数据库表以及字段列。我们可以按照配置方式拆分为两种进行介绍。

1.2.1 表引导模式

表引导模式可以选择已有数据源中的某张表进行接口入参、出参的配置，如下图所示：
![表引导模式1](https://github.com/alldatacenter/alldata/assets/7332353/229dc59d-5c03-4dd1-82af-49eb3fb3c06d)

选择好入参出参后点击下一步，会进入参数配置，这里可以配置入参、出参的描述，默认值等属性。（这里需要全部填写，不然会报错）
如下图所示：
![参数配置](https://github.com/alldatacenter/alldata/assets/7332353/93413bf6-f2cd-406d-b351-4d687240c843)

> 配置好参数，点击右上角保存即可。

1.2.2 脚本模式

在第二步中如果我们选择脚本模式的话，需要再选择一个数据源，然后进行自定义的SQL编写。这种模式可以进行多表关联查询，灵活性较高。
如下图所示：
![表引导模式sql](https://github.com/alldatacenter/alldata/assets/7332353/5903ed3b-4a2a-41d6-8bd8-f64b63f20ba5)

> SQL编写好后点击**SQL解析**按钮，再点击下一步进入属性配置页面，该页面与表引导模式相同，可以参照上面的描述。

1.2.3 接口发布

接口配置完成后，返回接口列表界面，选择已配置的接口，点击“操作”按钮，选择发布，接口即可上线使用。

**2. 接口调用介绍**

根据上述步骤，我们可以配置一个接口，那么下面我们就来介绍如何进行接口调用的介绍。

2.1 接口调用参数查看

在接口详情中，我们可以看到右上角有接口示例，
如下图所示：
![接口示例](https://github.com/alldatacenter/alldata/assets/7332353/a9273a24-9fe9-4224-a3a9-c3ac870c6758)

> 点击接口示例后，就会跳转至接口调用参数的界面，
如下图所示：
![接口参数](https://github.com/alldatacenter/alldata/assets/7332353/65c15334-2602-4dd1-8842-aefe768173ba)
![入参](https://github.com/alldatacenter/alldata/assets/7332353/0ebf17bc-37b2-4aa0-a68c-4d8eba77a1ca)

> 上图中的调用路径：**/services/v1.0/data/query** 就是我上述操作配置的接口URI。  

> 这里api_key和secret_key是接口的鉴权参数，ACCOUNT_ID是接口的入参。

> **需要注意，虽然我们接口中配置的入参只有ACCOUNT_ID，但是系统默认需要带上pageNum与pageSize字段，不然会报错！！！**

请求示例：
```
1）请求URL：http://{ip}:{port}/services/v1.0/data/query
2）header参数：
        api_key：uIPhPFuFlhGQvTHDP0W7QaxkMxp/B1bs
        secret_key：P07BXDeCIWA=
3）请求入参：
        {
              "ACCOUNT_ID":"10000",
              "pageSize":"10",
              "pageNum":"1"
        }
4）输出参数：
        {
          "success":true,
          "code":200,
          "msg":"操作成功",
          "data":{
                   "pageNum":1,
                   "pageSize":20,
                   "total":1,
                   "data":[
                         {
                               "ACCOUNT_PARENT":"100",
                              "ACCOUNT_DESCRIPTION":"该账号为测试账号",
                              "ACCOUNT_TYPE":"游客",
                              "ACCOUNT_ROLLUP":"1000"
                         }
                   ]
           }
        }
```

> 注意：这里的ip为你服务器上部署data-market-service-mapping的ip，port的话默认为8823。

**二.  数据服务**
