create or replace view aggView6236355128788835663 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5790887694572098448 as select movie_id as v14 from movie_keyword as mk, aggView6236355128788835663 where mk.keyword_id=aggView6236355128788835663.v3;
create or replace view aggView6268771588927377873 as select v14 from aggJoin5790887694572098448 group by v14;
create or replace view aggJoin412166446413417697 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx as mi_idx, aggView6268771588927377873 where mi_idx.movie_id=aggView6268771588927377873.v14 and info>'2.0';
create or replace view aggView2468771976191209420 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2141400472479600930 as select v14, v9 from aggJoin412166446413417697 join aggView2468771976191209420 using(v1);
create or replace view aggView8643492073580115555 as select v14, MIN(v9) as v26 from aggJoin2141400472479600930 group by v14;
create or replace view aggJoin513745351150140507 as select title as v15, v26 from title as t, aggView8643492073580115555 where t.id=aggView8643492073580115555.v14 and production_year>1990;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin513745351150140507;
