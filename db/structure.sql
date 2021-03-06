CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(50) DEFAULT '', "comment" text, "commentable_id" integer, "commentable_type" varchar(255), "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "lecturers" ("staff_id" integer NOT NULL, "topic_id" integer NOT NULL, "relation_created_at" DATETIME DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE "listeners" ("staff_id" integer NOT NULL, "topic_id" integer NOT NULL, "relation_created_at" DATETIME DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE "notifications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "staff_id" integer NOT NULL, "topic_id" integer NOT NULL, "message" varchar(255) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "observers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "staff_id" integer NOT NULL, "topic_id" integer NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "sessions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "session_id" varchar(255) NOT NULL, "data" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "staffs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "nick" varchar(255) DEFAULT '' NOT NULL, "name" varchar(255) DEFAULT '' NOT NULL, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "preferences" text, "avatar_file_name" varchar(255), "avatar_content_type" varchar(255), "avatar_file_size" integer, "avatar_updated_at" datetime);
CREATE TABLE "topics" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "content" text, "staff_id" integer, "category_id" integer, "state" integer, "text_filter" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "lecturer_count" integer DEFAULT 0 NOT NULL, "listener_count" integer DEFAULT 0 NOT NULL, "content_preview" text);
CREATE TABLE "votes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "vote" boolean DEFAULT 'f' NOT NULL, "voteable_id" integer NOT NULL, "voteable_type" varchar(255) NOT NULL, "voter_id" integer, "voter_type" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "fk_one_vote_per_user_per_entity" ON "votes" ("voter_id", "voter_type", "voteable_id", "voteable_type");
CREATE INDEX "index_comments_on_commentable_id" ON "comments" ("commentable_id");
CREATE INDEX "index_comments_on_commentable_type" ON "comments" ("commentable_type");
CREATE INDEX "index_comments_on_user_id" ON "comments" ("user_id");
CREATE INDEX "index_lecturers_on_relation_created_at" ON "lecturers" ("relation_created_at");
CREATE INDEX "index_listeners_on_relation_created_at" ON "listeners" ("relation_created_at");
CREATE INDEX "index_notifications_on_staff_id" ON "notifications" ("staff_id");
CREATE INDEX "index_notifications_on_topic_id" ON "notifications" ("topic_id");
CREATE INDEX "index_observers_on_staff_id" ON "observers" ("staff_id");
CREATE UNIQUE INDEX "index_observers_on_staff_id_and_topic_id" ON "observers" ("staff_id", "topic_id");
CREATE INDEX "index_observers_on_topic_id" ON "observers" ("topic_id");
CREATE INDEX "index_sessions_on_session_id" ON "sessions" ("session_id");
CREATE INDEX "index_sessions_on_updated_at" ON "sessions" ("updated_at");
CREATE UNIQUE INDEX "index_staffs_on_email" ON "staffs" ("email");
CREATE INDEX "index_topics_on_category_id" ON "topics" ("category_id");
CREATE INDEX "index_topics_on_lecturer_count" ON "topics" ("lecturer_count");
CREATE INDEX "index_topics_on_listener_count" ON "topics" ("listener_count");
CREATE INDEX "index_topics_on_staff_id" ON "topics" ("staff_id");
CREATE INDEX "index_topics_on_title" ON "topics" ("title");
CREATE INDEX "index_topics_on_updated_at" ON "topics" ("updated_at");
CREATE INDEX "index_votes_on_voteable_id_and_voteable_type" ON "votes" ("voteable_id", "voteable_type");
CREATE INDEX "index_votes_on_voter_id_and_voter_type" ON "votes" ("voter_id", "voter_type");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120914135627');

INSERT INTO schema_migrations (version) VALUES ('20121010232626');

INSERT INTO schema_migrations (version) VALUES ('20121010233050');

INSERT INTO schema_migrations (version) VALUES ('20121017024304');

INSERT INTO schema_migrations (version) VALUES ('20121018191709');

INSERT INTO schema_migrations (version) VALUES ('20121019090539');

INSERT INTO schema_migrations (version) VALUES ('20121019132052');

INSERT INTO schema_migrations (version) VALUES ('20121020173732');

INSERT INTO schema_migrations (version) VALUES ('20121021162715');

INSERT INTO schema_migrations (version) VALUES ('20121021173916');

INSERT INTO schema_migrations (version) VALUES ('20121022070448');

INSERT INTO schema_migrations (version) VALUES ('20121022070753');

INSERT INTO schema_migrations (version) VALUES ('20121022073538');

INSERT INTO schema_migrations (version) VALUES ('20121022080000');

INSERT INTO schema_migrations (version) VALUES ('20121022171655');

INSERT INTO schema_migrations (version) VALUES ('20121027010123');

INSERT INTO schema_migrations (version) VALUES ('20121027010320');

INSERT INTO schema_migrations (version) VALUES ('20121027170415');