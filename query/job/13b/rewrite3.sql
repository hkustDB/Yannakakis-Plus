create or replace view aggView2540982080304390086 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3460609083992176902 as (
with aggView5102369955300776390 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView5102369955300776390 where mi.info_type_id=aggView5102369955300776390.v12);
create or replace view aggJoin6018902055689118300 as (
with aggView7956776400653995604 as (select v22 from aggJoin3460609083992176902 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView7956776400653995604 where t.id=aggView7956776400653995604.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin3228398507554369814 as (
with aggView2755977445829810347 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2755977445829810347 where miidx.info_type_id=aggView2755977445829810347.v10);
create or replace view aggView1421909327259316435 as select v22, v29 from aggJoin3228398507554369814 group by v22,v29;
create or replace view aggJoin7663335928303298766 as (
with aggView8585078772960177799 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin6018902055689118300 join aggView8585078772960177799 using(v14));
create or replace view aggView1404052559900146573 as select v22, v32 from aggJoin7663335928303298766 group by v22,v32;
create or replace view aggJoin5540746199523055662 as (
with aggView8125921776857660963 as (select v1, MIN(v2) as v43 from aggView2540982080304390086 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView8125921776857660963 where mc.company_id=aggView8125921776857660963.v1);
create or replace view aggJoin76079761251633813 as (
with aggView534468746612237741 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5540746199523055662 join aggView534468746612237741 using(v8));
create or replace view aggJoin18190463055221695 as (
with aggView5102573078400347167 as (select v22, MIN(v43) as v43 from aggJoin76079761251633813 group by v22,v43)
select v22, v29, v43 from aggView1421909327259316435 join aggView5102573078400347167 using(v22));
create or replace view aggJoin2094981437633404148 as (
with aggView5087340613119803021 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin18190463055221695 group by v22,v43)
select v32, v43, v44 from aggView1404052559900146573 join aggView5087340613119803021 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin2094981437633404148;
