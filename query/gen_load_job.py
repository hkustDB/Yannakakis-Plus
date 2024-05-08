
tables = ['aka_name', 'aka_title', 'cast_info', 'char_name', 'comp_cast_type', 'company_name', 'company_type', 'complete_cast', 'info_type', 'keyword', 'kind_type', 'link_type', 'movie_companies', 'movie_info', 'movie_info_idx', 'movie_keyword', 'movie_link', 'name', 'role_type', 'title', 'person_info']

def genCommand(begin: int, end: int):
    with open('/home/bchenba/SQLRewriter/query/load_job.sql', 'w+') as f:
        for iter in range(begin, end):
            for table in tables:
                f.write('insert into ' + table + ' SELECT * FROM read_parquet(\'/home/bchenba/job_expand/' + table + '_' + str(iter) + '.parquet\');\n')


if __name__ == '__main__':
    genCommand(-50, 0)