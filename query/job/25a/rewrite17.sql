create or replace view aggJoin6655072168508225569 as (
with aggView5200785515421419533 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView5200785515421419533 where ci.person_id=aggView5200785515421419533.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5760806278513244405 as (
with aggView5781212596350546611 as (select id as v37, title as v52 from title as t)
select movie_id as v37, info_type_id as v10, info as v23, v52 from movie_info_idx as mi_idx, aggView5781212596350546611 where mi_idx.movie_id=aggView5781212596350546611.v37);
create or replace view aggJoin2910097577615588263 as (
with aggView7834713061383885515 as (select v37, MIN(v51) as v51 from aggJoin6655072168508225569 group by v37,v51)
select movie_id as v37, keyword_id as v12, v51 from movie_keyword as mk, aggView7834713061383885515 where mk.movie_id=aggView7834713061383885515.v37);
create or replace view aggJoin4631394217555165372 as (
with aggView4893666086551669199 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v52 from aggJoin5760806278513244405 join aggView4893666086551669199 using(v10));
create or replace view aggJoin3807116428699472497 as (
with aggView2060930301195686218 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v51 from aggJoin2910097577615588263 join aggView2060930301195686218 using(v12));
create or replace view aggJoin8999253144593080568 as (
with aggView6070338622203685911 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView6070338622203685911 where mi.info_type_id=aggView6070338622203685911.v8 and info= 'Horror');
create or replace view aggJoin7817062177034794999 as (
with aggView8421848311859623556 as (select v37, MIN(v18) as v49 from aggJoin8999253144593080568 group by v37)
select v37, v23, v52 as v52, v49 from aggJoin4631394217555165372 join aggView8421848311859623556 using(v37));
create or replace view aggJoin879300439508395656 as (
with aggView8312642182354912663 as (select v37, MIN(v52) as v52, MIN(v49) as v49, MIN(v23) as v50 from aggJoin7817062177034794999 group by v37,v49,v52)
select v51 as v51, v52, v49, v50 from aggJoin3807116428699472497 join aggView8312642182354912663 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin879300439508395656;
