create or replace view aggView7376146885386876959 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8983040869556073730 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7376146885386876959 where mi_idx.info_type_id=aggView7376146885386876959.v1 and info>'2.0';
create or replace view aggView1594572253949514979 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3622781323181327794 as select movie_id as v14 from movie_keyword as mk, aggView1594572253949514979 where mk.keyword_id=aggView1594572253949514979.v3;
create or replace view aggView884629022176310234 as select v14, MIN(v9) as v26 from aggJoin8983040869556073730 group by v14;
create or replace view aggJoin761044598582565967 as select v14, v26 from aggJoin3622781323181327794 join aggView884629022176310234 using(v14);
create or replace view aggView3292652516177313071 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin2803885619465869426 as select v26, v27 from aggJoin761044598582565967 join aggView3292652516177313071 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2803885619465869426;
