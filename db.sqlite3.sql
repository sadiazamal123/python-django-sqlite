BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "projects_tag" (
	"name"	varchar(200) NOT NULL,
	"created"	datetime NOT NULL,
	"id"	char(32) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "projects_project_tags" (
	"id"	integer NOT NULL,
	"project_id"	char(32) NOT NULL,
	"tag_id"	char(32) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("tag_id") REFERENCES "projects_tag"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("project_id") REFERENCES "projects_project"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "projects_project" (
	"title"	varchar(200) NOT NULL,
	"description"	text,
	"demo_link"	varchar(2000),
	"source_link"	varchar(2000),
	"created"	datetime NOT NULL,
	"id"	char(32) NOT NULL,
	"vote_ratio"	integer,
	"vote_total"	integer,
	"featured_image"	varchar(100),
	"owner_id"	char(32),
	PRIMARY KEY("id"),
	FOREIGN KEY("owner_id") REFERENCES "users_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "users_profile" (
	"name"	varchar(200),
	"email"	varchar(500),
	"short_intro"	varchar(200),
	"bio"	text,
	"profile_image"	varchar(100),
	"social_github"	varchar(200),
	"social_twitter"	varchar(200),
	"social_linkedin"	varchar(200),
	"social_youtube"	varchar(200),
	"social_website"	varchar(200),
	"created"	datetime NOT NULL,
	"id"	char(32) NOT NULL,
	"user_id"	integer UNIQUE,
	"username"	varchar(200),
	"location"	varchar(200),
	PRIMARY KEY("id"),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "users_skill" (
	"name"	varchar(200),
	"description"	text,
	"created"	datetime NOT NULL,
	"id"	char(32) NOT NULL,
	"owner_id"	char(32),
	PRIMARY KEY("id"),
	FOREIGN KEY("owner_id") REFERENCES "users_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "projects_review" (
	"body"	text,
	"value"	varchar(200) NOT NULL,
	"created"	datetime NOT NULL,
	"id"	char(32) NOT NULL,
	"project_id"	char(32) NOT NULL,
	"owner_id"	char(32),
	PRIMARY KEY("id"),
	FOREIGN KEY("project_id") REFERENCES "projects_project"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("owner_id") REFERENCES "users_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "users_message" (
	"name"	varchar(200),
	"email"	varchar(200),
	"subject"	varchar(200),
	"body"	text NOT NULL,
	"is_read"	bool,
	"created"	datetime NOT NULL,
	"id"	char(32) NOT NULL,
	"recipient_id"	char(32),
	"sender_id"	char(32),
	PRIMARY KEY("id"),
	FOREIGN KEY("recipient_id") REFERENCES "users_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("sender_id") REFERENCES "users_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2021-11-23 11:45:28.954424');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2021-11-23 11:45:29.085934');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2021-11-23 11:45:29.186844');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2021-11-23 11:45:29.241595');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2021-11-23 11:45:29.308931');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2021-11-23 11:45:29.375335');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2021-11-23 11:45:29.421899');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2021-11-23 11:45:29.478704');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2021-11-23 11:45:29.519595');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2021-11-23 11:45:29.573599');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2021-11-23 11:45:29.614490');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2021-11-23 11:45:29.658375');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2021-11-23 11:45:29.760617');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2021-11-23 11:45:29.825248');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2021-11-23 11:45:30.080277');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2021-11-23 11:45:30.155977');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2021-11-23 11:45:30.215973');
INSERT INTO "django_migrations" VALUES (18,'projects','0001_initial','2021-11-23 11:45:30.252147');
INSERT INTO "django_migrations" VALUES (19,'projects','0002_auto_20211123_1548','2021-11-23 11:45:30.381864');
INSERT INTO "django_migrations" VALUES (20,'sessions','0001_initial','2021-11-23 11:45:30.462647');
INSERT INTO "django_migrations" VALUES (21,'projects','0003_project_featured_image','2021-11-23 17:18:28.010054');
INSERT INTO "django_migrations" VALUES (22,'users','0001_initial','2021-11-24 15:32:05.310479');
INSERT INTO "django_migrations" VALUES (23,'users','0002_profile_username','2021-11-24 16:40:42.885951');
INSERT INTO "django_migrations" VALUES (24,'projects','0004_project_owner','2021-11-24 16:40:43.122304');
INSERT INTO "django_migrations" VALUES (25,'users','0003_auto_20211125_0024','2021-11-24 18:25:07.825417');
INSERT INTO "django_migrations" VALUES (26,'projects','0005_auto_20211226_2044','2021-12-26 14:44:40.737102');
INSERT INTO "django_migrations" VALUES (27,'projects','0006_alter_project_options','2021-12-27 09:05:15.660028');
INSERT INTO "django_migrations" VALUES (28,'users','0004_message','2021-12-27 09:05:15.735314');
INSERT INTO "django_admin_log" VALUES (1,'2021-11-23 11:53:56.041737','1','sadiazamal','[{"changed": {"fields": ["Username", "First name", "Last name"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (2,'2021-11-23 12:07:31.254963','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (3,'2021-11-23 12:07:40.467738','dcdaa203-dfac-4e6b-921c-36037b7eb1bd','Portfolio Website','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (4,'2021-11-23 12:08:05.532223','d77e97ff-19b5-4117-82b9-fcc3f30f248b','Mumble Social Network','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (5,'2021-11-23 12:10:42.321340','29de3015-67be-42cb-be79-efea7c11cbd4','React','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (6,'2021-11-23 12:11:01.422459','72de1a96-e1fd-43a7-b85c-9c6860e9444d','Django','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (7,'2021-11-23 12:11:07.132860','989fa010-bf6f-49d9-8785-d8a3447d79aa','Python','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (8,'2021-11-23 12:11:18.777958','2b755d15-e43b-4c20-93fb-a996895e1b6d','JavaScript','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (9,'2021-11-23 12:12:22.369457','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Tags"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (10,'2021-11-23 12:13:30.744824','55b22e0c-9924-4010-b0cb-bc7a9b7a9b76','up','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (11,'2021-11-23 12:14:08.724721','d77e97ff-19b5-4117-82b9-fcc3f30f248b','Mumble Social Network','[{"changed": {"fields": ["Tags"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (12,'2021-11-23 12:14:24.052283','dcdaa203-dfac-4e6b-921c-36037b7eb1bd','Portfolio Website','[{"changed": {"fields": ["Tags"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (13,'2021-11-23 12:16:47.262218','e34bfaf9-f07c-41eb-8ba9-a47280286a0f','Code Sniper','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (14,'2021-11-23 12:17:11.986128','68ae69b1-f8be-4fcc-bd57-07370e8d95bf','Yogo Vive','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (15,'2021-11-23 12:17:52.011040','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Vote total", "Vote ratio"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (16,'2021-11-23 12:18:17.244224','dcdaa203-dfac-4e6b-921c-36037b7eb1bd','Portfolio Website','[{"changed": {"fields": ["Vote total", "Vote ratio"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (17,'2021-11-23 12:18:37.686506','d77e97ff-19b5-4117-82b9-fcc3f30f248b','Mumble Social Network','[{"changed": {"fields": ["Vote total", "Vote ratio"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (18,'2021-11-23 12:26:36.105656','6a7b79d5-a23a-42f2-87bc-7e06ba3bc4fe','up','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (19,'2021-11-23 12:26:52.972774','acc1aa95-ab57-49d3-93e7-962a1245da7c','down','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (20,'2021-11-23 12:58:26.932673','68ae69b1-f8be-4fcc-bd57-07370e8d95bf','Yogo Vive','[{"changed": {"fields": ["Description"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (21,'2021-11-23 12:58:37.647071','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Description"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (22,'2021-11-23 12:59:08.722468','e34bfaf9-f07c-41eb-8ba9-a47280286a0f','Code Sniper','[{"changed": {"fields": ["Description"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (23,'2021-11-23 12:59:13.330528','d77e97ff-19b5-4117-82b9-fcc3f30f248b','Mumble Social Network','[{"changed": {"fields": ["Description"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (24,'2021-11-23 12:59:17.807304','dcdaa203-dfac-4e6b-921c-36037b7eb1bd','Portfolio Website','[{"changed": {"fields": ["Description"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (25,'2021-11-23 17:25:06.840233','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Featured image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (26,'2021-11-23 17:32:17.388899','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Featured image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (27,'2021-11-23 17:35:07.028531','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Featured image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (28,'2021-11-23 17:35:59.526913','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Featured image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (29,'2021-11-24 10:03:00.381425','e34bfaf9-f07c-41eb-8ba9-a47280286a0f','Code Sniper','[{"changed": {"fields": ["Vote total", "Vote ratio"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (30,'2021-11-24 12:46:28.966486','d77e97ff-19b5-4117-82b9-fcc3f30f248b','Mumble Social Network','[{"changed": {"fields": ["Demo link"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (31,'2021-11-24 12:47:50.304040','d77e97ff-19b5-4117-82b9-fcc3f30f248b','Mumble Social Network','[{"changed": {"fields": ["Source link"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (32,'2021-11-24 12:51:55.466227','dcdaa203-dfac-4e6b-921c-36037b7eb1bd','Portfolio Website','[{"changed": {"fields": ["Demo link"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (33,'2021-11-24 12:53:10.376247','dcdaa203-dfac-4e6b-921c-36037b7eb1bd','Portfolio Website','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (34,'2021-11-24 15:45:39.523248','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"added": {}}]',10,1,1);
INSERT INTO "django_admin_log" VALUES (35,'2021-11-24 15:57:11.904383','2','johnsina','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (36,'2021-11-24 15:58:49.838197','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','johnsina','[{"added": {}}]',10,1,1);
INSERT INTO "django_admin_log" VALUES (37,'2021-11-24 16:44:49.358073','dcdaa203-dfac-4e6b-921c-36037b7eb1bd','Portfolio Website','[{"changed": {"fields": ["Owner"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (38,'2021-11-24 16:45:16.622792','e34bfaf9-f07c-41eb-8ba9-a47280286a0f','Code Sniper','[{"changed": {"fields": ["Owner"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (39,'2021-11-24 16:45:22.490502','e0e7c804-0f0e-40de-8e62-7462c6e30fdf','Ecommerce Website','[{"changed": {"fields": ["Owner"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (40,'2021-11-24 16:45:32.296532','d77e97ff-19b5-4117-82b9-fcc3f30f248b','Mumble Social Network','[{"changed": {"fields": ["Owner"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (41,'2021-11-24 16:45:38.764529','68ae69b1-f8be-4fcc-bd57-07370e8d95bf','Yogo Vive','[{"changed": {"fields": ["Owner"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (42,'2021-11-24 18:17:30.752799','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Bio"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (43,'2021-11-24 18:27:41.137879','6825ee51-ebb2-4b40-97de-26f6e03a3470','React','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (44,'2021-11-24 18:28:12.638203','a411a22c-618d-47c5-9418-f2f34e03ab04','Django','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (45,'2021-11-24 18:28:38.850166','a411a22c-618d-47c5-9418-f2f34e03ab04','Django','[{"changed": {"fields": ["Description"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (46,'2021-11-24 18:29:05.728266','67c2ab3a-7b2a-4f6a-89a7-79275a4e8740','Python','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (47,'2021-11-24 18:29:28.683987','4965d9dc-043c-4e80-82e6-e0f496eea11e','HTML','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (48,'2021-11-24 18:29:38.484498','75db9cb2-41b8-4c3b-9a88-67cb9d7ff2ea','CSS','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (49,'2021-11-24 18:30:17.107246','30d3fef4-d444-4395-b8bd-0282bc179b26','Django','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (50,'2021-11-24 18:30:22.974118','9a38ac06-a9b6-42cb-94d4-100873d92988','Python','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (51,'2021-11-24 18:32:11.475165','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','johnsina','[{"changed": {"fields": ["Username", "Location"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (52,'2021-11-24 18:32:52.649089','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Username", "Location"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (53,'2021-11-25 06:30:45.230412','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (54,'2021-11-25 06:31:31.037788','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (55,'2021-11-25 06:34:53.778632','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (56,'2021-11-25 06:35:45.495398','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','johnsina','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (57,'2021-11-25 06:36:34.227391','2','anisurrahman','[{"changed": {"fields": ["Username"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (58,'2021-11-25 06:37:09.358322','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','anisurrahman','[{"changed": {"fields": ["Username"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (59,'2021-11-25 06:37:34.339932','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','anisurrahman','[{"changed": {"fields": ["Name"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (60,'2021-11-25 06:37:38.344222','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','anisurrahman','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (61,'2021-11-25 06:40:13.942935','9bf01a79-7132-4283-b855-d685f3ea7ac9','tahiyaakhter','[{"added": {}}]',10,1,1);
INSERT INTO "django_admin_log" VALUES (62,'2021-11-25 06:44:28.231844','9bf01a79-7132-4283-b855-d685f3ea7ac9','tahiyaakhter','',10,1,3);
INSERT INTO "django_admin_log" VALUES (63,'2021-11-25 06:47:42.428728','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (64,'2021-11-25 06:57:54.582816','3','tahiyaakhter','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (65,'2021-11-25 06:59:21.624520','3','tahiyaakhter','',4,1,3);
INSERT INTO "django_admin_log" VALUES (66,'2021-11-25 07:00:39.944140','4','tahiyaakhter','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (67,'2021-11-25 07:15:22.750000','456c8fca-ee7b-45ef-9f0f-2bbce00c60d2','tahiyaakhter','',10,1,3);
INSERT INTO "django_admin_log" VALUES (68,'2021-11-25 07:21:11.710399','1','sadiazamal','[]',4,1,2);
INSERT INTO "django_admin_log" VALUES (69,'2021-11-25 07:22:36.234284','1','sadiazamal','[]',4,1,2);
INSERT INTO "django_admin_log" VALUES (70,'2021-12-20 00:27:34.386198','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social github"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (71,'2021-12-21 11:30:17.552922','5','asus','',4,1,3);
INSERT INTO "django_admin_log" VALUES (72,'2021-12-21 11:34:17.405241','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','anisurrahman','[{"changed": {"fields": ["Email"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (73,'2021-12-21 11:41:36.838725','5','fariakhan','[{"changed": {"fields": ["Username", "First name", "Last name", "Email address"]}}]',4,5,2);
INSERT INTO "django_admin_log" VALUES (74,'2021-12-21 11:44:44.095710','cdd5095c-d504-4df9-a802-68c4674bbb3b','fariakhan','[{"changed": {"fields": ["Name", "Email", "Username", "Bio", "Profile image"]}}]',10,5,2);
INSERT INTO "django_admin_log" VALUES (75,'2021-12-21 11:49:18.353804','6','asfatjaman','[{"changed": {"fields": ["Username", "First name", "Last name", "Email address"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (76,'2021-12-21 11:50:05.721884','e2684026-a9fb-4258-8e33-67314faf32e7','asfatjaman','[{"changed": {"fields": ["Name", "Email", "Username"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (77,'2021-12-21 11:55:56.549959','5','fariakhan','[{"changed": {"fields": ["Staff status", "Superuser status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (78,'2021-12-21 11:57:26.146098','7','tahiyakabir','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (79,'2021-12-21 11:57:58.130679','7','tahiyakabir','[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (80,'2021-12-21 11:58:47.776557','8','selinaakhter','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (81,'2021-12-21 11:59:16.117983','8','selinaakhter','[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (82,'2021-12-21 11:59:51.266150','9','sampiper','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (83,'2021-12-21 12:00:10.971799','9','sampiper','[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (84,'2021-12-21 12:01:09.967671','10','dennisivy','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (85,'2021-12-21 12:01:27.432539','10','dennisivy','[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (86,'2021-12-21 12:04:50.103442','ff6507fb-5ef1-4bfb-81f8-21f69168fffa','tahiyakabir','[{"changed": {"fields": ["Name", "Email", "Location", "Short intro", "Bio", "Profile image", "Social github", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (87,'2021-12-21 12:07:31.184096','f2933d6d-d6f9-4fcd-91d1-5f3e49c14587','dennisivy','[{"changed": {"fields": ["Name", "Email", "Location", "Short intro", "Bio", "Profile image", "Social github", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (88,'2021-12-21 12:09:42.133832','e49f505d-5792-4222-ac69-e32412fdc4aa','selinaakhter','[{"changed": {"fields": ["Name", "Email", "Location", "Short intro", "Bio", "Profile image", "Social github", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (89,'2021-12-21 12:15:02.983642','e2684026-a9fb-4258-8e33-67314faf32e7','asfatjaman','[{"changed": {"fields": ["Location", "Short intro", "Bio", "Profile image", "Social github", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (90,'2021-12-21 12:17:44.054546','b7f6ca40-858c-4268-a458-525769606311','sampiper','[{"changed": {"fields": ["Name", "Email", "Location", "Short intro", "Bio", "Profile image", "Social github", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (91,'2021-12-21 12:19:52.861885','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Short intro", "Profile image", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (92,'2021-12-21 12:21:10.803515','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (93,'2021-12-21 12:21:48.122404','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social twitter", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (94,'2021-12-21 12:22:30.214520','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social twitter", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (95,'2021-12-21 12:22:49.330805','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social youtube", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (96,'2021-12-21 12:24:56.570459','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social youtube", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (97,'2021-12-21 12:26:09.658380','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (98,'2021-12-21 12:33:06.462076','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (99,'2021-12-21 12:35:33.910633','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (100,'2021-12-21 12:36:16.352359','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social twitter", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (101,'2021-12-21 12:36:49.610258','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social twitter", "Social youtube"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (102,'2021-12-21 12:40:11.399644','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social twitter", "Social youtube"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (103,'2021-12-21 12:41:48.747259','ff6507fb-5ef1-4bfb-81f8-21f69168fffa','tahiyakabir','[{"changed": {"fields": ["Social twitter"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (104,'2021-12-21 12:48:03.619253','ff6507fb-5ef1-4bfb-81f8-21f69168fffa','tahiyakabir','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (105,'2021-12-21 12:48:17.040708','ff6507fb-5ef1-4bfb-81f8-21f69168fffa','tahiyakabir','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (106,'2021-12-21 12:48:46.908951','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (107,'2021-12-21 12:49:21.631560','f2933d6d-d6f9-4fcd-91d1-5f3e49c14587','dennisivy','[{"changed": {"fields": ["Social twitter"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (108,'2021-12-21 12:49:54.672122','e2684026-a9fb-4258-8e33-67314faf32e7','asfatjaman','[{"changed": {"fields": ["Social twitter"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (109,'2021-12-21 12:50:27.967634','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','anisurrahman','[{"changed": {"fields": ["Social github", "Social twitter", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (110,'2021-12-21 12:51:09.234265','cdd5095c-d504-4df9-a802-68c4674bbb3b','fariakhan','[{"changed": {"fields": ["Social github", "Social twitter", "Social linkedin", "Social website"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (111,'2021-12-21 12:51:19.620582','b7f6ca40-858c-4268-a458-525769606311','sampiper','[{"changed": {"fields": ["Social twitter"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (112,'2021-12-21 12:51:23.799310','e49f505d-5792-4222-ac69-e32412fdc4aa','selinaakhter','[{"changed": {"fields": ["Social twitter"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (113,'2021-12-21 12:55:47.966873','29d640ea-a061-40de-8f62-07e1b16ad24d','sadiazamal','[{"changed": {"fields": ["Location"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (114,'2021-12-21 13:08:19.762091','9a38ac06-a9b6-42cb-94d4-100873d92988','Python','',11,1,3);
INSERT INTO "django_admin_log" VALUES (115,'2021-12-21 13:08:19.789983','30d3fef4-d444-4395-b8bd-0282bc179b26','Django','',11,1,3);
INSERT INTO "django_admin_log" VALUES (116,'2021-12-21 13:22:49.572777','97b8d88f-bc58-42b4-a69b-f6f311f629d8','Node.js','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (117,'2021-12-21 13:25:40.307951','a8dd4313-3bf0-4bc8-94c6-44a8b072b35d','anisurrahman','[{"changed": {"fields": ["Bio"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (118,'2021-12-21 13:46:11.765032','cdd5095c-d504-4df9-a802-68c4674bbb3b','fariakhan','[{"changed": {"fields": ["Location", "Short intro"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (119,'2021-12-21 13:46:20.844269','f2933d6d-d6f9-4fcd-91d1-5f3e49c14587','dennisivy','[{"changed": {"fields": ["Short intro"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (120,'2021-12-21 13:46:31.371385','ff6507fb-5ef1-4bfb-81f8-21f69168fffa','tahiyakabir','[{"changed": {"fields": ["Short intro"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (121,'2021-12-21 13:47:07.969364','e49f505d-5792-4222-ac69-e32412fdc4aa','selinaakhter','[{"changed": {"fields": ["Short intro"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (122,'2021-12-21 13:47:36.300690','b7f6ca40-858c-4268-a458-525769606311','sampiper','[{"changed": {"fields": ["Short intro"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (123,'2021-12-21 13:48:00.450739','e2684026-a9fb-4258-8e33-67314faf32e7','asfatjaman','[{"changed": {"fields": ["Short intro"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (124,'2021-12-26 14:46:07.864901','acc1aa95-ab57-49d3-93e7-962a1245da7c','down','[{"changed": {"fields": ["Owner"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (125,'2021-12-26 14:47:07.010011','6a7b79d5-a23a-42f2-87bc-7e06ba3bc4fe','up','[{"changed": {"fields": ["Owner"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (126,'2021-12-26 14:47:15.280815','55b22e0c-9924-4010-b0cb-bc7a9b7a9b76','up','[{"changed": {"fields": ["Owner"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (127,'2021-12-26 19:14:41.020952','acc1aa95-ab57-49d3-93e7-962a1245da7c','up','[{"changed": {"fields": ["Value"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (128,'2021-12-26 19:17:31.075578','acc1aa95-ab57-49d3-93e7-962a1245da7c','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (129,'2021-12-26 19:29:45.182306','f21f644b-bdfb-4aa3-83a9-2f4eacfe94fe','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (130,'2021-12-27 05:11:29.295964','7621561e-78e1-4aa4-b494-a1134fe19524','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (131,'2021-12-27 05:51:51.260819','d2f0b9c6-3dd2-4dd3-bec4-54de58b3244e','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (132,'2021-12-27 05:51:51.271241','84a2efe4-1ccc-4675-9291-aa25c13c5eae','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (133,'2021-12-27 05:51:51.293518','6a7b79d5-a23a-42f2-87bc-7e06ba3bc4fe','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (134,'2021-12-27 05:51:51.305186','55b22e0c-9924-4010-b0cb-bc7a9b7a9b76','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (135,'2021-12-27 05:51:59.196781','7d79f6a9-5972-4d13-9234-1d1432967a7e','up','',9,1,3);
INSERT INTO "django_admin_log" VALUES (136,'2021-12-27 10:45:51.376519','0c81a97e-275e-4780-8d65-89d23290bac2','First message','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (137,'2021-12-27 10:47:28.854680','a25e1a1c-d9d1-46e3-96c4-8e01034ce8a5','How are things going','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (138,'2021-12-27 15:49:56.352536','d925be2f-cb27-498b-817e-0d7ecc86c13a','yo','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (139,'2021-12-27 17:16:24.452023','a1298a03-b793-4349-9e81-3880414c7db5','second message','',12,1,3);
INSERT INTO "django_admin_log" VALUES (140,'2021-12-27 17:16:24.464288','b35cc0d8-9bcc-4852-8585-32d220cfe81c','second message','',12,1,3);
INSERT INTO "django_admin_log" VALUES (141,'2021-12-27 17:16:24.474924','71c12cb7-1dfc-4f7e-a40d-53b3967d777a','second message','',12,1,3);
INSERT INTO "django_admin_log" VALUES (142,'2021-12-27 17:16:24.485760','ece55f44-637e-4b91-ae92-2befcb908775','second message','',12,1,3);
INSERT INTO "django_admin_log" VALUES (143,'2021-12-27 18:04:56.767366','eba565d0-af15-4589-a812-f77bcf6e9e57','sadiatest','',10,1,3);
INSERT INTO "django_admin_log" VALUES (144,'2021-12-27 18:08:56.836365','12','sadiatest','',4,1,3);
INSERT INTO "django_admin_log" VALUES (145,'2021-12-27 18:09:20.687002','0027cb9c-ea45-4cf9-8b8c-e75c2e2e73b1','sadiatest','',10,1,3);
INSERT INTO "django_admin_log" VALUES (146,'2021-12-27 18:10:28.564478','a9a45120-fdf4-48a7-a650-7d7bbf0283e5','sadiatest','',10,1,3);
INSERT INTO "django_admin_log" VALUES (147,'2021-12-27 18:11:15.294852','9ebf882e-e0a1-41a8-99cb-5cc0cbdadac4','sadiatest','',10,1,3);
INSERT INTO "django_admin_log" VALUES (148,'2021-12-27 18:11:32.649847','05bb024d-8a16-4a3b-bf8b-866684bd9e21','sadiatest','',10,1,3);
INSERT INTO "django_admin_log" VALUES (149,'2021-12-27 18:17:37.499765','378de8e2-430f-46cb-962e-681aaccc9841','sampiper2','',10,1,3);
INSERT INTO "django_admin_log" VALUES (150,'2021-12-27 18:25:02.058952','b3a7def9-5bab-4474-8e66-b7f962c0af49','sampiper2','',10,1,3);
INSERT INTO "django_admin_log" VALUES (151,'2021-12-27 18:25:02.072537','aa530f23-5efe-45d6-9196-6c7cb0538c02','sadiazamal2','',10,1,3);
INSERT INTO "django_admin_log" VALUES (152,'2021-12-27 18:34:28.243284','a56fd953-68a0-484d-9986-27043fbb66aa','sampiper2','',10,1,3);
INSERT INTO "django_admin_log" VALUES (153,'2021-12-27 18:59:10.839808','5b159ca7-bb61-4d08-aaf8-5eea2724f2b3','sampiper2','',10,1,3);
INSERT INTO "django_admin_log" VALUES (154,'2022-01-05 14:12:32.894015','32aa65c9-c2a8-4bc6-8b90-a810e857e765','hey anis','',12,1,3);
INSERT INTO "django_admin_log" VALUES (155,'2022-01-05 14:12:32.909437','056ca97a-e5dd-4427-9c5b-6f26b9fcad15','hey sadia','',12,1,3);
INSERT INTO "django_admin_log" VALUES (156,'2022-01-05 14:12:32.926045','d925be2f-cb27-498b-817e-0d7ecc86c13a','yo','',12,1,3);
INSERT INTO "django_admin_log" VALUES (157,'2022-01-05 14:14:11.226446','e73730d0-b16e-43f9-ae40-8bd2be86c2ff','sample message','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (158,'2022-01-05 14:14:51.473121','e73730d0-b16e-43f9-ae40-8bd2be86c2ff','sample message','[{"changed": {"fields": ["Name", "Email"]}}]',12,1,2);
INSERT INTO "django_admin_log" VALUES (159,'2022-01-05 15:16:30.109364','d2b630b8-27e7-480f-b958-90ed27568183','sampiper2','',10,1,3);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'projects','project');
INSERT INTO "django_content_type" VALUES (8,'projects','tag');
INSERT INTO "django_content_type" VALUES (9,'projects','review');
INSERT INTO "django_content_type" VALUES (10,'users','profile');
INSERT INTO "django_content_type" VALUES (11,'users','skill');
INSERT INTO "django_content_type" VALUES (12,'users','message');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_project','Can add project');
INSERT INTO "auth_permission" VALUES (26,7,'change_project','Can change project');
INSERT INTO "auth_permission" VALUES (27,7,'delete_project','Can delete project');
INSERT INTO "auth_permission" VALUES (28,7,'view_project','Can view project');
INSERT INTO "auth_permission" VALUES (29,8,'add_tag','Can add tag');
INSERT INTO "auth_permission" VALUES (30,8,'change_tag','Can change tag');
INSERT INTO "auth_permission" VALUES (31,8,'delete_tag','Can delete tag');
INSERT INTO "auth_permission" VALUES (32,8,'view_tag','Can view tag');
INSERT INTO "auth_permission" VALUES (33,9,'add_review','Can add review');
INSERT INTO "auth_permission" VALUES (34,9,'change_review','Can change review');
INSERT INTO "auth_permission" VALUES (35,9,'delete_review','Can delete review');
INSERT INTO "auth_permission" VALUES (36,9,'view_review','Can view review');
INSERT INTO "auth_permission" VALUES (37,10,'add_profile','Can add profile');
INSERT INTO "auth_permission" VALUES (38,10,'change_profile','Can change profile');
INSERT INTO "auth_permission" VALUES (39,10,'delete_profile','Can delete profile');
INSERT INTO "auth_permission" VALUES (40,10,'view_profile','Can view profile');
INSERT INTO "auth_permission" VALUES (41,11,'add_skill','Can add skill');
INSERT INTO "auth_permission" VALUES (42,11,'change_skill','Can change skill');
INSERT INTO "auth_permission" VALUES (43,11,'delete_skill','Can delete skill');
INSERT INTO "auth_permission" VALUES (44,11,'view_skill','Can view skill');
INSERT INTO "auth_permission" VALUES (45,12,'add_message','Can add message');
INSERT INTO "auth_permission" VALUES (46,12,'change_message','Can change message');
INSERT INTO "auth_permission" VALUES (47,12,'delete_message','Can delete message');
INSERT INTO "auth_permission" VALUES (48,12,'view_message','Can view message');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$260000$7QX4fNVGsYDEk1iKzk0thL$j/ygSuR4UVpiZHxknsCSOsgbHs8sHMe9rsscikbdLu0=','2022-01-05 15:17:02.767940',1,'sadiazamal','Zamal','sadiazamal1x@gmail.com',1,1,'2021-11-23 11:51:52','Sadia Zamal');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$260000$olkwPzyxIcGDGAIgiBGCWG$Yj+GV7Y0fS6Uun7gR+s5oZ7SzrbQZ0i5/lwl4CgtCss=','2021-12-21 13:12:37.331672',0,'anisurrahman','','anisurrahman@gmail.com',0,1,'2021-11-24 15:57:11','Anisur Rahman');
INSERT INTO "auth_user" VALUES (5,'pbkdf2_sha256$260000$bidWVPRHCDpeXenpvxvMgF$lWoHWeWXAzCrVmNjhfUF30uwLIwYcCxEvzY+m1ZKTOw=','2021-12-21 13:38:44.789347',0,'fariakhan','Khan','fariakhan@gmail.com',0,1,'2021-11-27 06:59:10','Faria Khan');
INSERT INTO "auth_user" VALUES (6,'pbkdf2_sha256$260000$kZJ4b3aKUDWpfR5fUKwasG$gzz7NtBRAMioT/Jyvk7CgBTHRF3fRfQAk9nAfPeJL9k=','2021-12-21 11:46:36',0,'asfatjaman','Jaman','asfatjaman@gmail.com',0,1,'2021-11-30 16:40:22','Asfat Jaman');
INSERT INTO "auth_user" VALUES (7,'pbkdf2_sha256$260000$VJKFxhlouYyhP8ZzaFYjRm$ZTqMlV7exYMyoDbBrQDZm7+pkxNK2KYVQgOFPW/ZxQI=','2021-12-21 13:52:25.134928',0,'tahiyakabir','Kabir','tahiyakabir@gmail.com',0,1,'2021-12-21 11:57:25','Tahiya Kabir');
INSERT INTO "auth_user" VALUES (8,'pbkdf2_sha256$260000$dIhdF8a6lICc39FUk4Pjw5$o7joJpdlHw4G2kcKeAERXu4IGP7JnZZ7UdO6ITxtqwU=',NULL,0,'selinaakhter','Akhter','selinaakhter1x@gmail.com',0,1,'2021-12-21 11:58:47','Selina Akhter');
INSERT INTO "auth_user" VALUES (9,'pbkdf2_sha256$260000$3psnaN71mPoSRl7vAhXlql$SdY2gTkAYjOyivdcL0zWNSGhZBzhqu1zqkUsQgWTiCU=','2021-12-21 13:36:48.542519',0,'sampiper','Piper','sampiper@gmail.com',0,1,'2021-12-21 11:59:50','Sam Piper');
INSERT INTO "auth_user" VALUES (10,'pbkdf2_sha256$260000$wfD1nS66VFX39mmJ6KuJuN$EWmg4eh4/osi3hKnWzL2zlG0LYdkMw6oBrX4qVF4J6U=','2021-12-21 13:27:20.208550',0,'dennisivy','Ivy','dennisivy@gmail.com',0,1,'2021-12-21 12:01:09','Dennis Ivy');
INSERT INTO "projects_tag" VALUES ('React','2021-11-23 12:10:42.309753','29de301567be42cbbe79efea7c11cbd4');
INSERT INTO "projects_tag" VALUES ('Django','2021-11-23 12:11:01.395531','72de1a96e1fd43a7b85c9c6860e9444d');
INSERT INTO "projects_tag" VALUES ('Python','2021-11-23 12:11:07.105982','989fa010bf6f49d98785d8a3447d79aa');
INSERT INTO "projects_tag" VALUES ('JavaScript','2021-11-23 12:11:18.746117','2b755d15e43b4c2093fba996895e1b6d');
INSERT INTO "projects_tag" VALUES ('Node.js','2021-12-21 13:22:49.569786','97b8d88fbc5842b4a69bf6f311f629d8');
INSERT INTO "projects_project_tags" VALUES (1,'e0e7c8040f0e40de8e627462c6e30fdf','29de301567be42cbbe79efea7c11cbd4');
INSERT INTO "projects_project_tags" VALUES (2,'e0e7c8040f0e40de8e627462c6e30fdf','72de1a96e1fd43a7b85c9c6860e9444d');
INSERT INTO "projects_project_tags" VALUES (3,'d77e97ff19b5411782b9fcc3f30f248b','2b755d15e43b4c2093fba996895e1b6d');
INSERT INTO "projects_project_tags" VALUES (4,'d77e97ff19b5411782b9fcc3f30f248b','989fa010bf6f49d98785d8a3447d79aa');
INSERT INTO "projects_project_tags" VALUES (5,'d77e97ff19b5411782b9fcc3f30f248b','29de301567be42cbbe79efea7c11cbd4');
INSERT INTO "projects_project_tags" VALUES (6,'d77e97ff19b5411782b9fcc3f30f248b','72de1a96e1fd43a7b85c9c6860e9444d');
INSERT INTO "projects_project_tags" VALUES (7,'dcdaa203dfac4e6b921c36037b7eb1bd','989fa010bf6f49d98785d8a3447d79aa');
INSERT INTO "projects_project_tags" VALUES (8,'dcdaa203dfac4e6b921c36037b7eb1bd','72de1a96e1fd43a7b85c9c6860e9444d');
INSERT INTO "projects_project_tags" VALUES (19,'68ae69b1f8be4fccbd5707370e8d95bf','989fa010bf6f49d98785d8a3447d79aa');
INSERT INTO "projects_project_tags" VALUES (20,'68ae69b1f8be4fccbd5707370e8d95bf','72de1a96e1fd43a7b85c9c6860e9444d');
INSERT INTO "projects_project_tags" VALUES (21,'e34bfaf9f07c41eb8ba9a47280286a0f','2b755d15e43b4c2093fba996895e1b6d');
INSERT INTO "projects_project_tags" VALUES (22,'e34bfaf9f07c41eb8ba9a47280286a0f','72de1a96e1fd43a7b85c9c6860e9444d');
INSERT INTO "projects_project_tags" VALUES (23,'dcdaa203dfac4e6b921c36037b7eb1bd','2b755d15e43b4c2093fba996895e1b6d');
INSERT INTO "django_session" VALUES ('7qh0zmtsb2ubk4edp1ba1ahbu0qvltmj','.eJxVjDEOwjAMRe-SGUUxIY3FyM4ZIsd2SAGlUtNOiLtDpQ6w_vfef5lE61LT2nVOo5izAXP43TLxQ9sG5E7tNlme2jKP2W6K3Wm310n0edndv4NKvX7rAA7UM0dwJA6DKwq--BwUcsGAIBiP0Z1KCBGIxQOyCGpGHNwQybw_0-Q3mQ:1mz6V8:hUW8zA2EZTcJtps9W5JZUq-SwBACZ5sv5EJp0CXGED8','2022-01-03 00:26:02.691791');
INSERT INTO "django_session" VALUES ('jt2c2iki6850mv6trvx86kd7ej8if0fr','.eJxVjDEOwjAMRe-SGUUxIY3FyM4ZIsd2SAGlUtNOiLtDpQ6w_vfef5lE61LT2nVOo5izAXP43TLxQ9sG5E7tNlme2jKP2W6K3Wm310n0edndv4NKvX7rAA7UM0dwJA6DKwq--BwUcsGAIBiP0Z1KCBGIxQOyCGpGHNwQybw_0-Q3mQ:1mzclE:jHvwG5J6GQMOrrt-R8gkBU_LcnAqqIQnw8KIp_O3fg0','2022-01-04 10:52:48.648738');
INSERT INTO "django_session" VALUES ('8r0m34q6unn3uhk3fwwkvmgtq5yo1eb5','.eJxVjDEOwjAMRe-SGUUxIY3FyM4ZIsd2SAGlUtNOiLtDpQ6w_vfef5lE61LT2nVOo5izAXP43TLxQ9sG5E7tNlme2jKP2W6K3Wm310n0edndv4NKvX7rAA7UM0dwJA6DKwq--BwUcsGAIBiP0Z1KCBGIxQOyCGpGHNwQybw_0-Q3mQ:1mzfca:eck2Qln5u9AuJaWDq0BxvrhCxfiU70DjCipas2O4bww','2022-01-04 13:56:04.650372');
INSERT INTO "django_session" VALUES ('5y0dt8ftljtb1vl1xwt6w11inuo80igz','.eJxVjE0OwiAYBe_C2pBCqYBL956BfH9I1dCktCvj3W2TLnT7Zua9VYJ1KWltMqeR1UUZdfrdEOgpdQf8gHqfNE11mUfUu6IP2vRtYnldD_fvoEArW-1i9H0gJ9kb9EgdEwGyWIcuExuDDDZugu0h-8HZHPgcsAPn2YsZ1OcLCXk4wQ:1n4QX1:3YuqHrUVMfolK1YGft-M6XAi9AaCbfVow7n1XnqdYFM','2022-01-17 16:49:59.934000');
INSERT INTO "django_session" VALUES ('k0yu9wdflpuvn0tu7tyfq1i9817670gp','.eJxVjE0OwiAYBe_C2pBCqYBL956BfH9I1dCktCvj3W2TLnT7Zua9VYJ1KWltMqeR1UUZdfrdEOgpdQf8gHqfNE11mUfUu6IP2vRtYnldD_fvoEArW-1i9H0gJ9kb9EgdEwGyWIcuExuDDDZugu0h-8HZHPgcsAPn2YsZ1OcLCXk4wQ:1n56yW:g8qK7_LPr5LJFWEiwaIefiUNg_V2hmg8i4oVGwrFj2Q','2022-01-19 14:09:12.570765');
INSERT INTO "django_session" VALUES ('w9p2i4irphn1yvwojdgzsgzgq8ukb8cd','.eJxVjE0OwiAYBe_C2pBCqYBL956BfH9I1dCktCvj3W2TLnT7Zua9VYJ1KWltMqeR1UUZdfrdEOgpdQf8gHqfNE11mUfUu6IP2vRtYnldD_fvoEArW-1i9H0gJ9kb9EgdEwGyWIcuExuDDDZugu0h-8HZHPgcsAPn2YsZ1OcLCXk4wQ:1n582A:tH-JuKmgvNo-gP-w7lT---fv_-_iiu0NtB_lLBZsl_4','2022-01-19 15:17:02.779402');
INSERT INTO "projects_project" VALUES ('Ecommerce Website','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',NULL,NULL,'2021-11-23 12:07:31.246997','e0e7c8040f0e40de8e627462c6e30fdf',100,3,'django-react-course.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('Portfolio Website','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','sds',NULL,'2021-11-23 12:07:40.444756','dcdaa203dfac4e6b921c36037b7eb1bd',65,6,'portfolio_9Tlcn3K.PNG','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('Mumble Social Network','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','asdasd','sadasd','2021-11-23 12:08:05.498780','d77e97ff19b5411782b9fcc3f30f248b',100,1,'mumble.PNG','a8dd43133bf04bc894c644a8b072b35d');
INSERT INTO "projects_project" VALUES ('Code Sniper','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',NULL,NULL,'2021-11-23 12:16:47.229298','e34bfaf9f07c41eb8ba9a47280286a0f',100,1,'codesniper.png','a8dd43133bf04bc894c644a8b072b35d');
INSERT INTO "projects_project" VALUES ('Yogo Vive','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',NULL,NULL,'2021-11-23 12:17:11.972868','68ae69b1f8be4fccbd5707370e8d95bf',98,51,'yogavive.png','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('1','',NULL,NULL,'2021-12-20 11:03:13.427355','163bed0532ff481796a18848b9883c20',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('2','',NULL,NULL,'2021-12-20 11:03:21.101121','f9c57b70aac14dd18c1244c94b73a584',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('3','',NULL,NULL,'2021-12-20 11:03:27.080918','4603b6c3262942cab01fc93c635113e0',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('4','',NULL,NULL,'2021-12-20 11:04:09.572827','800a60d5c15743ea8801a2e1709c3df5',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('5','',NULL,NULL,'2021-12-20 11:04:15.274026','83aa56f280b64458a03f47f03ba58a3a',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('6','',NULL,NULL,'2021-12-20 11:04:22.214662','b263c35865624446b0f61246e0eb037e',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('7','',NULL,NULL,'2021-12-20 11:04:27.187295','9b90ca9265eb4f44aebd700ad02a032c',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('8','',NULL,NULL,'2021-12-20 11:04:35.016858','26d518a2c2ca4dcd89c246cc04c7506a',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('9','',NULL,NULL,'2021-12-20 11:04:43.827246','24d35b0e4fd841d7846c4e45698a877a',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('10','',NULL,NULL,'2021-12-20 11:04:51.403931','b58e21358ec2466380b6710e28e26a82',0,0,'default.jpg','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_project" VALUES ('Portfolio Website','',NULL,NULL,'2021-12-21 13:10:53.499966','c9fb4b084345489a92162f66608e9985',0,0,'default.jpg','a8dd43133bf04bc894c644a8b072b35d');
INSERT INTO "projects_project" VALUES ('personal website','',NULL,NULL,'2021-12-21 13:13:19.124714','7f28b91bfdfa4800abcb5c486d66aee4',0,0,'default.jpg','a8dd43133bf04bc894c644a8b072b35d');
INSERT INTO "projects_project" VALUES ('Ecommerce Website','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:32:56.153028','f1a4e5227fe94e88b97df23eb565ff1a',0,0,'Ecommerce_Website.jpg','f2933d6dd6f94fcd91d15f3e49c14587');
INSERT INTO "projects_project" VALUES ('Portfolio Website','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:35:15.306145','8c1b7e9296ab439d98f5b5fadeffe711',0,0,'portfolio_HuYvnAm.PNG','f2933d6dd6f94fcd91d15f3e49c14587');
INSERT INTO "projects_project" VALUES ('Portfolio Website','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:37:44.757323','22dcf69a886549daacab1031c11c1888',0,0,'portfolio_AQVDe1g.PNG','b7f6ca40858c4268a458525769606311');
INSERT INTO "projects_project" VALUES ('Mumble Social Network','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:38:00.832874','fa59ee47644b4b50954f055eaa220ec5',0,0,'mumble_dBvr0ay.PNG','b7f6ca40858c4268a458525769606311');
INSERT INTO "projects_project" VALUES ('Blogs','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:41:22.914420','9806ad89f5194381b15e7f1cae6362a0',0,0,'blog_website.png','cdd5095cd5044df9a80268c4674bbb3b');
INSERT INTO "projects_project" VALUES ('Entertainment website','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:44:34.098147','b37ded36ef974a388a7339d880fc5054',0,0,'entertainment_website.jpg','cdd5095cd5044df9a80268c4674bbb3b');
INSERT INTO "projects_project" VALUES ('Entertainment website','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:53:46.952081','b402933f635c410eb9b30bb35fc5f8ee',0,0,'entertainment_website_fggdkp1.jpg','ff6507fb5ef14bfb81f821f69168fffa');
INSERT INTO "projects_project" VALUES ('Code Sniper','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',NULL,NULL,'2021-12-21 13:54:11.074334','900faf1028b44223a1523aab75a2282c',0,0,'codesniper_pliGQJu.png','ff6507fb5ef14bfb81f821f69168fffa');
INSERT INTO "users_profile" VALUES ('Sadia Zamal','sadiazamal1x@gmail.com','I am a Software Engineer','I am Sadia Zamal. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/sadia.png','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-11-24 15:45:39.521257','29d640eaa06140de8f6207e1b16ad24d',1,'sadiazamal','Mohammadpur, Dhaka');
INSERT INTO "users_profile" VALUES ('Anisur Rahman','anisurrahman@gmail.com','I am an Engineer','I am  Anisur Rahman. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/John.png','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-11-24 15:58:49.821278','a8dd43133bf04bc894c644a8b072b35d',2,'anisurrahman','Aftabnagar, Dhaka');
INSERT INTO "users_profile" VALUES ('Faria Khan','fariakhan@gmail.com','I am a Backend Developer','I am Faria Khan. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/faria_khan_JiFk5G7.png','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-11-27 06:59:10.715672','cdd5095cd5044df9a80268c4674bbb3b',5,'fariakhan','Mohakhali, Dhaka');
INSERT INTO "users_profile" VALUES ('Asfat Jaman','asfatjaman@gmail.com','I am a Junior Software Engineer','I am Asfat Jaman. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/asfat_2.jpg','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-11-30 16:40:22.480966','e2684026a9fb42588e3367314faf32e7',6,'asfatjaman','Bagerhat, Khulna');
INSERT INTO "users_profile" VALUES ('Tahiya Kabir','tahiyakabir@gmail.com','I am a Network Engineer','I am Tahiya Kabir. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/tahiya2.jpg','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-12-21 11:57:26.146098','ff6507fb5ef14bfb81f821f69168fffa',7,'tahiyakabir','Mirpur, Dhaka');
INSERT INTO "users_profile" VALUES ('Selina Akhter','selinaakhter1x@gmail.com','I am a Unit Tester','I am Selina Akhter. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/selina_2.png','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-12-21 11:58:47.774137','e49f505d57924222ac69e32412fdc4aa',8,'selinaakhter','Mumbai, India');
INSERT INTO "users_profile" VALUES ('Sam Piper','sampiper@gmail.com','I am a Full Stack Developer','I am Sam Piper. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/sam_piper2.jpg','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-12-21 11:59:51.265193','b7f6ca40858c4268a458525769606311',9,'sampiper','Florida, USA');
INSERT INTO "users_profile" VALUES ('Dennis Ivy','dennisivy@gmail.com','I am a Web Developer','I am Dennis Ivy. I am a student of East West University. I am from CSE department. My batch is spring 2019. I am passionate about web development. I learned HTML, CSS, python, JavaScript, django, SQLite etc to make this project. I want to be a full stack developer. This is a project of CSE 412 course.','profiles/dennis2.jpg','https://github.com/sadiazamal123','https://twitter.com/SadiaZamal','https://www.linkedin.com/in/sadia-zamal-a3167b183/',NULL,'https://www.facebook.com/sadia.zamal.3/','2021-12-21 12:01:09.967671','f2933d6dd6f94fcd91d15f3e49c14587',10,'dennisivy','California, USA');
INSERT INTO "users_skill" VALUES ('React','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','2021-11-24 18:27:41.119927','6825ee51ebb24b4097de26f6e03a3470','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "users_skill" VALUES ('Django','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-11-24 18:28:12.627285','a411a22c618d47c59418f2f34e03ab04','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "users_skill" VALUES ('Python','There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don''t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need','2021-11-24 18:29:05.716832','67c2ab3a7b2a4f6a89a779275a4e8740','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "users_skill" VALUES ('HTML','It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','2021-11-24 18:29:28.671023','4965d9dc043c4e8082e6e0f496eea11e','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "users_skill" VALUES ('CSS','It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','2021-11-24 18:29:38.469124','75db9cb241b84c3b9a8867cb9d7ff2ea','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "users_skill" VALUES ('React','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','2021-12-21 13:12:52.499155','bda2596cfea24bda96e07dec4b706524','a8dd43133bf04bc894c644a8b072b35d');
INSERT INTO "users_skill" VALUES ('Python','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','2021-12-21 13:14:01.370498','a2fd92233feb42ca9d85f801ce632248','a8dd43133bf04bc894c644a8b072b35d');
INSERT INTO "users_skill" VALUES ('MySQL','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','2021-12-21 13:19:15.815000','a53eac17ad874e93aedafb59f98e5fdb','a8dd43133bf04bc894c644a8b072b35d');
INSERT INTO "users_skill" VALUES ('MySQL','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:28:23.976203','496c432e12714096bc9b2db6e2def042','f2933d6dd6f94fcd91d15f3e49c14587');
INSERT INTO "users_skill" VALUES ('JavaScript','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:29:53.740553','5cfc688783734ce4b0a1329736d6a3c8','f2933d6dd6f94fcd91d15f3e49c14587');
INSERT INTO "users_skill" VALUES ('CSS','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:33:43.488615','de1438acbfe047a7a10fc2500fd97ab0','f2933d6dd6f94fcd91d15f3e49c14587');
INSERT INTO "users_skill" VALUES ('HTML','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:36:58.623835','a12234956cf54127a6f914643b318d20','b7f6ca40858c4268a458525769606311');
INSERT INTO "users_skill" VALUES ('MongoDB','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:37:22.036033','262a8a3105994c85bd001fa00325bab3','b7f6ca40858c4268a458525769606311');
INSERT INTO "users_skill" VALUES ('React','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:37:31.871893','16129efbcb5e4306bb7525a859b666bd','b7f6ca40858c4268a458525769606311');
INSERT INTO "users_skill" VALUES ('JavaScript','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:38:59.579892','2aa0aea18fa74f0086eb4e1cc2800af5','cdd5095cd5044df9a80268c4674bbb3b');
INSERT INTO "users_skill" VALUES ('C++','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:39:06.403886','a4ae73314dea4bed85be2482c7b1f6b7','cdd5095cd5044df9a80268c4674bbb3b');
INSERT INTO "users_skill" VALUES ('Ruby','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:39:42.784189','132ac0232d4544be9993cd13b4ba7793','cdd5095cd5044df9a80268c4674bbb3b');
INSERT INTO "users_skill" VALUES ('Java','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:52:43.864786','9e17c72b896e40758a454ace81b739d6','ff6507fb5ef14bfb81f821f69168fffa');
INSERT INTO "users_skill" VALUES ('React','Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2021-12-21 13:52:52.414343','d6bfc9d4598b41b6973fd35a85264948','ff6507fb5ef14bfb81f821f69168fffa');
INSERT INTO "projects_review" VALUES ('This is a review','up','2021-12-27 05:52:25.668048','39ad9b83f9a64416937af545b8f349c3','d77e97ff19b5411782b9fcc3f30f248b','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "projects_review" VALUES ('You did amazing','up','2021-12-27 05:52:56.285050','0bfa6b3a49a34ccfac73aa61a6917442','e34bfaf9f07c41eb8ba9a47280286a0f','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "users_message" VALUES ('Sam Piper','sampiper@gmail.com','First message','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',1,'2021-12-27 10:45:51.372678','0c81a97e275e47808d6589d23290bac2','29d640eaa06140de8f6207e1b16ad24d','b7f6ca40858c4268a458525769606311');
INSERT INTO "users_message" VALUES ('Selina Akhter','selinaakhter1x@gmail.com','How are things going','It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',1,'2021-12-27 10:47:28.852238','a25e1a1cd9d146e396c48e01034ce8a5','29d640eaa06140de8f6207e1b16ad24d','e49f505d57924222ac69e32412fdc4aa');
INSERT INTO "users_message" VALUES ('Sam Piper','sampiper@gmail.com','second message','This is a sample message',1,'2021-12-27 16:51:00.852679','4f115e63d3b64714b2b8a37bfeada97c','29d640eaa06140de8f6207e1b16ad24d',NULL);
INSERT INTO "users_message" VALUES ('Sadia Zamal','sadiazamal1x@gmail.com','hey piper','hdagdkag',0,'2021-12-27 17:10:15.267460','c6f63490955e4f21b4ec705e1e7ef7c1','b7f6ca40858c4268a458525769606311','29d640eaa06140de8f6207e1b16ad24d');
INSERT INTO "users_message" VALUES ('Sam Piper2','sampiper2@gmail.com','hey asfat','you are future lawer',0,'2021-12-28 05:52:07.584213','d236e3a4790a4b33a3c973fb6e856f83','e2684026a9fb42588e3367314faf32e7',NULL);
INSERT INTO "users_message" VALUES ('Anisur Rahman','anisurrahman@gmail.com','sample message','happy semester break',0,'2022-01-05 14:14:11.219624','e73730d0b16e43f9ae408bd2be86c2ff','29d640eaa06140de8f6207e1b16ad24d','a8dd43133bf04bc894c644a8b072b35d');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "projects_project_tags_project_id_tag_id_5891719a_uniq" ON "projects_project_tags" (
	"project_id",
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "projects_project_tags_project_id_9bbfa17b" ON "projects_project_tags" (
	"project_id"
);
CREATE INDEX IF NOT EXISTS "projects_project_tags_tag_id_c949773d" ON "projects_project_tags" (
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "projects_project_owner_id_b940de39" ON "projects_project" (
	"owner_id"
);
CREATE INDEX IF NOT EXISTS "users_skill_owner_id_0ee8cb35" ON "users_skill" (
	"owner_id"
);
CREATE INDEX IF NOT EXISTS "projects_review_project_id_2bd204bf" ON "projects_review" (
	"project_id"
);
CREATE INDEX IF NOT EXISTS "projects_review_owner_id_f1d7d1a3" ON "projects_review" (
	"owner_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "projects_review_owner_id_project_id_50c8fcbc_uniq" ON "projects_review" (
	"owner_id",
	"project_id"
);
CREATE INDEX IF NOT EXISTS "users_message_recipient_id_0dcb937f" ON "users_message" (
	"recipient_id"
);
CREATE INDEX IF NOT EXISTS "users_message_sender_id_d1e3d44e" ON "users_message" (
	"sender_id"
);
COMMIT;
