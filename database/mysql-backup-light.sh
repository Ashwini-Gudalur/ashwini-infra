mysqldump -u root -ppassword --no-data openmrs > /tmp/schema.sql
mysqldump -u root -ppassword openmrs address_hierarchy_address_to_entry_map address_hierarchy_entry address_hierarchy_level allergy allergy_reaction appframework_component_state appframework_user_app appointment_service appointment_service_type appointment_service_weekly_availability appointment_speciality appointmentscheduling_appointment appointmentscheduling_appointment_block appointmentscheduling_appointment_request appointmentscheduling_appointment_status_history appointmentscheduling_appointment_type appointmentscheduling_block_type_map appointmentscheduling_time_slot aqs_task bahmni_config bahmni_config_version bed bed_location_map bed_location_map_removal_list bed_tag bed_tag_map bed_type calculation_registration care_setting chunking_history clob_datatype_storage cohort cohort_member concept concept_answer concept_attribute concept_attribute_type concept_class concept_complex concept_datatype concept_description concept_map_type concept_name concept_name_tag concept_name_tag_map concept_numeric concept_proposal concept_proposal_tag_map concept_reference_map concept_reference_source concept_reference_term concept_reference_term_map concept_set concept_state_conversion concept_stop_word conditions DATABASECHANGELOG DATABASECHANGELOGLOCK drug drug_ingredient drug_reference_map encounter_role encounter_type entity_mapping entity_mapping_type episode episode_encounter field field_answer field_type form form_field form_resource global_property hl7_in_archive hl7_in_error hl7_in_queue hl7_source htmlformentry_html_form idgen_auto_generation_option idgen_id_pool idgen_identifier_source  idgen_pooled_identifier idgen_remote_source idgen_reserved_identifier idgen_seq_id_gen import_status jss_agegroups jss_program_village liquibasechangelog liquibasechangeloglock location location_attribute location_attribute_type location_encounter_type_map location_tag location_tag_map logic_rule_definition logic_rule_token logic_rule_token_tag logic_token_registration logic_token_registration_tag markers metadatamapping_metadata_set metadatamapping_metadata_set_member metadatamapping_metadata_source metadatamapping_metadata_term_mapping metadatasharing_exported_package metadatasharing_imported_item metadatasharing_imported_package note notification_alert notification_alert_recipient notification_template obs_relationship obs_relationship_type order_frequency order_group order_set order_set_member order_set_member_attribute order_set_member_attribute_type order_type order_type_class_map privilege program program_attribute_type program_workflow program_workflow_state provider provider_attribute provider_attribute_type providermanagement_provider_role providermanagement_provider_role_provider_attribute_type providermanagement_provider_role_relationship_type providermanagement_provider_role_supervisee_provider_role providermanagement_provider_suggestion providermanagement_supervision_suggestion quartz_cron_scheduler relationship_type report_object report_schema_xml reporting_age_group reporting_concept_range reporting_report_design reporting_report_design_resource reporting_report_processor reporting_report_request role role_privilege role_role scheduler_task_config scheduler_task_config_property schema_version serialized_object surgical_appointment surgical_appointment_attribute surgical_appointment_attribute_type surgical_block test_order uiframework_user_defined_page_view user_property user_role users person_attribute_type patient_identifier_type visit_attribute_type visit_type > /tmp/metadata.sql

# Note you cannot run the mysqldump multiple times as it drops table
mysqldump -u root -ppassword openmrs person person_address person_attribute person_name --where="person_id in (select patient_id from patient_ids_to_export) or person_id in (select person.person_id from person join users u on u.person_id = person.person_id)" --single-transaction > /tmp/tx-dump-1.sql
mysqldump -u root -ppassword openmrs patient patient_appointment patient_identifier visit bed_patient_assignment_map --where="patient_id in (select patient_id from patient_ids_to_export)" --single-transaction > /tmp/tx-dump-2.sql
mysqldump -u root -ppassword openmrs visit_attribute encounter --where="visit_id in (select visit_id from visit where patient_id in (select patient_id from patient_ids_to_export))" --single-transaction > /tmp/tx-dump-3.sql
mysqldump -u root -ppassword openmrs encounter_provider obs orders --where="encounter_id in (select encounter_id from encounter where patient_id in (select patient_id from patient_ids_to_export))" --single-transaction > /tmp/tx-dump-4.sql
mysqldump -u root -ppassword openmrs drug_order --where="order_id in (select drug_order.order_id from drug_order join orders o on drug_order.order_id = o.order_id where o.patient_id in (select patient_id from patient_ids_to_export))" --single-transaction > /tmp/tx-dump-5.sql



# Tables not implemented yet
# atom feed tables, person_merge_log, random_names patient_appointment_audit idgen_log_entry patient_program_attribute patient_state patient_program episode_patient_program relationship
