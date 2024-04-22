create or replace view aggView9037091552622349112 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView4547395557675955119 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView1947951222092339420 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin1920084922155704062 as (
with aggView7345132171296731515 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView7345132171296731515 where mc.company_id=aggView7345132171296731515.v32);
create or replace view aggJoin8940834153883424423 as (
with aggView3349250754615524316 as (select v18 from aggJoin1920084922155704062 group by v18)
select id as v18, title as v47 from title as t, aggView3349250754615524316 where t.id=aggView3349250754615524316.v18);
create or replace view aggView5184106050656055674 as select v18, v47 from aggJoin8940834153883424423 group by v18,v47;
create or replace view aggJoin4103722847019329860 as (
with aggView1271414276485636996 as (select v35, MIN(v36) as v60 from aggView9037091552622349112 group by v35)
select v35, v3, v60 from aggView4547395557675955119 join aggView1271414276485636996 using(v35));
create or replace view aggJoin7941026110885435043 as (
with aggView4046896344528922043 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin4103722847019329860 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView4046896344528922043 where ci.person_id=aggView4046896344528922043.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4368850819121292623 as (
with aggView5052426668002292421 as (select v18, MIN(v47) as v61 from aggView5184106050656055674 group by v18)
select v9, v20, v22, v60 as v60, v58 as v58, v61 from aggJoin7941026110885435043 join aggView5052426668002292421 using(v18));
create or replace view aggJoin3764569714699721576 as (
with aggView2907393915504713508 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v60, v58, v61 from aggJoin4368850819121292623 join aggView2907393915504713508 using(v22));
create or replace view aggJoin2941294570609678780 as (
with aggView1972205586856424685 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin3764569714699721576 group by v9,v61,v60,v58)
select v10, v60, v58, v61 from aggView1947951222092339420 join aggView1972205586856424685 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin2941294570609678780;
