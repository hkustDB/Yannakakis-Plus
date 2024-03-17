create or replace view aggView5843347009857846354 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin3414421893940605963 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView5843347009857846354 where mk.movie_id=aggView5843347009857846354.v14;
create or replace view aggView7450809786255626580 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7017444857382107196 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7450809786255626580 where mi_idx.info_type_id=aggView7450809786255626580.v1 and info>'5.0';
create or replace view aggView8936128630104512259 as select v14, MIN(v9) as v26 from aggJoin7017444857382107196 group by v14;
create or replace view aggJoin1802578747696936513 as select v3, v27 as v27, v26 from aggJoin3414421893940605963 join aggView8936128630104512259 using(v14);
create or replace view aggView3146737750714302430 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin1802578747696936513 group by v3;
create or replace view aggJoin2335779832766930098 as select v27, v26 from keyword as k, aggView3146737750714302430 where k.id=aggView3146737750714302430.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2335779832766930098;
