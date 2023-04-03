DROP TABLE IF EXISTS `page`;

CREATE TABLE `page` (
	`page_id`	BIGINT	NOT NULL,
	`created_datetime`	DATETIME	NOT NULL	COMMENT '디비에 저장된 시간',
	`updated_datetime`	DATETIME	NOT NULL,
	`title`	VARCHAR(50)	NOT NULL	DEFAULT untitled
);

DROP TABLE IF EXISTS `block`;

CREATE TABLE `block` (
	`block_id`	INT	NOT NULL,
	`title`	VARCHAR(100)	NOT NULL	DEFAULT untitled,
	`content`	TEXT	NOT NULL	DEFAULT "",
	`page_id`	BIGINT	NOT NULL,
	`block_index`	INT	NOT NULL
);

DROP TABLE IF EXISTS `chat`;

CREATE TABLE `chat` (
	`chat_id`	BIGINT	NOT NULL,
	`project_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`user_id`	BIGINT	NOT NULL,
	`last_name`	VARCHAR(20)	NOT NULL,
	`first_name`	VARCHAR(20)	NOT NULL,
	`email`	VARCHAR(20)	NOT NULL,
	`password`	VARCHAR(20)	NULL,
	`phone_number`	VARCHAR(13)	NULL
);

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
	`project_id`	BIGINT	NOT NULL,
	`project_name`	VARCHAR(30)	NOT NULL	DEFAULT Untitled Project,
	`begin_date`	DATE	NOT NULL,
	`due_date`	DATE	NOT NULL,
	`owner_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `participant`;

CREATE TABLE `participant` (
	`participant_id`	BIGINT	NOT NULL,
	`project_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `page_check`;

CREATE TABLE `page_check` (
	`page_check_id`	INT	NOT NULL,
	`document_id`	BIGINT	NOT NULL,
	`participant_id`	BIGINT	NOT NULL,
	`last_checked`	DATETIME	NULL
);

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
	`message_id`	BIGINT	NOT NULL,
	`participant_id`	BIGINT	NOT NULL,
	`chat_id`	BIGINT	NOT NULL,
	`message_content`	VARCHAR(255)	NOT NULL,
	`message_sent_datetime`	DATETIME	NOT NULL
);

DROP TABLE IF EXISTS `todo`;

CREATE TABLE `todo` (
	`todo_id`	BIGINT	NOT NULL,
	`project_id`	BIGINT	NOT NULL,
	`parent_id`	BIGINT	NOT NULL,
	`start_date`	DATETIME	NOT NULL,
	`due_date`	DATETIME	NOT NULL,
	`status`	VARCHAR(20)	NOT NULL	DEFAULT BEFORE_START,
	`content`	VARCHAR(255)	NOT NULL	DEFAULT ""
);

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
	`notification_id`	BIGINT	NOT NULL,
	`participant_id`	BIGINT	NOT NULL,
	`project_id`	BIGINT	NOT NULL,
	`noti_content`	VARCHAR(100)	NULL,
	`notification_priority`	INT	NOT NULL	DEFAULT 1,
	`notification_type`	VARCHAR(20)	NOT NULL,
	`goalId`	BIGINT	NOT NULL,
	`noticed_datetime`	DATETIME	NOT NULL,
	`sent_user_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `InCharge`;

CREATE TABLE `InCharge` (
	`inCharge_id`	BIGINT	NOT NULL,
	`todo_id`	BIGINT	NOT NULL,
	`participant_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `icloud_user`;

CREATE TABLE `icloud_user` (
	`user_id`	BIGINT	NOT NULL,
	`icloud_Email`	VARCHAR(255)	NULL
);

DROP TABLE IF EXISTS `document`;

CREATE TABLE `document` (
	`document_id`	BIGINT	NOT NULL,
	`project_id`	BIGINT	NOT NULL,
	`parent_id`	BIGINT	NOT NULL,
	`dtype`	VARCHAR	NOT NULL,
	`doc_index`	INT	NOT NULL
);

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
	`group_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL	DEFAULT New Group
);

DROP TABLE IF EXISTS `Untitled`;

CREATE TABLE `Untitled` (
	`annotation_id`	BIGINT	NOT NULL,
	`block_id`	INT	NOT NULL,
	`participant_id`	BIGINT	NOT NULL,
	`content`	VARCHAR(255)	NOT NULL,
	`created_datetime`	DATETIME	NOT NULL,
	`user_name`	VARCHAR(40)	NOT NULL
);

ALTER TABLE `page` ADD CONSTRAINT `PK_PAGE` PRIMARY KEY (
	`page_id`
);

ALTER TABLE `block` ADD CONSTRAINT `PK_BLOCK` PRIMARY KEY (
	`block_id`
);

ALTER TABLE `chat` ADD CONSTRAINT `PK_CHAT` PRIMARY KEY (
	`chat_id`
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `project` ADD CONSTRAINT `PK_PROJECT` PRIMARY KEY (
	`project_id`
);

ALTER TABLE `participant` ADD CONSTRAINT `PK_PARTICIPANT` PRIMARY KEY (
	`participant_id`
);

ALTER TABLE `page_check` ADD CONSTRAINT `PK_PAGE_CHECK` PRIMARY KEY (
	`page_check_id`
);

ALTER TABLE `message` ADD CONSTRAINT `PK_MESSAGE` PRIMARY KEY (
	`message_id`
);

ALTER TABLE `todo` ADD CONSTRAINT `PK_TODO` PRIMARY KEY (
	`todo_id`
);

ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (
	`notification_id`
);

ALTER TABLE `InCharge` ADD CONSTRAINT `PK_INCHARGE` PRIMARY KEY (
	`inCharge_id`
);

ALTER TABLE `document` ADD CONSTRAINT `PK_DOCUMENT` PRIMARY KEY (
	`document_id`
);

ALTER TABLE `group` ADD CONSTRAINT `PK_GROUP` PRIMARY KEY (
	`group_id`
);

ALTER TABLE `Untitled` ADD CONSTRAINT `PK_UNTITLED` PRIMARY KEY (
	`annotation_id`
);

ALTER TABLE `page` ADD CONSTRAINT `FK_document_TO_page_1` FOREIGN KEY (
	`page_id`
)
REFERENCES `document` (
	`document_id`
);

ALTER TABLE `block` ADD CONSTRAINT `FK_page_TO_block_1` FOREIGN KEY (
	`page_id`
)
REFERENCES `page` (
	`page_id`
);

ALTER TABLE `chat` ADD CONSTRAINT `FK_project_TO_chat_1` FOREIGN KEY (
	`project_id`
)
REFERENCES `project` (
	`project_id`
);

ALTER TABLE `project` ADD CONSTRAINT `FK_user_TO_project_1` FOREIGN KEY (
	`owner_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `participant` ADD CONSTRAINT `FK_project_TO_participant_1` FOREIGN KEY (
	`project_id`
)
REFERENCES `project` (
	`project_id`
);

ALTER TABLE `participant` ADD CONSTRAINT `FK_user_TO_participant_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `page_check` ADD CONSTRAINT `FK_page_TO_page_check_1` FOREIGN KEY (
	`document_id`
)
REFERENCES `page` (
	`page_id`
);

ALTER TABLE `page_check` ADD CONSTRAINT `FK_participant_TO_page_check_1` FOREIGN KEY (
	`participant_id`
)
REFERENCES `participant` (
	`participant_id`
);

ALTER TABLE `message` ADD CONSTRAINT `FK_participant_TO_message_1` FOREIGN KEY (
	`participant_id`
)
REFERENCES `participant` (
	`participant_id`
);

ALTER TABLE `message` ADD CONSTRAINT `FK_chat_TO_message_1` FOREIGN KEY (
	`chat_id`
)
REFERENCES `chat` (
	`chat_id`
);

ALTER TABLE `todo` ADD CONSTRAINT `FK_project_TO_todo_1` FOREIGN KEY (
	`project_id`
)
REFERENCES `project` (
	`project_id`
);

ALTER TABLE `todo` ADD CONSTRAINT `FK_todo_TO_todo_1` FOREIGN KEY (
	`parent_id`
)
REFERENCES `todo` (
	`todo_id`
);

ALTER TABLE `notification` ADD CONSTRAINT `FK_participant_TO_notification_1` FOREIGN KEY (
	`participant_id`
)
REFERENCES `participant` (
	`participant_id`
);

ALTER TABLE `notification` ADD CONSTRAINT `FK_project_TO_notification_1` FOREIGN KEY (
	`project_id`
)
REFERENCES `project` (
	`project_id`
);

ALTER TABLE `InCharge` ADD CONSTRAINT `FK_todo_TO_InCharge_1` FOREIGN KEY (
	`todo_id`
)
REFERENCES `todo` (
	`todo_id`
);

ALTER TABLE `InCharge` ADD CONSTRAINT `FK_participant_TO_InCharge_1` FOREIGN KEY (
	`participant_id`
)
REFERENCES `participant` (
	`participant_id`
);

ALTER TABLE `icloud_user` ADD CONSTRAINT `FK_user_TO_icloud_user_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `document` ADD CONSTRAINT `FK_project_TO_document_1` FOREIGN KEY (
	`project_id`
)
REFERENCES `project` (
	`project_id`
);

ALTER TABLE `document` ADD CONSTRAINT `FK_document_TO_document_1` FOREIGN KEY (
	`parent_id`
)
REFERENCES `document` (
	`document_id`
);

ALTER TABLE `group` ADD CONSTRAINT `FK_document_TO_group_1` FOREIGN KEY (
	`group_id`
)
REFERENCES `document` (
	`document_id`
);

ALTER TABLE `Untitled` ADD CONSTRAINT `FK_block_TO_Untitled_1` FOREIGN KEY (
	`block_id`
)
REFERENCES `block` (
	`block_id`
);

ALTER TABLE `Untitled` ADD CONSTRAINT `FK_participant_TO_Untitled_1` FOREIGN KEY (
	`participant_id`
)
REFERENCES `participant` (
	`participant_id`
);

