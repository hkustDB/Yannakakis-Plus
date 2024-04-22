create or replace view aggJoin3751999329913039178 as (
with aggView2777060744283577338 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView2777060744283577338 where mk.keyword_id=aggView2777060744283577338.v18);
create or replace view aggJoin8781951745424678640 as (
with aggView5240996884097709422 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5240996884097709422 where mc.company_type_id=aggView5240996884097709422.v14);
create or replace view aggJoin8804901044974703078 as (
with aggView1958934691767935359 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView1958934691767935359 where mi.info_type_id=aggView1958934691767935359.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin3679892958202184794 as (
with aggView2671580906259252109 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2671580906259252109 where cc.status_id=aggView2671580906259252109.v5);
create or replace view aggJoin6232003062606642033 as (
with aggView5718595560539948726 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin8781951745424678640 join aggView5718595560539948726 using(v7));
create or replace view aggJoin650100795589147399 as (
with aggView6045592174411538803 as (select v36 from aggJoin6232003062606642033 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView6045592174411538803 where t.id=aggView6045592174411538803.v36 and production_year>2000);
create or replace view aggJoin4247602641586355307 as (
with aggView9171842922109301035 as (select v36 from aggJoin3751999329913039178 group by v36)
select v36, v37, v21, v40 from aggJoin650100795589147399 join aggView9171842922109301035 using(v36));
create or replace view aggJoin6561827897446835196 as (
with aggView4469460421831547009 as (select v36 from aggJoin3679892958202184794 group by v36)
select v36, v31, v32 from aggJoin8804901044974703078 join aggView4469460421831547009 using(v36));
create or replace view aggJoin5747807326044078073 as (
with aggView8992953472943376771 as (select v36 from aggJoin6561827897446835196 group by v36)
select v37, v21, v40 from aggJoin4247602641586355307 join aggView8992953472943376771 using(v36));
create or replace view aggView4822198844942169970 as select v37, v21 from aggJoin5747807326044078073 group by v37,v21;
create or replace view aggJoin3229844521261146835 as (
with aggView7895674487259142895 as (select v21, MIN(v37) as v49 from aggView4822198844942169970 group by v21)
select kind as v22, v49 from kind_type as kt, aggView7895674487259142895 where kt.id=aggView7895674487259142895.v21 and kind= 'movie');
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin3229844521261146835;
