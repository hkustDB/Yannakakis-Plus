create or replace view aggView8982237162741793322 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin7499531652381158831 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView8982237162741793322 where mk.movie_id=aggView8982237162741793322.v14;
create or replace view aggView1749624806195357677 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3399880810443430823 as select v14, v27 from aggJoin7499531652381158831 join aggView1749624806195357677 using(v3);
create or replace view aggView957299113614612723 as select v14, MIN(v27) as v27 from aggJoin3399880810443430823 group by v14;
create or replace view aggJoin4624281820461926584 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView957299113614612723 where mi_idx.movie_id=aggView957299113614612723.v14 and info>'9.0';
create or replace view aggView7045207322422037618 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4624281820461926584 group by v1;
create or replace view aggJoin3182147881006296006 as select v27, v26 from info_type as it, aggView7045207322422037618 where it.id=aggView7045207322422037618.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3182147881006296006;
