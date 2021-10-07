
        __kernel void test_pipe_max_active_reservations_write(__global int *src, __write_only pipe int out_pipe, __global char *reserve_id, __global int *reserve_id_t_size_aligned, __global int *status)
        {
            __global reserve_id_t *res_id_ptr;
            int reserve_idx;
            int commit_idx;

            for(reserve_idx = 0; reserve_idx < 1; reserve_idx++)
            {
                res_id_ptr = (__global reserve_id_t*)(reserve_id + reserve_idx*reserve_id_t_size_aligned[0]);
                *res_id_ptr = reserve_write_pipe(out_pipe, 1);
                if(is_valid_reserve_id(res_id_ptr[0]))
                {
                    write_pipe(out_pipe, res_id_ptr[0], 0, &src[reserve_idx]);
                }
                else
                {
                    *status = -1;
                    return;
                }
            }

            for(commit_idx = 0; commit_idx < 1; commit_idx++)
            {
                res_id_ptr = (__global reserve_id_t*)(reserve_id + commit_idx*reserve_id_t_size_aligned[0]);
                commit_write_pipe(out_pipe, res_id_ptr[0]);
            }
        }

        __kernel void test_pipe_max_active_reservations_read(__read_only pipe int in_pipe, __global int *dst, __global char *reserve_id, __global int *reserve_id_t_size_aligned, __global int *status)
        {
            __global reserve_id_t *res_id_ptr;
            int reserve_idx;
            int commit_idx;

            for(reserve_idx = 0; reserve_idx < 1; reserve_idx++)
            {
                res_id_ptr = (__global reserve_id_t*)(reserve_id + reserve_idx*reserve_id_t_size_aligned[0]);
                *res_id_ptr = reserve_read_pipe(in_pipe, 1);

                if(is_valid_reserve_id(res_id_ptr[0]))
                {
                    read_pipe(in_pipe, res_id_ptr[0], 0, &dst[reserve_idx]);
                }
                else
                {
                    *status = -1;
                    return;
                }
            }

            for(commit_idx = 0; commit_idx < 1; commit_idx++)
            {
                res_id_ptr = (__global reserve_id_t*)(reserve_id + commit_idx*reserve_id_t_size_aligned[0]);
                commit_read_pipe(in_pipe, res_id_ptr[0]);
            }
        }

        __kernel void pipe_get_reserve_id_t_size(__global int *reserve_id_t_size)
        {
            *reserve_id_t_size = sizeof(reserve_id_t);
        }
        