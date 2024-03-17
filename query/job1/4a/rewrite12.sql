create or replace view aggView6621197815343601092 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4714135700925173497 as select movie_id as v14 from movie_keyword as mk, aggView6621197815343601092 where mk.keyword_id=aggView6621197815343601092.v3;
create or replace view aggView6789400926465678986 as select v14 from aggJoin4714135700925173497 group by v14;
create or replace view aggJoin7002509053562259430 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx as mi_idx, aggView6789400926465678986 where mi_idx.movie_id=aggView6789400926465678986.v14 and info>'5.0';
create or replace view aggView6640862247126182246 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1568741090157395810 as select v14, v9 from aggJoin7002509053562259430 join aggView6640862247126182246 using(v1);
create or replace view aggView8842190077086168745 as select v14, MIN(v9) as v26 from aggJoin1568741090157395810 group by v14;
create or replace view aggJoin2063559004888691525 as select title as v15, v26 from title as t, aggView8842190077086168745 where t.id=aggView8842190077086168745.v14 and production_year>2005;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin2063559004888691525;
