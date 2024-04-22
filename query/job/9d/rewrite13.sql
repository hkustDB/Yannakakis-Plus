create or replace view aggView630092654511055503 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView2402284259909218677 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView4032609702950019858 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggJoin7019322060696809455 as (
with aggView280784371518264858 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView280784371518264858 where mc.company_id=aggView280784371518264858.v32);
create or replace view aggJoin8699615532623101214 as (
with aggView5639298734840755867 as (select v18 from aggJoin7019322060696809455 group by v18)
select id as v18, title as v47 from title as t, aggView5639298734840755867 where t.id=aggView5639298734840755867.v18);
create or replace view aggView1183118270543675595 as select v18, v47 from aggJoin8699615532623101214 group by v18,v47;
create or replace view aggJoin269626130480794676 as (
with aggView1386100786115325212 as (select v9, MIN(v10) as v59 from aggView2402284259909218677 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView1386100786115325212 where ci.person_role_id=aggView1386100786115325212.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1969710818267097129 as (
with aggView7167347042401733070 as (select v35, MIN(v3) as v58 from aggView630092654511055503 group by v35)
select v35, v18, v20, v22, v59 as v59, v58 from aggJoin269626130480794676 join aggView7167347042401733070 using(v35));
create or replace view aggJoin52307346749189799 as (
with aggView5355349179238250434 as (select v18, MIN(v47) as v61 from aggView1183118270543675595 group by v18)
select v35, v20, v22, v59 as v59, v58 as v58, v61 from aggJoin1969710818267097129 join aggView5355349179238250434 using(v18));
create or replace view aggJoin5469231525197090960 as (
with aggView7869580994543120216 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v58, v61 from aggJoin52307346749189799 join aggView7869580994543120216 using(v22));
create or replace view aggJoin4614213061395998160 as (
with aggView59934519323414532 as (select v35, MIN(v59) as v59, MIN(v58) as v58, MIN(v61) as v61 from aggJoin5469231525197090960 group by v35,v59,v58,v61)
select v36, v59, v58, v61 from aggView4032609702950019858 join aggView59934519323414532 using(v35));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v36) as v60,MIN(v61) as v61 from aggJoin4614213061395998160;
