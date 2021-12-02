__kernel void test_multiple_pipe_write(__global int *src, __write_only pipe int pipe0, __write_only pipe int pipe1, __write_only pipe int pipe2, __write_only pipe int pipe3, __write_only pipe int pipe4, __write_only pipe int pipe5, __write_only pipe int pipe6, __write_only pipe int pipe7, __write_only pipe int pipe8, __write_only pipe int pipe9, __write_only pipe int pipe10, __write_only pipe int pipe11, __write_only pipe int pipe12, __write_only pipe int pipe13, __write_only pipe int pipe14, __write_only pipe int pipe15, int num_pipes )
    {
          int gid = get_global_id(0);
          reserve_id_t res_id;


          if(gid < (get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe0, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe0, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe0, res_id);
                 }
          }
          else if(gid < (2*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe1, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe1, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe1, res_id);
                  }
          }
          
          else if(gid < (3*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe2, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe2, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe2, res_id);
                  }
          }
          
          else if(gid < (4*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe3, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe3, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe3, res_id);
                  }
          }
          
          else if(gid < (5*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe4, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe4, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe4, res_id);
                  }
          }
          
          else if(gid < (6*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe5, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe5, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe5, res_id);
                  }
          }
          
          else if(gid < (7*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe6, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe6, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe6, res_id);
                  }
          }
          
          else if(gid < (8*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe7, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe7, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe7, res_id);
                  }
          }
          
          else if(gid < (9*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe8, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe8, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe8, res_id);
                  }
          }
          
          else if(gid < (10*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe9, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe9, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe9, res_id);
                  }
          }
          
          else if(gid < (11*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe10, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe10, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe10, res_id);
                  }
          }
          
          else if(gid < (12*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe11, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe11, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe11, res_id);
                  }
          }
          
          else if(gid < (13*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe12, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe12, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe12, res_id);
                  }
          }
          
          else if(gid < (14*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe13, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe13, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe13, res_id);
                  }
          }
          
          else if(gid < (15*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe14, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe14, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe14, res_id);
                  }
          }
          
          else if(gid < (16*get_global_size(0))/num_pipes)
          {
                 res_id = reserve_write_pipe(pipe15, 1);
                 if(is_valid_reserve_id(res_id))
                 {
                     write_pipe(pipe15, res_id, 0, &src[gid]);
                     commit_write_pipe(pipe15, res_id);
                  }
          }
          
    }

    __kernel void test_multiple_pipe_read(__global int *dst, __read_only pipe int pipe0, __read_only pipe int pipe1, __read_only pipe int pipe2, __read_only pipe int pipe3, __read_only pipe int pipe4, __read_only pipe int pipe5, __read_only pipe int pipe6, __read_only pipe int pipe7, __read_only pipe int pipe8, __read_only pipe int pipe9, __read_only pipe int pipe10, __read_only pipe int pipe11, __read_only pipe int pipe12, __read_only pipe int pipe13, __read_only pipe int pipe14, __read_only pipe int pipe15, int num_pipes )
    {
            int gid = get_global_id(0);
            reserve_id_t res_id;


            if(gid < (get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe0, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe0, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe0, res_id);
                }
            }
            else if(gid < (2*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe1, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe1, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe1, res_id);
                }
            }
            else if(gid < (3*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe2, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe2, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe2, res_id);
                }
            }
            else if(gid < (4*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe3, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe3, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe3, res_id);
                }
            }
            else if(gid < (5*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe4, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe4, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe4, res_id);
                }
            }
            else if(gid < (6*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe5, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe5, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe5, res_id);
                }
            }
            else if(gid < (7*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe6, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe6, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe6, res_id);
                }
            }
            else if(gid < (8*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe7, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe7, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe7, res_id);
                }
            }
            else if(gid < (9*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe8, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe8, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe8, res_id);
                }
            }
            else if(gid < (10*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe9, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe9, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe9, res_id);
                }
            }
            else if(gid < (11*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe10, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe10, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe10, res_id);
                }
            }
            else if(gid < (12*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe11, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe11, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe11, res_id);
                }
            }
            else if(gid < (13*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe12, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe12, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe12, res_id);
                }
            }
            else if(gid < (14*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe13, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe13, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe13, res_id);
                }
            }
            else if(gid < (15*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe14, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe14, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe14, res_id);
                }
            }
            else if(gid < (16*get_global_size(0))/num_pipes)
            {
                res_id = reserve_read_pipe(pipe15, 1);
                if(is_valid_reserve_id(res_id))
                {
                    read_pipe(pipe15, res_id, 0, &dst[gid]);
                    commit_read_pipe(pipe15, res_id);
                }
            }}