ALTER TABLE `am_deploy_app` ADD COLUMN `deploy_process_id` BIGINT NULL DEFAULT NULL AFTER `deploy_component_count`;
CREATE  INDEX `idx_deploy_process_id` USING BTREE ON `am_deploy_app` (`deploy_process_id`);