create or replace view aggView7305257725020333309 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin5487368230022472888 as (
with aggView7838584158300986731 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView7838584158300986731 where n.id=aggView7838584158300986731.v48 and gender= 'f');
create or replace view aggJoin1498260039580447055 as (
with aggView2512405861840301076 as (select v48, v49 from aggJoin5487368230022472888 group by v48,v49)
select v48, v49 from aggView2512405861840301076 where v49 LIKE '%An%');
create or replace view aggJoin6083291050454027017 as (
with aggView1404791790298568980 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView1404791790298568980 where mi.info_type_id=aggView1404791790298568980.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin8092900369754499342 as (
with aggView3198015231758086363 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView3198015231758086363 where mc.company_id=aggView3198015231758086363.v23);
create or replace view aggJoin6847832053382713761 as (
with aggView3331343275944392567 as (select v59 from aggJoin6083291050454027017 group by v59)
select v59 from aggJoin8092900369754499342 join aggView3331343275944392567 using(v59));
create or replace view aggJoin7160059007584471656 as (
with aggView4419441056731350343 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView4419441056731350343 where mk.keyword_id=aggView4419441056731350343.v32);
create or replace view aggJoin6952926009998083867 as (
with aggView4252963722037266842 as (select v59 from aggJoin7160059007584471656 group by v59)
select v59 from aggJoin6847832053382713761 join aggView4252963722037266842 using(v59));
create or replace view aggJoin778418027426647636 as (
with aggView1055444718754090791 as (select v59 from aggJoin6952926009998083867 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView1055444718754090791 where t.id=aggView1055444718754090791.v59 and production_year>2010);
create or replace view aggView7855821291365965067 as select v59, v60 from aggJoin778418027426647636 group by v59,v60;
create or replace view aggJoin1226340466554843625 as (
with aggView7547515735339523673 as (select v9, MIN(v10) as v71 from aggView7305257725020333309 group by v9)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView7547515735339523673 where ci.person_role_id=aggView7547515735339523673.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5334564970267403299 as (
with aggView7151898526321206714 as (select v59, MIN(v60) as v73 from aggView7855821291365965067 group by v59)
select v48, v20, v57, v71 as v71, v73 from aggJoin1226340466554843625 join aggView7151898526321206714 using(v59));
create or replace view aggJoin1362021940152557904 as (
with aggView2987850409181380383 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v20, v71, v73 from aggJoin5334564970267403299 join aggView2987850409181380383 using(v57));
create or replace view aggJoin7287821284683434738 as (
with aggView5225556664083045750 as (select v48, MIN(v71) as v71, MIN(v73) as v73 from aggJoin1362021940152557904 group by v48,v73,v71)
select v49, v71, v73 from aggJoin1498260039580447055 join aggView5225556664083045750 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin7287821284683434738;
