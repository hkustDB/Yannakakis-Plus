create or replace view aggView2941334409364981722 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7177158878118331814 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView2941334409364981722 where mi_idx.info_type_id=aggView2941334409364981722.v1 and info>'9.0';
create or replace view aggView759884449706206421 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9129941931971620816 as select movie_id as v14 from movie_keyword as mk, aggView759884449706206421 where mk.keyword_id=aggView759884449706206421.v3;
create or replace view aggView7335963339193980035 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin3651324098402237033 as select v14, v27 from aggJoin9129941931971620816 join aggView7335963339193980035 using(v14);
create or replace view aggView4219866066276461723 as select v14, MIN(v9) as v26 from aggJoin7177158878118331814 group by v14;
create or replace view aggJoin2096795034903945014 as select v27 as v27, v26 from aggJoin3651324098402237033 join aggView4219866066276461723 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2096795034903945014;
