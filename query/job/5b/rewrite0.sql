create or replace view aggJoin1596392154068978982 as (
with aggView5330972379299945668 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView5330972379299945668 where mc.company_type_id=aggView5330972379299945668.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%');
create or replace view aggJoin6868508690842909349 as (
with aggView7296961674692286849 as (select v15 from aggJoin1596392154068978982 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView7296961674692286849 where t.id=aggView7296961674692286849.v15 and production_year>2010);
create or replace view aggJoin8594862707182697703 as (
with aggView3802712531116264079 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView3802712531116264079 where mi.info_type_id=aggView3802712531116264079.v3 and info IN ('USA','America'));
create or replace view aggJoin2719604866647522905 as (
with aggView7503640814039870779 as (select v15 from aggJoin8594862707182697703 group by v15)
select v16, v19 from aggJoin6868508690842909349 join aggView7503640814039870779 using(v15));
create or replace view aggView5106101838730019895 as select v16 from aggJoin2719604866647522905 group by v16;
select MIN(v16) as v27 from aggView5106101838730019895;
