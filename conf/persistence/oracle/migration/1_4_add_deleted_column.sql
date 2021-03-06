ALTER TABLE analysis_group DROP COLUMN deleted;
ALTER TABLE analysis_group_label DROP COLUMN deleted;
ALTER TABLE analysis_group_state DROP COLUMN deleted;
ALTER TABLE analysis_group_value DROP COLUMN deleted;
ALTER TABLE container DROP COLUMN deleted;
ALTER TABLE container_label DROP COLUMN deleted;
ALTER TABLE container_state DROP COLUMN deleted;
ALTER TABLE container_value DROP COLUMN deleted;
ALTER TABLE experiment DROP COLUMN deleted;
ALTER TABLE experiment_label DROP COLUMN deleted;
ALTER TABLE experiment_state DROP COLUMN deleted;
ALTER TABLE experiment_value DROP COLUMN deleted;
ALTER TABLE file_thing DROP COLUMN deleted;
ALTER TABLE itx_container_container DROP COLUMN deleted;
ALTER TABLE itx_container_container_state DROP COLUMN deleted;
ALTER TABLE itx_container_container_value DROP COLUMN deleted;
ALTER TABLE itx_experiment_experiment DROP COLUMN deleted;
ALTER TABLE itx_protocol_protocol DROP COLUMN deleted;
ALTER TABLE itx_protocol_protocol_state DROP COLUMN deleted;
ALTER TABLE itx_protocol_protocol_value DROP COLUMN deleted;
ALTER TABLE itx_subject_container DROP COLUMN deleted;
ALTER TABLE itx_subject_container_state DROP COLUMN deleted;
ALTER TABLE itx_subject_container_value DROP COLUMN deleted;
ALTER TABLE ls_interaction DROP COLUMN deleted;
ALTER TABLE ls_thing DROP COLUMN deleted;
ALTER TABLE ls_thing_label DROP COLUMN deleted;
ALTER TABLE ls_thing_state DROP COLUMN deleted;
ALTER TABLE ls_thing_value DROP COLUMN deleted;
ALTER TABLE protocol DROP COLUMN deleted;
ALTER TABLE protocol_label DROP COLUMN deleted;
ALTER TABLE protocol_state DROP COLUMN deleted;
ALTER TABLE protocol_value DROP COLUMN deleted;
ALTER TABLE subject DROP COLUMN deleted;
ALTER TABLE subject_label DROP COLUMN deleted;
ALTER TABLE subject_state DROP COLUMN deleted;
ALTER TABLE subject_value DROP COLUMN deleted;
ALTER TABLE treatment_group DROP COLUMN deleted;
ALTER TABLE treatment_group_label DROP COLUMN deleted;
ALTER TABLE treatment_group_state DROP COLUMN deleted;
ALTER TABLE treatment_group_value DROP COLUMN deleted;

ALTER TABLE analysis_group ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE analysis_group_label ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE analysis_group_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE analysis_group_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE container ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE container_label ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE container_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE container_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE experiment ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE experiment_label ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE experiment_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE experiment_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE file_thing ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_container_container ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_container_container_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_container_container_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_experiment_experiment ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_experiment_experiment_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_experiment_experiment_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_protocol_protocol ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_protocol_protocol_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_protocol_protocol_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_subject_container ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_subject_container_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE itx_subject_container_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE ls_interaction ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE ls_thing ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE ls_thing_label ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE ls_thing_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE ls_thing_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE protocol ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE protocol_label ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE protocol_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE protocol_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE subject ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE subject_label ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE subject_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE subject_value ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE treatment_group ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE treatment_group_label ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE treatment_group_state ADD deleted NUMBER(1,0) DEFAULT 0;
ALTER TABLE treatment_group_value ADD deleted NUMBER(1,0) DEFAULT 0;

UPDATE experiment SET deleted = 1 WHERE ignored = 1 AND deleted = 0;
UPDATE protocol SET deleted = 1 WHERE ignored = 1 AND deleted = 0;


