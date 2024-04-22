create or replace view aggView7892222268404055712 as select title as v38, id as v37 from title as t;
create or replace view aggView1856217851293471587 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin8600744530846731070 as (
with aggView3656601523504852839 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView3656601523504852839 where mi_idx.info_type_id=aggView3656601523504852839.v10);
create or replace view aggJoin986701311048347545 as (
with aggView5875477890243884372 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView5875477890243884372 where mk.keyword_id=aggView5875477890243884372.v12);
create or replace view aggJoin347967923665884983 as (
with aggView3902448936469497668 as (select v37 from aggJoin986701311048347545 group by v37)
select v37, v23 from aggJoin8600744530846731070 join aggView3902448936469497668 using(v37));
create or replace view aggView8024655895290804282 as select v23, v37 from aggJoin347967923665884983 group by v23,v37;
create or replace view aggJoin4490334823127077304 as (
with aggView3460378964793546975 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3460378964793546975 where mi.info_type_id=aggView3460378964793546975.v8);
create or replace view aggJoin4645552000674018536 as (
with aggView1980763527012969920 as (select v18, v37 from aggJoin4490334823127077304 group by v18,v37)
select v37, v18 from aggView1980763527012969920 where v18= 'Horror');
create or replace view aggJoin1970966791325560149 as (
with aggView866147440911334784 as (select v37, MIN(v23) as v50 from aggView8024655895290804282 group by v37)
select v37, v18, v50 from aggJoin4645552000674018536 join aggView866147440911334784 using(v37));
create or replace view aggJoin6012675220983196916 as (
with aggView2284205030293885785 as (select v37, MIN(v50) as v50, MIN(v18) as v49 from aggJoin1970966791325560149 group by v37,v50)
select v38, v37, v50, v49 from aggView7892222268404055712 join aggView2284205030293885785 using(v37));
create or replace view aggJoin3246352067111185202 as (
with aggView1495020417689799330 as (select v37, MIN(v50) as v50, MIN(v49) as v49, MIN(v38) as v52 from aggJoin6012675220983196916 group by v37,v49,v50)
select person_id as v28, note as v5, v50, v49, v52 from cast_info as ci, aggView1495020417689799330 where ci.movie_id=aggView1495020417689799330.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8703329287506328061 as (
with aggView8847727734465296002 as (select v28, MIN(v50) as v50, MIN(v49) as v49, MIN(v52) as v52 from aggJoin3246352067111185202 group by v28,v49,v50,v52)
select v29, v50, v49, v52 from aggView1856217851293471587 join aggView8847727734465296002 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin8703329287506328061;
