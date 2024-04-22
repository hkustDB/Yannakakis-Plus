create or replace view aggView2715850083826179510 as select id as v40, title as v41 from title as t where production_year>1990;
create or replace view aggJoin876011902880963543 as (
with aggView7806010402618423627 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7806010402618423627 where mc.company_id=aggView7806010402618423627.v13);
create or replace view aggJoin1009214298549401188 as (
with aggView1300133710649645119 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView1300133710649645119 where mi.info_type_id=aggView1300133710649645119.v22 and note LIKE '%internet%');
create or replace view aggJoin1787667580352834701 as (
with aggView6742112739170774666 as (select v40 from aggJoin1009214298549401188 group by v40)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView6742112739170774666 where mk.movie_id=aggView6742112739170774666.v40);
create or replace view aggJoin7587102754139814599 as (
with aggView6434063545999136417 as (select id as v20 from company_type as ct)
select v40 from aggJoin876011902880963543 join aggView6434063545999136417 using(v20));
create or replace view aggJoin6635429414462753677 as (
with aggView2621855376946888720 as (select v40 from aggJoin7587102754139814599 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView2621855376946888720 where aka_t.movie_id=aggView2621855376946888720.v40);
create or replace view aggJoin5148046835428806794 as (
with aggView8948731498058754372 as (select id as v24 from keyword as k)
select v40 from aggJoin1787667580352834701 join aggView8948731498058754372 using(v24));
create or replace view aggJoin8174102011316770627 as (
with aggView5203083535397102921 as (select v40 from aggJoin5148046835428806794 group by v40)
select v40, v3 from aggJoin6635429414462753677 join aggView5203083535397102921 using(v40));
create or replace view aggView5651855939959118057 as select v40, v3 from aggJoin8174102011316770627 group by v40,v3;
create or replace view aggJoin4034931408221978559 as (
with aggView1355601621769147609 as (select v40, MIN(v41) as v53 from aggView2715850083826179510 group by v40)
select v3, v53 from aggView5651855939959118057 join aggView1355601621769147609 using(v40));
select MIN(v3) as v52,MIN(v53) as v53 from aggJoin4034931408221978559;
