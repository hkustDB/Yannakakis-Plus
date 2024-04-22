create or replace view aggJoin2185750814986749862 as (
with aggView1461721411223283676 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView1461721411223283676 where mi.info_type_id=aggView1461721411223283676.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin866451874543445115 as (
with aggView966901644275047774 as (select v15 from aggJoin2185750814986749862 group by v15)
select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView966901644275047774 where mc.movie_id=aggView966901644275047774.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%');
create or replace view aggJoin3537393738275968972 as (
with aggView3436094096881212518 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9 from aggJoin866451874543445115 join aggView3436094096881212518 using(v1));
create or replace view aggJoin5019899832950874352 as (
with aggView7428995999558119902 as (select v15 from aggJoin3537393738275968972 group by v15)
select title as v16 from title as t, aggView7428995999558119902 where t.id=aggView7428995999558119902.v15 and production_year>1990);
select MIN(v16) as v27 from aggJoin5019899832950874352;
