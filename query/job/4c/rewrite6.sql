create or replace view aggView96114175866091975 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin1094294003855949580 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView96114175866091975 where mk.movie_id=aggView96114175866091975.v14;
create or replace view aggView1688313605393038142 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4643676716550841877 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1688313605393038142 where mi_idx.info_type_id=aggView1688313605393038142.v1 and info>'2.0';
create or replace view aggView2767811296358664525 as select v14, MIN(v9) as v26 from aggJoin4643676716550841877 group by v14;
create or replace view aggJoin2062988251893258231 as select v3, v27 as v27, v26 from aggJoin1094294003855949580 join aggView2767811296358664525 using(v14);
create or replace view aggView3526248918297583094 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8908607518075182057 as select v27, v26 from aggJoin2062988251893258231 join aggView3526248918297583094 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8908607518075182057;
