CREATE TABLE address_book
(
    id            BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    user_id       BIGINT      NOT NULL COMMENT '用户id',
    consignee     VARCHAR(50) NULL COMMENT '收货人',
    sex           VARCHAR(2) NULL COMMENT '性别',
    phone         VARCHAR(11) NOT NULL COMMENT '手机号',
    province_code VARCHAR(12) NULL COMMENT '省级区划编号',
    province_name VARCHAR(32) NULL COMMENT '省级名称',
    city_code     VARCHAR(12) NULL COMMENT '市级区划编号',
    city_name     VARCHAR(32) NULL COMMENT '市级名称',
    district_code VARCHAR(12) NULL COMMENT '区级区划编号',
    district_name VARCHAR(32) NULL COMMENT '区级名称',
    detail        VARCHAR(200) NULL COMMENT '详细地址',
    label         VARCHAR(100) NULL COMMENT '标签',
    is_default    TINYINT(1) DEFAULT 0  NOT NULL COMMENT '默认 0 否 1是',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='地址簿';

CREATE TABLE category
(
    id          BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    type        INT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
    name        VARCHAR(32)   NOT NULL COMMENT '分类名称',
    sort        INT DEFAULT 0 NOT NULL COMMENT '顺序',
    status      INT NULL COMMENT '分类状态 0:禁用，1:启用',
    create_time datetime NULL COMMENT '创建时间',
    update_time datetime NULL COMMENT '更新时间',
    create_user BIGINT NULL COMMENT '创建人',
    update_user BIGINT NULL COMMENT '修改人',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='菜品及套餐分类';

CREATE TABLE dish
(
    id            BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    name          VARCHAR(32) NOT NULL COMMENT '菜品名称',
    category_id   BIGINT      NOT NULL COMMENT '菜品分类id',
    price         DECIMAL(10, 2) NULL COMMENT '菜品价格',
    image         VARCHAR(255) NULL COMMENT '图片',
    `description` VARCHAR(255) NULL COMMENT '描述信息',
    status        INT DEFAULT 1 NULL COMMENT '0 停售 1 起售',
    create_time   datetime NULL COMMENT '创建时间',
    update_time   datetime NULL COMMENT '更新时间',
    create_user   BIGINT NULL COMMENT '创建人',
    update_user   BIGINT NULL COMMENT '修改人',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='菜品';

CREATE TABLE dish_flavor
(
    id      BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    dish_id BIGINT NOT NULL COMMENT '菜品',
    name    VARCHAR(32) NULL COMMENT '口味名称',
    value   VARCHAR(255) NULL COMMENT '口味数据list',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='菜品口味关系表';

CREATE TABLE employee
(
    id          BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    name        VARCHAR(32)   NOT NULL COMMENT '姓名',
    username    VARCHAR(32)   NOT NULL COMMENT '用户名',
    password    VARCHAR(64)   NOT NULL COMMENT '密码',
    phone       VARCHAR(11)   NOT NULL COMMENT '手机号',
    sex         VARCHAR(2)    NOT NULL COMMENT '性别',
    id_number   VARCHAR(18)   NOT NULL COMMENT '身份证号',
    status      INT DEFAULT 1 NOT NULL COMMENT '状态 0:禁用，1:启用',
    create_time datetime NULL COMMENT '创建时间',
    update_time datetime NULL COMMENT '更新时间',
    create_user BIGINT NULL COMMENT '创建人',
    update_user BIGINT NULL COMMENT '修改人',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='员工信息';

CREATE TABLE order_detail
(
    id          BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    name        VARCHAR(32) NULL COMMENT '名字',
    image       VARCHAR(255) NULL COMMENT '图片',
    order_id    BIGINT         NOT NULL COMMENT '订单id',
    dish_id     BIGINT NULL COMMENT '菜品id',
    setmeal_id  BIGINT NULL COMMENT '套餐id',
    dish_flavor VARCHAR(50) NULL COMMENT '口味',
    number      INT DEFAULT 1  NOT NULL COMMENT '数量',
    amount      DECIMAL(10, 2) NOT NULL COMMENT '金额',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='订单明细表';

CREATE TABLE orders
(
    id                      BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    number                  VARCHAR(50) NULL COMMENT '订单号',
    status                  INT DEFAULT 1  NOT NULL COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
    user_id                 BIGINT         NOT NULL COMMENT '下单用户',
    address_book_id         BIGINT         NOT NULL COMMENT '地址id',
    order_time              datetime       NOT NULL COMMENT '下单时间',
    checkout_time           datetime NULL COMMENT '结账时间',
    pay_method              INT DEFAULT 1  NOT NULL COMMENT '支付方式 1微信,2支付宝',
    pay_status              TINYINT(4) DEFAULT 0  NOT NULL COMMENT '支付状态 0未支付 1已支付 2退款',
    amount                  DECIMAL(10, 2) NOT NULL COMMENT '实收金额',
    remark                  VARCHAR(100) NULL COMMENT '备注',
    phone                   VARCHAR(11) NULL COMMENT '手机号',
    address                 VARCHAR(255) NULL COMMENT '地址',
    user_name               VARCHAR(32) NULL COMMENT '用户名称',
    consignee               VARCHAR(32) NULL COMMENT '收货人',
    cancel_reason           VARCHAR(255) NULL COMMENT '订单取消原因',
    rejection_reason        VARCHAR(255) NULL COMMENT '订单拒绝原因',
    cancel_time             datetime NULL COMMENT '订单取消时间',
    estimated_delivery_time datetime NULL COMMENT '预计送达时间',
    delivery_status         TINYINT(1) DEFAULT 1  NOT NULL COMMENT '配送状态  1立即送出  0选择具体时间',
    delivery_time           datetime NULL COMMENT '送达时间',
    pack_amount             INT NULL COMMENT '打包费',
    tableware_number        INT NULL COMMENT '餐具数量',
    tableware_status        TINYINT(1) DEFAULT 1  NOT NULL COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='订单表';

CREATE TABLE setmeal
(
    id            BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    category_id   BIGINT         NOT NULL COMMENT '菜品分类id',
    name          VARCHAR(32)    NOT NULL COMMENT '套餐名称',
    price         DECIMAL(10, 2) NOT NULL COMMENT '套餐价格',
    status        INT DEFAULT 1 NULL COMMENT '售卖状态 0:停售 1:起售',
    `description` VARCHAR(255) NULL COMMENT '描述信息',
    image         VARCHAR(255) NULL COMMENT '图片',
    create_time   datetime NULL COMMENT '创建时间',
    update_time   datetime NULL COMMENT '更新时间',
    create_user   BIGINT NULL COMMENT '创建人',
    update_user   BIGINT NULL COMMENT '修改人',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='套餐';

CREATE TABLE setmeal_dish
(
    id         BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    setmeal_id BIGINT NULL COMMENT '套餐id',
    dish_id    BIGINT NULL COMMENT '菜品id',
    name       VARCHAR(32) NULL COMMENT '菜品名称 （冗余字段）',
    price      DECIMAL(10, 2) NULL COMMENT '菜品单价（冗余字段）',
    copies     INT NULL COMMENT '菜品份数',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='套餐菜品关系';

CREATE TABLE shopping_cart
(
    id          BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    name        VARCHAR(32) NULL COMMENT '商品名称',
    image       VARCHAR(255) NULL COMMENT '图片',
    user_id     BIGINT         NOT NULL COMMENT '主键',
    dish_id     BIGINT NULL COMMENT '菜品id',
    setmeal_id  BIGINT NULL COMMENT '套餐id',
    dish_flavor VARCHAR(50) NULL COMMENT '口味',
    number      INT DEFAULT 1  NOT NULL COMMENT '数量',
    amount      DECIMAL(10, 2) NOT NULL COMMENT '金额',
    create_time datetime NULL COMMENT '创建时间',
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='购物车';

CREATE TABLE user
(
    id          BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键',
    openid      VARCHAR(45) NULL COMMENT '微信用户唯一标识',
    name        VARCHAR(32) NULL COMMENT '姓名',
    phone       VARCHAR(11) NULL COMMENT '手机号',
    sex         VARCHAR(2) NULL COMMENT '性别',
    id_number   VARCHAR(18) NULL COMMENT '身份证号',
    avatar      VARCHAR(500) NULL COMMENT '头像',
    create_time datetime NULL,
    CONSTRAINT `PRIMARY` PRIMARY KEY (id)
) COMMENT ='用户信息';

ALTER TABLE category
    ADD CONSTRAINT idx_category_name UNIQUE (name);

ALTER TABLE dish
    ADD CONSTRAINT idx_dish_name UNIQUE (name);

ALTER TABLE setmeal
    ADD CONSTRAINT idx_setmeal_name UNIQUE (name);

ALTER TABLE employee
    ADD CONSTRAINT idx_username UNIQUE (username);