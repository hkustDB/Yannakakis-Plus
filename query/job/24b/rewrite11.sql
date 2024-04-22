create or replace view aggJoin2765796722847432225 as (
with aggView2327144078346519944 as (select id as v59, title as v73 from title as t where title LIKE 'Kung Fu Panda%' and production_year>2010)
select movie_id as v59, keyword_id as v32, v73 from movie_keyword as mk, aggView2327144078346519944 where mk.movie_id=aggView2327144078346519944.v59);
create or replace view aggJoin8767013886263009974 as (
with aggView5469544301039845340 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView5469544301039845340 where ci.person_role_id=aggView5469544301039845340.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2569266449589591046 as (
with aggView2823248975483801608 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71 from aggJoin8767013886263009974 join aggView2823248975483801608 using(v57));
create or replace view aggJoin7025223392039330812 as (
with aggView7741766956120155238 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView7741766956120155238 where mi.info_type_id=aggView7741766956120155238.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin1579829267074894388 as (
with aggView4611865252926480593 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select v59, v73 from aggJoin2765796722847432225 join aggView4611865252926480593 using(v32));
create or replace view aggJoin4251960781489031781 as (
with aggView7191276985556734872 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView7191276985556734872 where n.id=aggView7191276985556734872.v48 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin4045176737349833015 as (
with aggView1641877791501622895 as (select v48, MIN(v49) as v72 from aggJoin4251960781489031781 group by v48)
select v59, v20, v71 as v71, v72 from aggJoin2569266449589591046 join aggView1641877791501622895 using(v48));
create or replace view aggJoin2899990498035642186 as (
with aggView8418406729332503016 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView8418406729332503016 where mc.company_id=aggView8418406729332503016.v23);
create or replace view aggJoin396605170779209222 as (
with aggView168547956702488972 as (select v59 from aggJoin2899990498035642186 group by v59)
select v59, v43 from aggJoin7025223392039330812 join aggView168547956702488972 using(v59));
create or replace view aggJoin7292552587846980208 as (
with aggView3146081731815509231 as (select v59 from aggJoin396605170779209222 group by v59)
select v59, v20, v71 as v71, v72 as v72 from aggJoin4045176737349833015 join aggView3146081731815509231 using(v59));
create or replace view aggJoin6500837394368988019 as (
with aggView9154490220455438500 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin7292552587846980208 group by v59,v72,v71)
select v73 as v73, v71, v72 from aggJoin1579829267074894388 join aggView9154490220455438500 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin6500837394368988019;
