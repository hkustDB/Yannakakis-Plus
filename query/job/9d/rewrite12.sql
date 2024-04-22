create or replace view aggView5984264005042956017 as select id as v18, title as v47 from title as t;
create or replace view aggView8410885344126167789 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView6756177639899448602 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggView4538914667959380956 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin4537466136857244973 as (
with aggView870724770014999363 as (select v35, MIN(v36) as v60 from aggView6756177639899448602 group by v35)
select v35, v3, v60 from aggView4538914667959380956 join aggView870724770014999363 using(v35));
create or replace view aggJoin3419852590839719138 as (
with aggView859288034569552220 as (select v9, MIN(v10) as v59 from aggView8410885344126167789 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView859288034569552220 where ci.person_role_id=aggView859288034569552220.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7687693821850223725 as (
with aggView6338297868370310530 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin4537466136857244973 group by v35,v60)
select v18, v20, v22, v59 as v59, v60, v58 from aggJoin3419852590839719138 join aggView6338297868370310530 using(v35));
create or replace view aggJoin300971517926381804 as (
with aggView3765308967762921298 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v60, v58 from aggJoin7687693821850223725 join aggView3765308967762921298 using(v22));
create or replace view aggJoin3034167613550401200 as (
with aggView7988141944598232554 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView7988141944598232554 where mc.company_id=aggView7988141944598232554.v32);
create or replace view aggJoin1370809758652688903 as (
with aggView4025280960611750848 as (select v18 from aggJoin3034167613550401200 group by v18)
select v18, v20, v59 as v59, v60 as v60, v58 as v58 from aggJoin300971517926381804 join aggView4025280960611750848 using(v18));
create or replace view aggJoin5756194294467215130 as (
with aggView4358609357103024243 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin1370809758652688903 group by v18,v60,v59,v58)
select v47, v59, v60, v58 from aggView5984264005042956017 join aggView4358609357103024243 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin5756194294467215130;
