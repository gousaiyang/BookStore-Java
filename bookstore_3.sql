-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2017-06-01 05:44:28
-- 服务器版本： 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore_3`
--

-- --------------------------------------------------------

--
-- 表的结构 `Book`
--

CREATE TABLE `Book` (
  `book_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `press` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` int(11) UNSIGNED NOT NULL COMMENT '单位：分',
  `stock` int(11) UNSIGNED NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `Book`
--

INSERT INTO `Book` (`book_id`, `name`, `image`, `author`, `press`, `price`, `stock`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'MySQL：从删库到跑路', '127aa37c079312a930e820cbe2e2794be70e9d16_1496288119675_904.jpg', '', '', 6530, 1, '听说最近数据库界忽然流传起来一本书，叫《MySQL：从删库到跑路》。\n我看了前几章节，大概介绍的暗黑界的程序员怎么写坑，怎么悄无声息甩锅给老实忠厚的程序员，还有最后怎么删除数据库之后遁入尘世不见踪影，手法之巧妙，策略之精巧，简直就是删库于无形之中。\n记得第一章有段序是这样写的“来呀 快活呀 反正有大把bug”，我看后吓出一身冷汗。', '2017-05-02 08:28:00', '2017-06-01 03:35:21', NULL),
(2, '黑客攻防：从入门到入狱', '7e10feca133ddc0376a576fc71e3ece163abbec2_1496288132553_961.jpg', '', '', 8860, 5, '', '2017-05-02 08:30:22', '2017-06-01 03:35:34', NULL),
(3, 'PHP：世界上最好的语言', '', '', '', 2880, 20, '某女：你能让这个论坛的人都吵起来，我今晚就跟你走。 \n某软件工程师：PHP是最好的语言！ \n某论坛炸锅了，各种吵架... \n某女：服了你了，我们走吧，你想干啥都行。\n某软件工程师：今天不行，我一定要说服他们，PHP必须是最好的语言 。\n某女：.......', '2017-05-02 08:34:11', '2017-05-02 08:34:11', '2017-05-02 08:46:11'),
(4, 'Java编程思想', '07cafe83ce4581ed1a270079fbfd04a16c6093f6_1496288143105_623.jpg', 'Bruce Eckel  著    陈昊鹏  译', '机械工业出版社', 8640, 97, '本书赢得了全球程序员的广泛赞誉，即使是最晦涩的概念，在Bruce Eckel的文字亲和力和小而直接的编程示例面前也会化解于无形。从Java的基础语法到最高级特性（深入的面向对象概念、多线程、自动项目构建、单元测试和调试等），本书都能逐步指导你轻松掌握。\n从本书获得的各项大奖以及来自世界各地的读者评论中，不难看出这是一本经典之作。本书的作者拥有多年教学经验，对C、C++以及Java语言都有独到、深入的见解，以通俗易懂及小而直接的示例解释了一个个晦涩抽象的概念。本书共22章，包括操作符、控制执行流程、访问权限控制、复用类、多态、接口、通过异常处理错误、字符串、泛型、数组、容器深入研究、JavaI/O系统、枚举类型、并发以及图形化用户界面等内容。这些丰富的内容，包含了Java语言基础语法以及高级特性，适合各个层次的Java程序员阅读，同时也是高等院校讲授面向对象程序设计语言以及Java语言的绝佳教材和参考书。', '2017-05-02 08:37:57', '2017-06-01 03:35:44', NULL),
(5, '深入理解计算机系统（原书第3版）', '49a5678220e26a62c8819d3a355c1e09de266462_1496288152474_638.jpg', '(美) Randal E.Bryant', '机械工业出版社', 11120, 199, '本书主要介绍了计算机系统的基本概念，包括最底层的内存中的数据表示、流水线指令的构成、虚拟存储器、编译系统、动态加载库，以及用户应用等。书中提供了大量实际操作，可以帮助读者更好地理解程序执行的方式，改进程序的执行效率。此书以程序员的视角全面讲解了计算机系统，深入浅出地介绍了处理器、编译器、操作系统和网络环境，是这一领域的权威之作。\n本书适合作为计算机及相关专业的本科生教材，同时也适用于编程人员参考阅读。', '2017-05-02 08:41:20', '2017-06-01 03:35:54', NULL),
(6, '活着', '3c04096a078abc67f6690ca1c9c5db7f1af701ff_1496288162718_338.jpg', '余华', '作家出版社', 1000, 25, '《活着》是一部充满血泪的小说。余华通过一位中国农民的苦难生活讲述了人如何去承受巨大的苦难；讲述了眼泪的丰富和宽广；讲述了绝望的不存在：讲述了人是为了活着本身而活着…… \n《活着》这部小说荣获意大利格林扎纳·卡佛文学奖*奖项(1998年 )，台湾《中国时报》10本好书奖(1994年)，香港“博益”15本好书奖 (1990年)；并入选香港《亚洲周刊》评选的“20世纪中文小说百年百强” ；入选中国百位批评家和文学编辑评选的“九十年代*有影响的10部作品 ”。', '2017-05-02 08:43:29', '2017-06-01 03:36:04', NULL),
(7, '津巴多普通心理学（原书第7版）', 'ddec559241cd6fc3ac6100730566f9016aaa326c_1496288172253_523.jpg', '（美） 菲利普·津巴多、 （美） 罗伯特·约翰逊、（美） 薇薇安·麦卡恩', '中国人民大学出版社', 8930, 145, '享誉全球的心理学大师、“当代心理学的形象与声音”菲利普·津巴多主笔，凝聚作者50多年第一手教育经验。\n北京师范大学、清华大学、浙江大学、西南大学、南京大学、东北师范大学心理学名师联袂推荐。清华大学普通心理学主讲钱静倾情翻译。\n自从2008 年前一版《津巴多普通心理学》中文版出版以来，心理学经历了巨大的改变。从前一版教材到现在的第7版，津巴多教授历时8年做出了近60%的更新，加入了大量新的研究发展以及全新的案例。\n以问题串联概念，构建系统的知识网络，让学习更符合认知规律，帮助不爱学习的学生也能爱上心理学。\n强调批判性思维。总结6大批判性思维技能，引领读者深入思考14个富有争议性的心理学问题，不仅介绍心理学知识，更注重培养心理学的思维方式。\n参与性强。设有“亲自实践”“生活中的心理学”等富有参与性的专栏，鼓励学生学以致用，在生活实践中加深对心理学的理解。\n语言幽默，形式多样。来自生活方方面面的案例让心理学变得好用又有趣；每章末尾还附有津巴多教授主持的26集科教片《探索心理学》的节目链接及观看指南。读者评价这是比小说还好看的教材。', '2017-05-02 08:46:03', '2017-06-01 03:36:14', NULL),
(8, '<script>alert(\'xss!\')</script>', 'f7a7dcbd8d7db9c5b34f21ee44e5c44b6d606bf2_1496288184336_331.png', '<script>alert(\'xss!\')</script>', '<script>alert(\'xss!\')</script>', 10, 1, '<script>alert(\'xss!\')</script>', '2017-05-02 08:47:36', '2017-06-01 03:36:26', NULL),
(9, '\'; drop database bookstore --', '6b2d096f02e4f303bb5023f909a492ae2e499aaf_1496288195805_589.jpg', '\'; drop database bookstore --', '\'; drop database bookstore --', 20, 2, '\'; drop database bookstore --', '2017-05-02 08:48:14', '2017-06-01 03:36:37', NULL),
(28, '一本书', '', '没有作者', '没有出版社', 0, 0, '没有介绍\n就是没有介绍', '2017-06-01 03:04:09', '2017-06-01 03:04:09', '2017-06-01 03:04:20');

-- --------------------------------------------------------

--
-- 表的结构 `BookCategory`
--

CREATE TABLE `BookCategory` (
  `bc_id` int(11) UNSIGNED NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `book_id` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `BookCategory`
--

INSERT INTO `BookCategory` (`bc_id`, `category_id`, `book_id`, `created_at`) VALUES
(1, 1, 1, '2017-05-27 16:00:00'),
(2, 2, 1, '2017-05-27 16:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `Category`
--

CREATE TABLE `Category` (
  `category_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `Category`
--

INSERT INTO `Category` (`category_id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '计算机', '2017-05-27 16:00:00', '2017-05-27 16:00:00', NULL),
(2, '搞笑', '2017-05-27 16:00:00', '2017-05-27 16:00:00', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `Order`
--

CREATE TABLE `Order` (
  `order_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `is_paid` tinyint(1) UNSIGNED NOT NULL,
  `total_price` int(11) UNSIGNED DEFAULT NULL COMMENT '单位：分',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `Order`
--

INSERT INTO `Order` (`order_id`, `user_id`, `is_paid`, `total_price`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 77100, '2017-05-02 10:00:00', '2017-05-28 15:34:53', NULL),
(2, 2, 0, NULL, '2017-05-02 10:00:00', '2017-05-02 10:00:00', NULL),
(3, 1, 1, 6530, '2017-05-28 15:34:53', '2017-05-31 14:24:24', '2017-05-31 14:27:24'),
(4, 1, 1, 11120, '2017-05-31 14:24:24', '2017-05-31 15:12:08', '2017-05-31 15:45:45'),
(5, 1, 0, NULL, '2017-05-31 15:12:08', '2017-05-31 15:12:08', NULL),
(6, 12, 0, NULL, '2017-05-31 15:13:19', '2017-05-31 15:13:19', NULL),
(7, 13, 0, NULL, '2017-06-01 03:00:27', '2017-06-01 03:00:27', NULL),
(8, 14, 0, NULL, '2017-06-01 03:00:58', '2017-06-01 03:00:58', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `OrderItem`
--

CREATE TABLE `OrderItem` (
  `item_id` int(11) UNSIGNED NOT NULL,
  `order_id` int(11) UNSIGNED NOT NULL,
  `book_id` int(11) UNSIGNED NOT NULL,
  `price` int(11) UNSIGNED DEFAULT NULL COMMENT '单位：分',
  `quantity` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `OrderItem`
--

INSERT INTO `OrderItem` (`item_id`, `order_id`, `book_id`, `price`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 8640, 3, '2017-05-02 10:00:00', '2017-05-28 15:34:53'),
(2, 1, 1, 6530, 1, '2017-05-02 10:00:00', '2017-05-28 15:34:53'),
(3, 1, 7, 8930, 5, '2017-05-02 10:00:00', '2017-05-28 15:34:53'),
(4, 2, 5, NULL, 3, '2017-05-02 10:00:00', '2017-05-31 14:50:37'),
(7, 2, 1, NULL, 5, '2017-05-28 13:43:02', '2017-05-28 13:43:02'),
(13, 3, 1, 6530, 1, '2017-05-31 14:24:20', '2017-05-31 14:24:24'),
(15, 4, 5, 11120, 1, '2017-05-31 15:07:59', '2017-05-31 15:12:08');

-- --------------------------------------------------------

--
-- 表的结构 `User`
--

CREATE TABLE `User` (
  `user_id` int(11) UNSIGNED NOT NULL,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `nickname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance` int(11) UNSIGNED NOT NULL COMMENT '单位：分',
  `role` tinyint(1) UNSIGNED NOT NULL COMMENT '0为普通用户，1为管理员',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `User`
--

INSERT INTO `User` (`user_id`, `username`, `password`, `nickname`, `avatar`, `balance`, `role`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', '系统管理员', '787fac4d19cdbae82a3edcf33499f274511d67cd_1496288208500_229.jpg', 905250, 1, '2017-05-02 08:53:21', '2017-06-01 03:36:49', NULL),
(2, 'testuser', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', '测试用户', '61fd4edca58a0fa8376e50a1edebd35c2bcde346_1496288216285_386.png', 100000, 0, '2017-05-02 08:58:07', '2017-06-01 03:36:57', NULL),
(12, 'newuser', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', '小王', '', 66600, 0, '2017-05-31 15:13:19', '2017-05-31 15:13:19', NULL),
(13, 'hacker1', 'e7d3685715939842749cc27b38d0ccb9706d4d14a5304ef9eee093780eab5df9', '<script>alert(\'xss\');</script>', 'f7a7dcbd8d7db9c5b34f21ee44e5c44b6d606bf2_1496288230350_460.png', 0, 0, '2017-06-01 03:00:26', '2017-06-01 03:37:12', NULL),
(14, 'hacker2', 'e7d3685715939842749cc27b38d0ccb9706d4d14a5304ef9eee093780eab5df9', '\' or 1=1 --', '6b2d096f02e4f303bb5023f909a492ae2e499aaf_1496288239650_173.jpg', 0, 0, '2017-06-01 03:00:58', '2017-06-01 03:37:21', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Book`
--
ALTER TABLE `Book`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `BookCategory`
--
ALTER TABLE `BookCategory`
  ADD PRIMARY KEY (`bc_id`),
  ADD KEY `FK_Reference_4` (`book_id`),
  ADD KEY `FK_Reference_5` (`category_id`);

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `Order`
--
ALTER TABLE `Order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `FK_Reference_1` (`user_id`);

--
-- Indexes for table `OrderItem`
--
ALTER TABLE `OrderItem`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `FK_Reference_2` (`order_id`),
  ADD KEY `FK_Reference_3` (`book_id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `Book`
--
ALTER TABLE `Book`
  MODIFY `book_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- 使用表AUTO_INCREMENT `BookCategory`
--
ALTER TABLE `BookCategory`
  MODIFY `bc_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `Category`
--
ALTER TABLE `Category`
  MODIFY `category_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `Order`
--
ALTER TABLE `Order`
  MODIFY `order_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- 使用表AUTO_INCREMENT `OrderItem`
--
ALTER TABLE `OrderItem`
  MODIFY `item_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- 使用表AUTO_INCREMENT `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- 限制导出的表
--

--
-- 限制表 `BookCategory`
--
ALTER TABLE `BookCategory`
  ADD CONSTRAINT `FK_Reference_4` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`),
  ADD CONSTRAINT `FK_Reference_5` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- 限制表 `Order`
--
ALTER TABLE `Order`
  ADD CONSTRAINT `FK_Reference_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- 限制表 `OrderItem`
--
ALTER TABLE `OrderItem`
  ADD CONSTRAINT `FK_Reference_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  ADD CONSTRAINT `FK_Reference_3` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
