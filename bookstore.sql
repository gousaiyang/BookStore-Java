-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-05-02 11:16:31
-- 服务器版本： 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--
CREATE DATABASE IF NOT EXISTS `bookstore` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `bookstore`;

-- --------------------------------------------------------

--
-- 表的结构 `bookcategory`
--

CREATE TABLE IF NOT EXISTS `bookcategory` (
  `bc_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的关联 `bookcategory`:
--   `book_id`
--       `books` -> `book_id`
--   `category_id`
--       `categories` -> `category_id`
--

-- --------------------------------------------------------

--
-- 表的结构 `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `book_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `press` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` int(11) unsigned NOT NULL COMMENT '单位：分',
  `stock` int(11) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的关联 `books`:
--

--
-- 转存表中的数据 `books`
--

INSERT INTO `books` (`book_id`, `name`, `image`, `author`, `press`, `price`, `stock`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'MySQL：从删库到跑路', NULL, '', '', 6530, 3, '听说最近数据库界忽然流传起来一本书，叫《MySQL：从删库到跑路》。\n我看了前几章节，大概介绍的暗黑界的程序员怎么写坑，怎么悄无声息甩锅给老实忠厚的程序员，还有最后怎么删除数据库之后遁入尘世不见踪影，手法之巧妙，策略之精巧，简直就是删库于无形之中。\n记得第一章有段序是这样写的“来呀 快活呀 反正有大把bug”，我看后吓出一身冷汗。', '2017-05-02 08:28:00', '2017-05-02 08:28:00', NULL),
(2, '黑客攻防：从入门到入狱', NULL, '', '', 8860, 5, '', '2017-05-02 08:30:22', '2017-05-02 08:30:22', NULL),
(3, 'PHP：世界上最好的语言', NULL, '', '', 2880, 20, '某女：你能让这个论坛的人都吵起来，我今晚就跟你走。 \n某软件工程师：PHP是最好的语言！ \n某论坛炸锅了，各种吵架... \n某女：服了你了，我们走吧，你想干啥都行。\n某软件工程师：今天不行，我一定要说服他们，PHP必须是最好的语言 。\n某女：.......', '2017-05-02 08:34:11', '2017-05-02 08:34:11', '2017-05-02 08:46:11'),
(4, 'Java编程思想', NULL, 'Bruce Eckel  著    陈昊鹏  译', '机械工业出版社', 8640, 100, '本书赢得了全球程序员的广泛赞誉，即使是最晦涩的概念，在Bruce Eckel的文字亲和力和小而直接的编程示例面前也会化解于无形。从Java的基础语法到最高级特性（深入的面向对象概念、多线程、自动项目构建、单元测试和调试等），本书都能逐步指导你轻松掌握。\n从本书获得的各项大奖以及来自世界各地的读者评论中，不难看出这是一本经典之作。本书的作者拥有多年教学经验，对C、C++以及Java语言都有独到、深入的见解，以通俗易懂及小而直接的示例解释了一个个晦涩抽象的概念。本书共22章，包括操作符、控制执行流程、访问权限控制、复用类、多态、接口、通过异常处理错误、字符串、泛型、数组、容器深入研究、JavaI/O系统、枚举类型、并发以及图形化用户界面等内容。这些丰富的内容，包含了Java语言基础语法以及高级特性，适合各个层次的Java程序员阅读，同时也是高等院校讲授面向对象程序设计语言以及Java语言的绝佳教材和参考书。', '2017-05-02 08:37:57', '2017-05-02 08:38:08', NULL),
(5, '深入理解计算机系统（原书第3版）', NULL, '(美) Randal E.Bryant', '机械工业出版社', 11120, 200, '本书主要介绍了计算机系统的基本概念，包括最底层的内存中的数据表示、流水线指令的构成、虚拟存储器、编译系统、动态加载库，以及用户应用等。书中提供了大量实际操作，可以帮助读者更好地理解程序执行的方式，改进程序的执行效率。此书以程序员的视角全面讲解了计算机系统，深入浅出地介绍了处理器、编译器、操作系统和网络环境，是这一领域的权威之作。\n本书适合作为计算机及相关专业的本科生教材，同时也适用于编程人员参考阅读。', '2017-05-02 08:41:20', '2017-05-02 08:41:20', NULL),
(6, '活着', NULL, '余华', '作家出版社', 1000, 25, '《活着》是一部充满血泪的小说。余华通过一位中国农民的苦难生活讲述了人如何去承受巨大的苦难；讲述了眼泪的丰富和宽广；讲述了绝望的不存在：讲述了人是为了活着本身而活着…… \n《活着》这部小说荣获意大利格林扎纳·卡佛文学奖*奖项(1998年 )，台湾《中国时报》10本好书奖(1994年)，香港“博益”15本好书奖 (1990年)；并入选香港《亚洲周刊》评选的“20世纪中文小说百年百强” ；入选中国百位批评家和文学编辑评选的“九十年代*有影响的10部作品 ”。', '2017-05-02 08:43:29', '2017-05-02 08:43:29', NULL),
(7, '津巴多普通心理学（原书第7版）', NULL, '（美） 菲利普·津巴多、 （美） 罗伯特·约翰逊、（美） 薇薇安·麦卡恩', '中国人民大学出版社', 8930, 150, '享誉全球的心理学大师、“当代心理学的形象与声音”菲利普·津巴多主笔，凝聚作者50多年第一手教育经验。\n北京师范大学、清华大学、浙江大学、西南大学、南京大学、东北师范大学心理学名师联袂推荐。清华大学普通心理学主讲钱静倾情翻译。\n自从2008 年前一版《津巴多普通心理学》中文版出版以来，心理学经历了巨大的改变。从前一版教材到现在的第7版，津巴多教授历时8年做出了近60%的更新，加入了大量新的研究发展以及全新的案例。\n以问题串联概念，构建系统的知识网络，让学习更符合认知规律，帮助不爱学习的学生也能爱上心理学。\n强调批判性思维。总结6大批判性思维技能，引领读者深入思考14个富有争议性的心理学问题，不仅介绍心理学知识，更注重培养心理学的思维方式。\n参与性强。设有“亲自实践”“生活中的心理学”等富有参与性的专栏，鼓励学生学以致用，在生活实践中加深对心理学的理解。\n语言幽默，形式多样。来自生活方方面面的案例让心理学变得好用又有趣；每章末尾还附有津巴多教授主持的26集科教片《探索心理学》的节目链接及观看指南。读者评价这是比小说还好看的教材。', '2017-05-02 08:46:03', '2017-05-02 08:46:03', NULL),
(8, '<script>alert(''xss!'')</script>', NULL, '<script>alert(''xss!'')</script>', '<script>alert(''xss!'')</script>', 10, 1, '<script>alert(''xss!'')</script>', '2017-05-02 08:47:36', '2017-05-02 08:47:36', NULL),
(9, '''; drop database bookstore --', NULL, '''; drop database bookstore --', '''; drop database bookstore --', 20, 2, '''; drop database bookstore --', '2017-05-02 08:48:14', '2017-05-02 08:48:44', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的关联 `categories`:
--

-- --------------------------------------------------------

--
-- 表的结构 `orderitems`
--

CREATE TABLE IF NOT EXISTS `orderitems` (
  `oi_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `quantity` int(11) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的关联 `orderitems`:
--   `order_id`
--       `orders` -> `order_id`
--   `book_id`
--       `books` -> `book_id`
--

--
-- 转存表中的数据 `orderitems`
--

INSERT INTO `orderitems` (`oi_id`, `order_id`, `book_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 3, '2017-05-02 10:00:00', '2017-05-02 10:00:00'),
(2, 1, 1, 1, '2017-05-02 10:00:00', '2017-05-02 10:00:00'),
(3, 1, 7, 5, '2017-05-02 10:00:00', '2017-05-02 10:00:00'),
(4, 2, 5, 8, '2017-05-02 10:00:00', '2017-05-02 10:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_paid` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的关联 `orders`:
--   `user_id`
--       `users` -> `user_id`
--

--
-- 转存表中的数据 `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `is_paid`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2017-05-02 10:00:00', '2017-05-02 10:00:00'),
(2, 3, 0, '2017-05-02 10:00:00', '2017-05-02 10:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `nickname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role` tinyint(1) unsigned NOT NULL COMMENT '0为顾客，1为管理员',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的关联 `users`:
--

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `nickname`, `role`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', '123456', '系统管理员', 1, '2017-05-02 08:53:21', '2017-05-02 08:53:21', NULL),
(2, 'zhang_3', '333333', '张三', 0, '2017-05-02 08:58:07', '2017-05-02 08:58:07', NULL),
(3, 'lisi-4', '444444', '李四', 0, '2017-05-02 09:02:12', '2017-05-02 09:02:35', NULL),
(4, 'deleteme', 'deleteme', 'deleteme', 1, '2017-05-02 09:03:15', '2017-05-02 09:03:15', '2017-05-02 09:06:02'),
(5, 'hello_from_xss', 'xssxss', '<script>alert(''xss!'')</script>', 0, '2017-05-02 09:04:14', '2017-05-02 09:04:14', NULL),
(6, 'Hacker', 'hacker', ''' or 1=1 --', 0, '2017-05-02 09:05:05', '2017-05-02 09:05:53', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookcategory`
--
ALTER TABLE `bookcategory`
  ADD PRIMARY KEY (`bc_id`),
  ADD KEY `FK_Reference_4` (`book_id`),
  ADD KEY `FK_Reference_5` (`category_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`oi_id`),
  ADD KEY `FK_Reference_2` (`order_id`),
  ADD KEY `FK_Reference_3` (`book_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `FK_Reference_1` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookcategory`
--
ALTER TABLE `bookcategory`
  MODIFY `bc_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `oi_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- 限制导出的表
--

--
-- 限制表 `bookcategory`
--
ALTER TABLE `bookcategory`
  ADD CONSTRAINT `FK_Reference_4` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `FK_Reference_5` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- 限制表 `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `FK_Reference_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `FK_Reference_3` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`);

--
-- 限制表 `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_Reference_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
