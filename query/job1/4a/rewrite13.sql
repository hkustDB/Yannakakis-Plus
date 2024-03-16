create or replace view aggView3724637091868587384 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin3355790378185701143 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3724637091868587384 where mi_idx.movie_id=aggView3724637091868587384.v14 and info>'5.0';
create or replace view aggView7185703906468766123 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2753663381616667118 as select v14, v9, v27 from aggJoin3355790378185701143 join aggView7185703906468766123 using(v1);
create or replace view aggView8529527382085129836 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8099854193580243041 as select movie_id as v14 from movie_keyword as mk, aggView8529527382085129836 where mk.keyword_id=aggView8529527382085129836.v3;
create or replace view aggView5875951651955062593 as select v14 from aggJoin8099854193580243041 group by v14;
create or replace view aggJoin6928781821105148776 as select v9, v27 as v27 from aggJoin2753663381616667118 join aggView5875951651955062593 using(v14);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin6928781821105148776;
