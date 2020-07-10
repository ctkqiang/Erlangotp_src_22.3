$(EBIN)/dtls_connection.$(EMULATOR): dtls_connection.erl dtls_connection.hrl \
  ssl_connection.hrl ssl_internal.hrl ssl_record.hrl ssl_handshake.hrl \
  ssl_srp.hrl ssl_cipher.hrl dtls_handshake.hrl tls_handshake.hrl \
  ssl_api.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  dtls_record.hrl
$(EBIN)/dtls_connection_sup.$(EMULATOR): dtls_connection_sup.erl
$(EBIN)/dtls_handshake.$(EMULATOR): dtls_handshake.erl dtls_connection.hrl \
  ssl_connection.hrl ssl_internal.hrl ssl_record.hrl ssl_handshake.hrl \
  ssl_srp.hrl ssl_cipher.hrl dtls_handshake.hrl tls_handshake.hrl \
  ssl_api.hrl dtls_record.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
$(EBIN)/dtls_listener_sup.$(EMULATOR): dtls_listener_sup.erl
$(EBIN)/dtls_packet_demux.$(EMULATOR): dtls_packet_demux.erl ssl_internal.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
$(EBIN)/dtls_record.$(EMULATOR): dtls_record.erl dtls_record.hrl ssl_record.hrl \
  ssl_internal.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  dtls_handshake.hrl tls_handshake.hrl ssl_handshake.hrl ssl_api.hrl \
  ssl_cipher.hrl
$(EBIN)/dtls_sup.$(EMULATOR): dtls_sup.erl
$(EBIN)/dtls_socket.$(EMULATOR): dtls_socket.erl ssl_internal.hrl ssl_api.hrl
$(EBIN)/dtls_v1.$(EMULATOR): dtls_v1.erl ssl_cipher.hrl
$(EBIN)/inet_tls_dist.$(EMULATOR): inet_tls_dist.erl \
  ../../../bootstrap/lib/kernel/include/net_address.hrl \
  ../../../bootstrap/lib/kernel/include/dist.hrl \
  ../../../bootstrap/lib/kernel/include/dist_util.hrl \
  ssl_api.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
inet6_tls_dist.$(EMULATOR): inet6_tls_dist.erl
ssl.$(EMULATOR): ssl.erl ssl_internal.hrl ssl_api.hrl ssl_record.hrl ssl_cipher.hrl \
  ssl_handshake.hrl ssl_srp.hrl
$(EBIN)/ssl_admin_sup.$(EMULATOR): ssl_admin_sup.erl
$(EBIN)/ssl_alert.$(EMULATOR): ssl_alert.erl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_record.hrl ssl_internal.hrl
$(EBIN)/ssl_app.$(EMULATOR): ssl_app.erl
$(EBIN)/ssl_certificate.$(EMULATOR): ssl_certificate.erl ssl_handshake.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_internal.hrl
$(EBIN)/ssl_cipher.$(EMULATOR): ssl_cipher.erl ssl_internal.hrl ssl_record.hrl \
  ssl_cipher.hrl ssl_handshake.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  tls_handshake_1_3.hrl tls_handshake.hrl
$(EBIN)/ssl_cipher_format.$(EMULATOR): ssl_cipher_format.erl ssl_api.hrl ssl_cipher.hrl \
  ssl_internal.hrl
$(EBIN)/ssl_config.$(EMULATOR): ssl_config.erl ssl_internal.hrl ssl_connection.hrl \
  ssl_record.hrl ssl_handshake.hrl ssl_srp.hrl ssl_cipher.hrl
$(EBIN)/ssl_connection.$(EMULATOR): ssl_connection.erl ssl_api.hrl ssl_connection.hrl \
  ssl_internal.hrl ssl_record.hrl ssl_handshake.hrl ssl_srp.hrl \
  ssl_cipher.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
$(EBIN)/ssl_connection_sup.$(EMULATOR): ssl_connection_sup.erl
$(EBIN)/ssl_crl.$(EMULATOR): ssl_crl.erl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_internal.hrl
$(EBIN)/ssl_crl_cache.$(EMULATOR): ssl_crl_cache.erl ssl_internal.hrl
$(EBIN)/ssl_crl_hash_dir.$(EMULATOR): ssl_crl_hash_dir.erl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
$(EBIN)/ssl_dh_groups.$(EMULATOR): ssl_dh_groups.erl
$(EBIN)/ssl_dist_admin_sup.$(EMULATOR): ssl_dist_admin_sup.erl
$(EBIN)/ssl_dist_connection_sup.$(EMULATOR): ssl_dist_connection_sup.erl
$(EBIN)/ssl_dist_sup.$(EMULATOR): ssl_dist_sup.erl
$(EBIN)/ssl_handshake.$(EMULATOR): ssl_handshake.erl ssl_handshake.hrl ssl_record.hrl \
  ssl_cipher.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_internal.hrl ssl_srp.hrl tls_handshake_1_3.hrl tls_handshake.hrl
$(EBIN)/ssl_listen_tracker_sup.$(EMULATOR): ssl_listen_tracker_sup.erl
$(EBIN)/ssl_logger.$(EMULATOR): ssl_logger.erl ssl_internal.hrl tls_record.hrl \
  ssl_record.hrl ssl_cipher.hrl tls_handshake.hrl ssl_handshake.hrl \
  dtls_handshake.hrl ssl_api.hrl tls_handshake_1_3.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
$(EBIN)/ssl_manager.$(EMULATOR): ssl_manager.erl ssl_handshake.hrl ssl_internal.hrl \
  ssl_api.hrl \
  ../../../bootstrap/lib/kernel/include/file.hrl
$(EBIN)/ssl_pem_cache.$(EMULATOR): ssl_pem_cache.erl ssl_handshake.hrl ssl_internal.hrl \
  ../../../bootstrap/lib/kernel/include/file.hrl
$(EBIN)/ssl_pkix_db.$(EMULATOR): ssl_pkix_db.erl ssl_internal.hrl \
  ../../../bootstrap/lib/kernel/include/file.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
$(EBIN)/ssl_record.$(EMULATOR): ssl_record.erl ssl_record.hrl ssl_connection.hrl \
  ssl_internal.hrl ssl_handshake.hrl ssl_srp.hrl ssl_cipher.hrl \
  ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl
$(EBIN)/ssl_session.$(EMULATOR): ssl_session.erl ssl_handshake.hrl ssl_internal.hrl \
  ssl_api.hrl
$(EBIN)/ssl_session_cache.$(EMULATOR): ssl_session_cache.erl ssl_handshake.hrl \
  ssl_internal.hrl
$(EBIN)/ssl_srp_primes.$(EMULATOR): ssl_srp_primes.erl
$(EBIN)/ssl_sup.$(EMULATOR): ssl_sup.erl
$(EBIN)/ssl_v3.$(EMULATOR): ssl_v3.erl ssl_cipher.hrl ssl_internal.hrl ssl_record.hrl
$(EBIN)/tls_bloom_filter.$(EMULATOR): tls_bloom_filter.erl
$(EBIN)/tls_connection.$(EMULATOR): tls_connection.erl tls_connection.hrl \
  ssl_connection.hrl ssl_internal.hrl ssl_record.hrl ssl_handshake.hrl \
  ssl_srp.hrl ssl_cipher.hrl tls_record.hrl tls_handshake.hrl \
  tls_handshake_1_3.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_api.hrl
$(EBIN)/tls_connection_sup.$(EMULATOR): tls_connection_sup.erl
$(EBIN)/tls_connection_1_3.$(EMULATOR): tls_connection_1_3.erl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_connection.hrl ssl_internal.hrl ssl_record.hrl ssl_handshake.hrl \
  ssl_srp.hrl ssl_cipher.hrl tls_handshake.hrl tls_handshake_1_3.hrl
$(EBIN)/tls_handshake.$(EMULATOR): tls_handshake.erl tls_handshake.hrl ssl_handshake.hrl \
  tls_handshake_1_3.hrl tls_record.hrl ssl_record.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_internal.hrl ssl_cipher.hrl ssl_api.hrl
$(EBIN)/tls_handshake_1_3.$(EMULATOR): tls_handshake_1_3.erl tls_handshake_1_3.hrl \
  tls_handshake.hrl ssl_handshake.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_cipher.hrl ssl_connection.hrl ssl_internal.hrl ssl_record.hrl \
  ssl_srp.hrl
$(EBIN)/tls_record.$(EMULATOR): tls_record.erl tls_record.hrl ssl_record.hrl \
  ssl_internal.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  tls_handshake.hrl ssl_handshake.hrl ssl_cipher.hrl
$(EBIN)/tls_record_1_3.$(EMULATOR): tls_record_1_3.erl tls_record.hrl ssl_record.hrl \
  tls_record_1_3.hrl ssl_internal.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_cipher.hrl
$(EBIN)/tls_client_ticket_store.$(EMULATOR): tls_client_ticket_store.erl \
  tls_handshake_1_3.hrl tls_handshake.hrl ssl_handshake.hrl
$(EBIN)/tls_sender.$(EMULATOR): tls_sender.erl ssl_internal.hrl ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_handshake.hrl ssl_api.hrl ssl_record.hrl tls_handshake_1_3.hrl \
  tls_handshake.hrl
$(EBIN)/tls_server_session_ticket.$(EMULATOR): tls_server_session_ticket.erl \
  tls_handshake_1_3.hrl tls_handshake.hrl ssl_handshake.hrl ssl_internal.hrl \
  ssl_alert.hrl \
  ../../../bootstrap/lib/kernel/include/logger.hrl \
  ssl_cipher.hrl
$(EBIN)/tls_server_session_ticket_sup.$(EMULATOR): tls_server_session_ticket_sup.erl
$(EBIN)/tls_server_sup.$(EMULATOR): tls_server_sup.erl
$(EBIN)/tls_socket.$(EMULATOR): tls_socket.erl ssl_internal.hrl ssl_api.hrl
$(EBIN)/tls_sup.$(EMULATOR): tls_sup.erl
$(EBIN)/tls_v1.$(EMULATOR): tls_v1.erl ssl_cipher.hrl ssl_internal.hrl ssl_record.hrl
$(EBIN)/ssl_crl_cache_api.$(EMULATOR): ssl_crl_cache_api.erl
$(EBIN)/ssl_session_cache_api.$(EMULATOR): ssl_session_cache_api.erl ssl_handshake.hrl \
  ssl_internal.hrl ssl_api.hrl
