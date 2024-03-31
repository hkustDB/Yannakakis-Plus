import os
import statistics


if __name__ == "__main__":
    paths = os.walk('/Users/cbn/Desktop/test/SQLRewriter/query/extra')

    for path, dir_lst, file_lst in paths:
        for dir_name in dir_lst:
            sub_paths = os.walk(os.path.join(path, dir_name))
            base_time = -1
            rewrite_time = []
            for sub_path, sub_dir_lst, sub_file_lst in sub_paths:
                for file_name in sub_file_lst:
                    if file_name.startswith('log_query'):
                        base_file= open(os.path.join(sub_path, file_name), 'r')
                        lines = base_file.readlines()
                        base_time_list = []
                        for line in lines:
                            if line.startswith('1 row'):
                                base_time_list.append(float(line.split(' ')[4][1:]))
                        base_time_list.sort()
                        if len(base_time_list) >= 2:
                            base_time = base_time_list[1]
                        elif len(base_time_list) == 1:
                            base_time = base_time_list[0]
                        base_file.close()
                    elif file_name.startswith('log_rewrite'):
                        rewrite_file= open(os.path.join(sub_path, file_name), 'r')
                        lines = rewrite_file.readlines()
                        rewrite_time_list = []
                        for line in lines[:-1]:
                            if line.startswith('1 row'):
                                rewrite_time.append(float(line.split(' ')[4][1:]))
                        rewrite_time_list.sort()
                        if len(rewrite_time_list) >= 2:
                            rewrite_time.append(rewrite_time_list[1])
                        elif len(rewrite_time_list) == 1:
                            rewrite_time.append(rewrite_time_list[0])
                        rewrite_file.close()
            original_time = rewrite_time.copy()
            rewrite_time.sort()
            runtime_staistics = open(os.path.join(sub_path, 'runtime_statistics.txt'), 'w')
            if base_time != -1:
                runtime_staistics.write('base_time: ' + str(base_time) + '\n')
            if len(rewrite_time) != 0:
                mean = statistics.mean(rewrite_time)
                min, max = rewrite_time[0], rewrite_time[-1]
                variance = statistics.variance(rewrite_time)
                median = statistics.median(rewrite_time)
                runtime_staistics.write('mean: ' + str(mean) + '\n')
                runtime_staistics.write('min: ' + str(min) + '\n')
                runtime_staistics.write('max: ' + str(max) + '\n')
                runtime_staistics.write('variance: ' + str(variance) + '\n')
                runtime_staistics.write('median: ' + str(median) + '\n')
                runtime_staistics.write('original_time: ' + str(original_time) + '\n')
            
            runtime_staistics.close()

