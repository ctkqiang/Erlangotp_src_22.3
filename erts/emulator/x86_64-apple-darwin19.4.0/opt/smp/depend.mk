$(OBJDIR)/atom.o: beam/atom.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/beam_bif_load.o: beam/beam_bif_load.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/beam_bp.h beam/beam_catches.h beam/erl_bif_unique.h \
  beam/erl_nfunc_sched.h hipe/hipe_bif0.h hipe/hipe_stack.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h
$(OBJDIR)/beam_bp.o: beam/beam_bp.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/beam_bp.h beam/erl_nfunc_sched.h
$(OBJDIR)/beam_catches.o: beam/beam_catches.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/beam_catches.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/global.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/beam_debug.o: beam/beam_debug.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/beam_bp.h beam/erl_bif_unique.h beam/erl_nfunc_sched.h \
  beam/beam_catches.h
$(OBJDIR)/beam_emu.o: beam/beam_emu.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_bif_unique.h beam/erl_map.h beam/dist.h beam/beam_bp.h \
  beam/beam_catches.h beam/erl_nfunc_sched.h hipe/hipe_mode_switch.h \
  hipe/hipe_stack.h hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h hipe/hipe_bif1.h \
  $(TTF_DIR)/beam_hot.h \
  $(TTF_DIR)/beam_warm.h \
  $(TTF_DIR)/beam_cold.h
$(OBJDIR)/beam_load.o: beam/beam_load.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  x86_64-apple-darwin19.4.0/erl_version.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/beam_bp.h \
  beam/big.h beam/beam_catches.h beam/erl_bif_unique.h beam/erl_zlib.h \
  beam/erl_map.h beam/erl_unicode.h hipe/hipe_bif0.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h hipe/hipe_load.h \
  $(TTF_DIR)/beam_pred_funcs.h \
  $(TTF_DIR)/beam_tr_funcs.h
$(OBJDIR)/beam_ranges.o: beam/beam_ranges.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_unicode.h
$(OBJDIR)/bif.o: beam/bif.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h x86_64-apple-darwin19.4.0/erl_version.h \
  beam/erl_bif_unique.h beam/beam_bp.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/erl_map.h beam/erl_nfunc_sched.h
$(OBJDIR)/big.o: beam/big.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/big.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/binary.o: beam/binary.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_bif_unique.h
$(OBJDIR)/break.o: beam/break.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/version.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h \
  x86_64-apple-darwin19.4.0/erl_version.h beam/dist.h
$(OBJDIR)/code_ix.o: beam/code_ix.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/code_ix.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  $(TTF_DIR)/beam_opcodes.h beam/global.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/beam_catches.h
$(OBJDIR)/copy.o: beam/copy.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_map.h beam/erl_fun.h beam/erl_bits.h beam/erl_trace.h \
  beam/erl_db.h hipe/hipe_process.h beam/module.h hipe/hipe_module.h \
  beam/register.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/big.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h
$(OBJDIR)/dist.o: beam/dist.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/dist.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/erl_rbtree.h
$(OBJDIR)/elib_memmove.o: beam/elib_memmove.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h
$(OBJDIR)/erl_afit_alloc.o: beam/erl_afit_alloc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_afit_alloc.h
$(OBJDIR)/erl_alloc.o: beam/erl_alloc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  $(TTF_DIR)/erl_alloc_types.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h beam/erl_thr_progress.h \
  beam/erl_alloc_util.h sys/common/erl_mseg.h beam/lttng-wrapper.h \
  beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/erl_mtrace.h \
  beam/erl_cpu_topology.h beam/erl_thr_queue.h beam/erl_nfunc_sched.h \
  sys/common/erl_check_io.h beam/erl_goodfit_alloc.h \
  beam/erl_bestfit_alloc.h beam/erl_afit_alloc.h \
  beam/erl_ao_firstfit_alloc.h
$(OBJDIR)/erl_alloc_util.o: beam/erl_alloc_util.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/big.h \
  beam/erl_mtrace.h beam/erl_bif_unique.h beam/erl_rbtree.h
$(OBJDIR)/erl_ao_firstfit_alloc.o: beam/erl_ao_firstfit_alloc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  beam/erl_ao_firstfit_alloc.h
$(OBJDIR)/erl_arith.o: beam/erl_arith.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h
$(OBJDIR)/erl_async.o: beam/erl_async.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_thr_queue.h
$(OBJDIR)/erl_bestfit_alloc.o: beam/erl_bestfit_alloc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  beam/erl_bestfit_alloc.h
$(OBJDIR)/erl_bif_atomics.o: beam/erl_bif_atomics.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/export.h beam/index.h beam/hash.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/beam_load.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/global.h beam/module.h hipe/hipe_module.h beam/register.h \
  beam/erl_fun.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_bif_unique.h \
  beam/erl_map.h
$(OBJDIR)/erl_bif_binary.o: beam/erl_bif_binary.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_bif_unique.h
$(OBJDIR)/erl_bif_chksum.o: beam/erl_bif_chksum.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h
$(OBJDIR)/erl_bif_counters.o: beam/erl_bif_counters.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/export.h beam/index.h beam/hash.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/beam_load.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/global.h beam/module.h hipe/hipe_module.h beam/register.h \
  beam/erl_fun.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_bif_unique.h \
  beam/erl_map.h
$(OBJDIR)/erl_bif_ddll.o: beam/erl_bif_ddll.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h x86_64-apple-darwin19.4.0/erl_version.h \
  beam/erl_bif_unique.h
$(OBJDIR)/erl_bif_guard.o: beam/erl_bif_guard.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_bif_unique.h beam/erl_map.h
$(OBJDIR)/erl_bif_info.o: beam/erl_bif_info.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  $(TTF_DIR)/erl_alloc_types.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h beam/erl_thr_progress.h \
  beam/erl_alloc_util.h sys/common/erl_mseg.h beam/lttng-wrapper.h \
  beam/erl_sched_spec_pre_alloc.h beam/erl_node_container_utils.h \
  beam/erl_ptab.h beam/erl_time.h beam/erl_monitor_link.h \
  beam/erl_proc_sig_queue.h beam/erl_utils.h beam/atom.h beam/index.h \
  beam/hash.h $(TTF_DIR)/erl_atom_table.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/export.h beam/beam_load.h beam/erl_process.h \
  beam/erl_process_lock.h beam/erl_port.h beam/erl_message.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  x86_64-apple-darwin19.4.0/erl_version.h \
  $(TTF_DIR)/erl_compile_flags.h \
  beam/erl_db_util.h beam/erl_flxctr.h beam/erl_bif_unique.h \
  beam/erl_db_hash.h beam/erl_db_tree.h beam/erl_db_catree.h \
  beam/erl_mtrace.h beam/dist.h beam/erl_cpu_topology.h beam/erl_map.h \
  sys/common/erl_check_io.h hipe/hipe_arch.h hipe/hipe_amd64.h \
  hipe/hipe_x86.h $(TTF_DIR)/hipe_amd64_asm.h
$(OBJDIR)/erl_bif_lists.o: beam/erl_bif_lists.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/erl_rbtree.h
$(OBJDIR)/erl_bif_op.o: beam/erl_bif_op.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h x86_64-apple-darwin19.4.0/erl_version.h \
  beam/erl_bif_unique.h beam/erl_map.h
$(OBJDIR)/erl_bif_os.o: beam/erl_bif_os.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h x86_64-apple-darwin19.4.0/erl_version.h
$(OBJDIR)/erl_bif_persistent.o: beam/erl_bif_persistent.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_map.h \
  beam/erl_bif_unique.h beam/big.h
$(OBJDIR)/erl_bif_port.o: beam/erl_bif_port.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h x86_64-apple-darwin19.4.0/erl_version.h \
  beam/erl_bif_unique.h beam/erl_db_util.h beam/erl_flxctr.h \
  beam/packet_parser.h
$(OBJDIR)/erl_bif_re.o: beam/erl_bif_re.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h pcre/pcre.h
$(OBJDIR)/erl_bif_trace.o: beam/erl_bif_trace.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h x86_64-apple-darwin19.4.0/erl_version.h beam/beam_bp.h \
  beam/erl_bif_unique.h
$(OBJDIR)/erl_bif_unique.o: beam/erl_bif_unique.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/export.h \
  beam/index.h beam/hash.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/beam_load.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_message.h beam/erl_proc_sig_queue.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/global.h beam/module.h \
  hipe/hipe_module.h beam/register.h beam/erl_fun.h beam/erl_debug.h \
  beam/error.h sys/common/erl_poll.h sys/common/erl_poll_api.h \
  beam/erl_io_queue.h beam/erl_nif.h beam/erl_nif_api_funcs.h \
  beam/dtrace-wrapper.h
$(OBJDIR)/erl_bits.o: beam/erl_bits.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_bif_unique.h
$(OBJDIR)/erl_cpu_topology.o: beam/erl_cpu_topology.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_cpu_topology.h beam/erl_flxctr.h beam/big.h \
  beam/erl_bif_unique.h
$(OBJDIR)/erl_db.o: beam/erl_db.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/erl_rbtree.h
$(OBJDIR)/erl_db_catree.o: beam/erl_db_catree.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/erl_db_tree_util.h
$(OBJDIR)/erl_db_hash.o: beam/erl_db_hash.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h
$(OBJDIR)/erl_db_tree.o: beam/erl_db_tree.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/erl_db_tree_util.h
$(OBJDIR)/erl_db_util.o: beam/erl_db_util.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/erl_map.h
$(OBJDIR)/erl_debug.o: beam/erl_debug.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/big.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/beam_catches.h \
  beam/erl_map.h
$(OBJDIR)/erl_drv_thread.o: beam/erl_drv_thread.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/erl_dyn_lock_check.o: beam/erl_dyn_lock_check.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_dyn_lock_check.h
$(OBJDIR)/erl_flxctr.o: beam/erl_flxctr.c beam/erl_flxctr.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_bif_unique.h
$(OBJDIR)/erl_fun.o: beam/erl_fun.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h hipe/hipe_mode_switch.h \
  hipe/hipe_stack.h hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h
$(OBJDIR)/erl_gc.o: beam/erl_gc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_map.h beam/erl_fun.h beam/erl_bits.h beam/erl_trace.h \
  beam/erl_db.h hipe/hipe_process.h beam/module.h hipe/hipe_module.h \
  beam/register.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/beam_catches.h \
  hipe/hipe_stack.h hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_mode_switch.h hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h beam/dist.h \
  beam/erl_nfunc_sched.h
$(OBJDIR)/erl_goodfit_alloc.o: beam/erl_goodfit_alloc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  beam/erl_goodfit_alloc.h
$(OBJDIR)/erl_hl_timer.o: beam/erl_hl_timer.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/erl_rbtree.h
$(OBJDIR)/erl_init.o: beam/erl_init.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  x86_64-apple-darwin19.4.0/erl_version.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/beam_bp.h beam/dist.h \
  beam/erl_mtrace.h beam/erl_printf_term.h \
  ../include/internal/erl_printf_format.h beam/packet_parser.h \
  beam/erl_cpu_topology.h beam/erl_thr_queue.h sys/common/erl_check_io.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h hipe/hipe_signal.h
$(OBJDIR)/erl_io_queue.o: beam/erl_io_queue.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h
$(OBJDIR)/erl_lock_check.o: beam/erl_lock_check.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/erl_lock_count.o: beam/erl_lock_count.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h
$(OBJDIR)/erl_lock_flags.o: beam/erl_lock_flags.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_lock_flags.h
$(OBJDIR)/erl_map.o: beam/erl_map.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/erl_map.h
$(OBJDIR)/erl_math.o: beam/erl_math.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h
$(OBJDIR)/erl_md5.o: beam/erl_md5.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h
$(OBJDIR)/erl_message.o: beam/erl_message.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/beam_bp.h
$(OBJDIR)/erl_monitor_link.o: beam/erl_monitor_link.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_rbtree.h
$(OBJDIR)/erl_msacc.o: beam/erl_msacc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_bif_unique.h \
  beam/big.h beam/erl_map.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/erl_mtrace.o: beam/erl_mtrace.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_sock.h \
  ../include/internal/erl_memory_trace_protocol.h beam/erl_mtrace.h
$(OBJDIR)/erl_nfunc_sched.o: beam/erl_nfunc_sched.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_nfunc_sched.h
$(OBJDIR)/erl_nif.o: beam/erl_nif.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_nif.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_binary.h \
  beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h beam/erl_trace.h \
  beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h beam/module.h \
  hipe/hipe_module.h beam/register.h beam/erl_fun.h beam/erl_debug.h \
  beam/error.h sys/common/erl_poll.h sys/common/erl_poll_api.h \
  beam/erl_io_queue.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/erl_map.h beam/beam_bp.h \
  beam/erl_nfunc_sched.h
$(OBJDIR)/erl_node_tables.o: beam/erl_node_tables.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/dist.h beam/big.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/erl_db_util.h beam/erl_flxctr.h \
  beam/erl_db_hash.h beam/erl_db_tree.h beam/erl_db_catree.h
$(OBJDIR)/erl_port_task.o: beam/erl_port_task.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/dist.h \
  sys/common/erl_check_io.h
$(OBJDIR)/erl_posix_str.o: beam/erl_posix_str.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  ../include/internal/erl_errno.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h
$(OBJDIR)/erl_printf_term.o: beam/erl_printf_term.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_printf_term.h ../include/internal/erl_printf_format.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  ../include/internal/erl_printf.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/ethread.h \
  ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/big.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_map.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h
$(OBJDIR)/erl_proc_sig_queue.o: beam/erl_proc_sig_queue.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/dist.h \
  beam/beam_bp.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h
$(OBJDIR)/erl_process.o: beam/erl_process.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/dist.h \
  beam/beam_catches.h beam/beam_bp.h beam/erl_cpu_topology.h \
  beam/erl_thr_queue.h beam/erl_nfunc_sched.h sys/common/erl_check_io.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h hipe/hipe_signal.h
$(OBJDIR)/erl_process_dict.o: beam/erl_process_dict.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h x86_64-apple-darwin19.4.0/erl_version.h
$(OBJDIR)/erl_process_dump.o: beam/erl_process_dump.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/big.h beam/erl_bif_unique.h beam/erl_db_hash.h \
  beam/erl_db_tree.h beam/erl_db_catree.h beam/dist.h \
  beam/beam_catches.h beam/erl_map.h
$(OBJDIR)/erl_process_lock.o: beam/erl_process_lock.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_process.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_process_lock.h beam/erl_port.h beam/erl_vm.h \
  beam/erl_message.h beam/erl_proc_sig_queue.h beam/external.h \
  beam/erl_node_tables.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_process_dict.h beam/erl_node_container_utils.h \
  beam/erl_ptab.h beam/erl_time.h beam/erl_monitor_link.h \
  beam/erl_utils.h beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h
$(OBJDIR)/erl_ptab.o: beam/erl_ptab.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_ptab.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_time.h beam/erl_monitor_link.h beam/erl_proc_sig_queue.h \
  beam/erl_utils.h beam/atom.h beam/index.h beam/hash.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  $(TTF_DIR)/erl_atom_table.h beam/erl_process.h \
  beam/erl_process_lock.h beam/erl_port.h beam/erl_vm.h \
  beam/erl_message.h beam/external.h beam/erl_node_tables.h \
  beam/erl_process_dict.h beam/erl_node_container_utils.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/global.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_bif_unique.h \
  beam/big.h
$(OBJDIR)/erl_sched_spec_pre_alloc.o: beam/erl_sched_spec_pre_alloc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_process.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_process_lock.h beam/erl_port.h beam/erl_vm.h \
  beam/erl_message.h beam/erl_proc_sig_queue.h beam/external.h \
  beam/erl_node_tables.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_process_dict.h beam/erl_node_container_utils.h \
  beam/erl_ptab.h beam/erl_time.h beam/erl_monitor_link.h \
  beam/erl_utils.h beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h
$(OBJDIR)/erl_term.o: beam/erl_term.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_map.h
$(OBJDIR)/erl_thr_progress.o: beam/erl_thr_progress.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_thr_progress.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_alloc_util.h sys/common/erl_mseg.h beam/lttng-wrapper.h \
  beam/erl_sched_spec_pre_alloc.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h beam/index.h \
  beam/hash.h $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h beam/global.h beam/module.h \
  hipe/hipe_module.h beam/register.h beam/erl_fun.h beam/erl_debug.h \
  beam/error.h sys/common/erl_poll.h sys/common/erl_poll_api.h \
  beam/erl_io_queue.h beam/erl_nif.h beam/erl_nif_api_funcs.h \
  beam/dtrace-wrapper.h
$(OBJDIR)/erl_thr_queue.o: beam/erl_thr_queue.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_thr_queue.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h beam/index.h \
  beam/hash.h $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h
$(OBJDIR)/erl_time_sup.o: beam/erl_time_sup.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/big.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/erl_trace.o: beam/erl_trace.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/big.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/dist.h \
  beam/beam_bp.h beam/erl_bif_unique.h beam/erl_map.h
$(OBJDIR)/erl_unicode.o: beam/erl_unicode.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h beam/erl_unicode.h \
  beam/erl_unicode_normalize.h
$(OBJDIR)/erl_zlib.o: beam/erl_zlib.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_zlib.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h
$(OBJDIR)/erlang_lttng.o: beam/erlang_lttng.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h
$(OBJDIR)/export.o: beam/export.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/external.o: beam/external.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/dist.h beam/erl_bif_unique.h beam/erl_zlib.h beam/erl_map.h
$(OBJDIR)/hash.o: beam/hash.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/hash.h
$(OBJDIR)/index.o: beam/index.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/io.o: beam/io.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif.h beam/erl_nif_api_funcs.h beam/erl_vm.h beam/global.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/dtrace-wrapper.h \
  beam/dist.h beam/big.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h x86_64-apple-darwin19.4.0/erl_version.h \
  beam/erl_map.h
$(OBJDIR)/module.o: beam/module.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/beam_catches.h
$(OBJDIR)/packet_parser.o: beam/packet_parser.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/packet_parser.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h beam/sys.h \
  sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/register.o: beam/register.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/safe_hash.o: beam/safe_hash.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/safe_hash.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h
$(OBJDIR)/time.o: beam/time.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/utils.o: beam/utils.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_map.h beam/erl_fun.h beam/erl_bits.h beam/erl_trace.h \
  beam/erl_db.h hipe/hipe_process.h beam/module.h hipe/hipe_module.h \
  beam/register.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/big.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/packet_parser.h beam/erl_db_util.h \
  beam/erl_flxctr.h beam/erl_db_hash.h beam/erl_db_tree.h \
  beam/erl_db_catree.h beam/dist.h beam/erl_thr_queue.h beam/beam_bp.h \
  sys/common/erl_check_io.h hipe/hipe_mode_switch.h hipe/hipe_stack.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  beam/erl_nfunc_sched.h
$(OBJDIR)/gzio.o: drivers/common/gzio.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h beam/sys.h \
  sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  drivers/common/gzio_zutil.h beam/erl_zlib.h drivers/common/gzio.h
$(OBJDIR)/inet_drv.o: drivers/common/inet_drv.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h beam/sys.h \
  sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/packet_parser.h beam/erl_sock.h
$(OBJDIR)/ram_file_drv.o: drivers/common/ram_file_drv.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  drivers/common/gzio.h
$(OBJDIR)/bin_drv.o: drivers/unix/bin_drv.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h
$(OBJDIR)/multi_drv.o: drivers/unix/multi_drv.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h beam/sys.h \
  sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/sig_drv.o: drivers/unix/sig_drv.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h
$(OBJDIR)/ttsl_drv.o: drivers/unix/ttsl_drv.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h beam/sys.h \
  sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/erl_tracer_nif.o: nifs/common/erl_tracer_nif.c beam/erl_nif.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/prim_buffer_nif.o: nifs/common/prim_buffer_nif.c beam/erl_nif.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/prim_file_nif.o: nifs/common/prim_file_nif.c beam/erl_nif.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_driver.h nifs/common/prim_file_nif.h
$(OBJDIR)/prim_net_nif.o: nifs/common/prim_net_nif.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_nif.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h nifs/common/socket_dbg.h \
  nifs/common/socket_int.h nifs/common/socket_tarray.h \
  nifs/common/socket_util.h
$(OBJDIR)/socket_dbg.o: nifs/common/socket_dbg.c beam/erl_nif.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h nifs/common/socket_util.h \
  nifs/common/socket_int.h nifs/common/socket_dbg.h
$(OBJDIR)/socket_nif.o: nifs/common/socket_nif.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_nif.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h nifs/common/socket_dbg.h \
  nifs/common/socket_tarray.h nifs/common/socket_int.h \
  nifs/common/socket_util.h
$(OBJDIR)/socket_tarray.o: nifs/common/socket_tarray.c beam/erl_nif.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h nifs/common/socket_int.h beam/sys.h \
  sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  nifs/common/socket_util.h nifs/common/socket_tarray.h
$(OBJDIR)/socket_util.o: nifs/common/socket_util.c nifs/common/socket_int.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_nif.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  nifs/common/socket_util.h nifs/common/socket_dbg.h
$(OBJDIR)/zlib_nif.o: nifs/common/zlib_nif.c beam/erl_nif.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/unix_prim_file.o: nifs/unix/unix_prim_file.c beam/erl_nif.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_nif_api_funcs.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  nifs/common/prim_file_nif.h
$(OBJDIR)/erl_child_setup.o: sys/unix/erl_child_setup.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  sys/unix/sys_uds.h beam/hash.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  sys/unix/erl_child_setup.h
$(OBJDIR)/erl_main.o: sys/unix/erl_main.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/erl_unix_sys_ddll.o: sys/unix/erl_unix_sys_ddll.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/sys.o: sys/unix/sys.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_thr_progress.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_vm.h beam/erl_message.h \
  beam/erl_proc_sig_queue.h beam/external.h beam/erl_node_tables.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_alloc_util.h sys/common/erl_mseg.h beam/lttng-wrapper.h \
  beam/erl_sched_spec_pre_alloc.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h beam/index.h \
  beam/hash.h $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h beam/global.h beam/module.h \
  hipe/hipe_module.h beam/register.h beam/erl_fun.h beam/erl_debug.h \
  beam/error.h sys/common/erl_poll.h sys/common/erl_poll_api.h \
  beam/erl_io_queue.h beam/erl_nif.h beam/erl_nif_api_funcs.h \
  beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  sys/common/erl_check_io.h beam/erl_cpu_topology.h
$(OBJDIR)/sys_drivers.o: sys/unix/sys_drivers.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_cpu_topology.h \
  sys/unix/sys_uds.h sys/unix/erl_child_setup.h
$(OBJDIR)/sys_env.o: sys/unix/sys_env.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h beam/index.h \
  beam/hash.h $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h
$(OBJDIR)/sys_float.o: sys/unix/sys_float.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/sys_time.o: sys/unix/sys_time.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  sys/common/erl_os_monotonic_time_extender.h
$(OBJDIR)/sys_uds.o: sys/unix/sys_uds.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  sys/unix/sys_uds.h
$(OBJDIR)/erl_check_io.o: sys/common/erl_check_io.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  sys/common/erl_check_io.h beam/erl_bif_unique.h beam/big.h
$(OBJDIR)/erl_mmap.o: sys/common/erl_mmap.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  $(TTF_DIR)/erl_alloc_types.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_alloc.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_process_dict.h beam/erl_node_container_utils.h \
  beam/erl_ptab.h beam/erl_time.h beam/erl_monitor_link.h \
  beam/erl_utils.h beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h
$(OBJDIR)/erl_mseg.o: sys/common/erl_mseg.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  $(TTF_DIR)/erl_alloc_types.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  sys/common/erl_mseg.h beam/global.h beam/erl_alloc.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h beam/lttng-wrapper.h \
  beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_mtrace.h \
  beam/big.h sys/common/erl_util_queue.h
$(OBJDIR)/erl_mtrace_sys_wrap.o: sys/common/erl_mtrace_sys_wrap.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_mtrace.h $(TTF_DIR)/erl_alloc_types.h
$(OBJDIR)/erl_os_monotonic_time_extender.o: \
  sys/common/erl_os_monotonic_time_extender.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  sys/common/erl_os_monotonic_time_extender.h beam/sys.h \
  sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h
$(OBJDIR)/erl_osenv.o: sys/common/erl_osenv.c sys/common/erl_osenv.h \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h beam/global.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/erl_rbtree.h
$(OBJDIR)/erl_poll.o $(OBJDIR)/erl_poll.flbk.o: sys/common/erl_poll.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_thr_progress.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_alloc_util.h sys/common/erl_mseg.h beam/lttng-wrapper.h \
  beam/erl_sched_spec_pre_alloc.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h beam/index.h \
  beam/hash.h $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h
$(OBJDIR)/erl_sys_common_misc.o: sys/common/erl_sys_common_misc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/preload.o: x86_64-apple-darwin19.4.0/preload.c
$(OBJDIR)/beam_opcodes.o: $(TTF_DIR)/beam_opcodes.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/export.h beam/index.h beam/hash.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/beam_load.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_message.h beam/erl_proc_sig_queue.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/driver_tab.o: $(TTF_DIR)/driver_tab.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h
$(OBJDIR)/erl_atom_table.o: $(TTF_DIR)/erl_atom_table.c
$(OBJDIR)/erl_bif_table.o: $(TTF_DIR)/erl_bif_table.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/export.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/index.h beam/hash.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/beam_load.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/bif.h $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/erl_bif_wrap.o: $(TTF_DIR)/erl_bif_wrap.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/export.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/index.h beam/hash.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/beam_load.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/global.h beam/module.h hipe/hipe_module.h beam/register.h \
  beam/erl_fun.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/erl_dirty_bif_wrap.o: \
  $(TTF_DIR)/erl_dirty_bif_wrap.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_process.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_process_lock.h beam/erl_port.h beam/erl_vm.h \
  beam/erl_message.h beam/erl_proc_sig_queue.h beam/external.h \
  beam/erl_node_tables.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_process_dict.h beam/erl_node_container_utils.h \
  beam/erl_ptab.h beam/erl_time.h beam/erl_monitor_link.h \
  beam/erl_utils.h beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h beam/erl_nfunc_sched.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/error.h
$(OBJDIR)/erl_guard_bifs.o: $(TTF_DIR)/erl_guard_bifs.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/export.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/index.h beam/hash.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/beam_load.h \
  beam/erl_process.h beam/erl_process_lock.h beam/erl_port.h \
  beam/erl_vm.h beam/erl_message.h beam/erl_proc_sig_queue.h \
  beam/external.h beam/erl_node_tables.h beam/erl_process_dict.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_utils.h beam/atom.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/global.h beam/module.h hipe/hipe_module.h beam/register.h \
  beam/erl_fun.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h
$(OBJDIR)/hipe_nbif_impl.o: $(TTF_DIR)/hipe_nbif_impl.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/erl_process.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_process_lock.h beam/erl_port.h beam/erl_vm.h \
  beam/erl_message.h beam/erl_proc_sig_queue.h beam/external.h \
  beam/erl_node_tables.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_process_dict.h beam/erl_node_container_utils.h \
  beam/erl_ptab.h beam/erl_time.h beam/erl_monitor_link.h \
  beam/erl_utils.h beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h \
  beam/erl_port_task.h beam/erl_sys_driver.h beam/erl_driver.h \
  beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/export.h \
  beam/code_ix.h $(TTF_DIR)/beam_opcodes.h \
  beam/beam_load.h beam/erl_bits.h beam/erl_nfunc_sched.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/error.h
$(ZLIB_OBJDIR)/adler32.o: zlib/adler32.c zlib/zutil.h zlib/zlib.h zlib/zconf.h
$(ZLIB_OBJDIR)/compress.o: zlib/compress.c zlib/zlib.h zlib/zconf.h
$(ZLIB_OBJDIR)/crc32.o: zlib/crc32.c zlib/zutil.h zlib/zlib.h zlib/zconf.h zlib/crc32.h
$(ZLIB_OBJDIR)/uncompr.o: zlib/uncompr.c zlib/zlib.h zlib/zconf.h
$(ZLIB_OBJDIR)/deflate.o: zlib/deflate.c zlib/deflate.h zlib/zutil.h zlib/zlib.h \
  zlib/zconf.h
$(ZLIB_OBJDIR)/trees.o: zlib/trees.c zlib/deflate.h zlib/zutil.h zlib/zlib.h \
  zlib/zconf.h zlib/trees.h
$(ZLIB_OBJDIR)/zutil.o: zlib/zutil.c zlib/zutil.h zlib/zlib.h zlib/zconf.h zlib/gzguts.h
$(ZLIB_OBJDIR)/inflate.o: zlib/inflate.c zlib/zutil.h zlib/zlib.h zlib/zconf.h \
  zlib/inftrees.h zlib/inflate.h zlib/inffast.h zlib/inffixed.h
$(ZLIB_OBJDIR)/inftrees.o: zlib/inftrees.c zlib/zutil.h zlib/zlib.h zlib/zconf.h \
  zlib/inftrees.h
$(ZLIB_OBJDIR)/inffast.o: zlib/inffast.c zlib/zutil.h zlib/zlib.h zlib/zconf.h \
  zlib/inftrees.h zlib/inflate.h zlib/inffast.h
$(OBJDIR)/hipe_amd64.o: hipe/hipe_amd64.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_bif_unique.h hipe/hipe_arch.h hipe/hipe_amd64.h \
  hipe/hipe_x86.h $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_bif0.h hipe/hipe_native_bif.h \
  $(TTF_DIR)/erl_bif_list.h \
  $(TTF_DIR)/hipe_literals.h
$(OBJDIR)/hipe_arm.o: hipe/hipe_arm.c
$(OBJDIR)/hipe_bif0.o: hipe/hipe_bif0.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/error.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/erl_vm.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h sys/common/erl_poll.h sys/common/erl_poll_api.h \
  beam/erl_io_queue.h beam/erl_nif.h beam/erl_nif_api_funcs.h \
  beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_db_util.h beam/erl_flxctr.h beam/erl_bif_unique.h \
  beam/erl_db_hash.h beam/erl_db_tree.h beam/erl_db_catree.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h hipe/hipe_stack.h \
  hipe/hipe_mode_switch.h hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  hipe/hipe_native_bif.h \
  $(TTF_DIR)/erl_bif_list.h hipe/hipe_bif0.h \
  hipe/hipe_load.h $(TTF_DIR)/hipe_literals.h \
  hipe/hipe_primops.h hipe/hipe_amd64_primops.h
$(OBJDIR)/hipe_bif1.o: hipe/hipe_bif1.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  hipe/hipe_bif0.h hipe/hipe_bif1.h
$(OBJDIR)/hipe_bif2.o: hipe/hipe_bif2.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/error.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/erl_vm.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h sys/common/erl_poll.h sys/common/erl_poll_api.h \
  beam/erl_io_queue.h beam/erl_nif.h beam/erl_nif_api_funcs.h \
  beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  beam/erl_map.h hipe/hipe_debug.h hipe/hipe_mode_switch.h \
  hipe/hipe_stack.h hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h
$(OBJDIR)/hipe_bif64.o: hipe/hipe_bif64.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h beam/big.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h hipe/hipe_bif0.h \
  hipe/hipe_bif64.h
$(OBJDIR)/hipe_debug.o: hipe/hipe_debug.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/beam_catches.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h hipe/hipe_debug.h \
  beam/erl_map.h
$(OBJDIR)/hipe_gc.o: hipe/hipe_gc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_map.h beam/erl_fun.h beam/erl_bits.h beam/erl_trace.h \
  beam/erl_db.h hipe/hipe_process.h beam/module.h hipe/hipe_module.h \
  beam/register.h beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h hipe/hipe_stack.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h hipe/hipe_gc.h \
  hipe/hipe_amd64_gc.h hipe/hipe_x86_gc.h \
  $(TTF_DIR)/hipe_x86_asm.h
$(OBJDIR)/hipe_load.o: hipe/hipe_load.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h hipe/hipe_load.h hipe/hipe_bif0.h
$(OBJDIR)/hipe_mkliterals.o: hipe/hipe_mkliterals.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h \
  $(TTF_DIR)/hipe_arm_asm.h \
  $(TTF_DIR)/hipe_ppc_asm.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  $(TTF_DIR)/hipe_sparc_asm.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h
$(OBJDIR)/hipe_mode_switch.o: hipe/hipe_mode_switch.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/beam_catches.h \
  hipe/hipe_mode_switch.h hipe/hipe_stack.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h hipe/hipe_bif0.h
$(OBJDIR)/hipe_module.o: hipe/hipe_module.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h hipe/hipe_module.h \
  beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h beam/register.h beam/erl_fun.h beam/erl_debug.h \
  beam/error.h sys/common/erl_poll.h sys/common/erl_poll_api.h \
  beam/erl_io_queue.h beam/erl_nif.h beam/erl_nif_api_funcs.h \
  beam/dtrace-wrapper.h
$(OBJDIR)/hipe_native_bif.o: hipe/hipe_native_bif.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_vm.h beam/global.h beam/erl_alloc.h \
  $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h hipe/hipe_mode_switch.h \
  hipe/hipe_stack.h hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_amd64_glue.h hipe/hipe_x86_glue.h \
  $(TTF_DIR)/hipe_x86_asm.h \
  hipe/hipe_native_bif.h \
  $(TTF_DIR)/erl_bif_list.h
$(OBJDIR)/hipe_ppc.o: hipe/hipe_ppc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  beam/erl_bif_unique.h beam/big.h hipe/hipe_arch.h hipe/hipe_amd64.h \
  hipe/hipe_x86.h $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_native_bif.h \
  $(TTF_DIR)/erl_bif_list.h hipe/hipe_bif0.h
$(OBJDIR)/hipe_risc_stack.o: hipe/hipe_risc_stack.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h hipe/hipe_stack.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h
$(OBJDIR)/hipe_sparc.o: hipe/hipe_sparc.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_native_bif.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  $(TTF_DIR)/erl_bif_list.h
$(OBJDIR)/hipe_stack.o: hipe/hipe_stack.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h hipe/hipe_stack.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h
$(OBJDIR)/hipe_x86.o: hipe/hipe_x86.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h hipe/hipe_arch.h \
  hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h \
  hipe/hipe_native_bif.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h \
  $(TTF_DIR)/erl_bif_list.h \
  $(TTF_DIR)/hipe_literals.h
$(OBJDIR)/hipe_x86_signal.o: hipe/hipe_x86_signal.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/sys.h sys/unix/erl_unix_sys.h ../include/internal/erl_errno.h \
  ../include/internal/erl_misc_utils.h beam/erl_lock_check.h \
  beam/erl_threads.h beam/erl_lock_flags.h beam/erl_term.h \
  sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h \
  hipe/hipe_signal.h
$(OBJDIR)/hipe_x86_stack.o: hipe/hipe_x86_stack.c \
  $(ERL_TOP)/erts/x86_64-apple-darwin19.4.0/config.h \
  beam/global.h beam/sys.h sys/unix/erl_unix_sys.h \
  ../include/internal/erl_errno.h ../include/internal/erl_misc_utils.h \
  beam/erl_lock_check.h beam/erl_threads.h beam/erl_lock_flags.h \
  beam/erl_term.h sys/common/erl_mmap.h ../include/internal/erl_printf.h \
  ../include/internal/ethread.h ../include/internal/ethread_inline.h \
  ../include/internal/x86_64/ethread.h \
  ../include/internal/x86_64/../i386/ethread.h \
  ../include/internal/i386/ethr_membar.h \
  ../include/internal/i386/atomic.h \
  ../include/internal/i386/ethr_dw_atomic.h \
  ../include/internal/i386/spinlock.h ../include/internal/i386/rwlock.h \
  ../include/internal/gcc/ethread.h \
  ../include/internal/libatomic_ops/ethread.h \
  ../include/internal/ethr_atomics.h \
  ../include/internal/ethr_optimized_fallbacks.h \
  ../include/internal/pthread/ethr_event.h \
  ../include/internal/ethr_mutex.h beam/erl_lock_count.h \
  beam/erl_dyn_lock_check.h beam/erl_msacc.h sys/common/erl_osenv.h \
  beam/erl_alloc.h $(TTF_DIR)/erl_alloc_types.h \
  beam/erl_thr_progress.h beam/erl_alloc_util.h sys/common/erl_mseg.h \
  beam/lttng-wrapper.h beam/erl_sched_spec_pre_alloc.h beam/erl_vm.h \
  beam/erl_node_container_utils.h beam/erl_ptab.h beam/erl_time.h \
  beam/erl_monitor_link.h beam/erl_proc_sig_queue.h beam/erl_utils.h \
  beam/atom.h beam/index.h beam/hash.h \
  $(TTF_DIR)/erl_atom_table.h beam/code_ix.h \
  $(TTF_DIR)/beam_opcodes.h beam/export.h \
  beam/beam_load.h beam/erl_process.h beam/erl_process_lock.h \
  beam/erl_port.h beam/erl_message.h beam/external.h \
  beam/erl_node_tables.h beam/erl_process_dict.h beam/erl_port_task.h \
  beam/erl_sys_driver.h beam/erl_driver.h beam/erl_drv_nif.h \
  ../include/x86_64-apple-darwin19.4.0/erl_int_sizes_config.h \
  beam/erl_binary.h beam/erl_hl_timer.h beam/erl_async.h beam/erl_gc.h \
  beam/erl_trace.h beam/erl_db.h hipe/hipe_process.h beam/erl_bits.h \
  beam/module.h hipe/hipe_module.h beam/register.h beam/erl_fun.h \
  beam/erl_debug.h beam/error.h sys/common/erl_poll.h \
  sys/common/erl_poll_api.h beam/erl_io_queue.h beam/erl_nif.h \
  beam/erl_nif_api_funcs.h beam/dtrace-wrapper.h beam/bif.h \
  $(TTF_DIR)/erl_bif_table.h \
  $(TTF_DIR)/hipe_nbif_impl.h hipe/hipe_stack.h \
  hipe/hipe_arch.h hipe/hipe_amd64.h hipe/hipe_x86.h \
  $(TTF_DIR)/hipe_amd64_asm.h
