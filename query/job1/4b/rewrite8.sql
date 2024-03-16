create or replace view aggView5098844319591855127 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4821093458989908669 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5098844319591855127 where mi_idx.info_type_id=aggView5098844319591855127.v1 and info>'9.0';
create or replace view aggView1987527765673847126 as select v14, MIN(v9) as v26 from aggJoin4821093458989908669 group by v14;
create or replace view aggJoin7509092027796508519 as select movie_id as v14, keyword_id as v3, v26 from movie_keyword as mk, aggView1987527765673847126 where mk.movie_id=aggView1987527765673847126.v14;
create or replace view aggView4517084218278336295 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4908877452332188025 as select v14, v26 from aggJoin7509092027796508519 join aggView4517084218278336295 using(v3);
create or replace view aggView1380550981679401054 as select v14, MIN(v26) as v26 from aggJoin4908877452332188025 group by v14;
create or replace view aggJoin2579857436711061001 as select title as v15, v26 from title as t, aggView1380550981679401054 where t.id=aggView1380550981679401054.v14 and production_year>2010;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin2579857436711061001;
