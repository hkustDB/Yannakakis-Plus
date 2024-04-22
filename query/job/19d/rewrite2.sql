create or replace view aggJoin6169597312542139503 as (
with aggView3950246391233107526 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, company_id as v23, v66 from movie_companies as mc, aggView3950246391233107526 where mc.movie_id=aggView3950246391233107526.v53);
create or replace view aggJoin8218259043766885035 as (
with aggView2436043224856675685 as (select id as v42, name as v65 from name as n where gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView2436043224856675685 where an.person_id=aggView2436043224856675685.v42);
create or replace view aggJoin2041389175918838181 as (
with aggView1736507252213329595 as (select v42, MIN(v65) as v65 from aggJoin8218259043766885035 group by v42,v65)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView1736507252213329595 where ci.person_id=aggView1736507252213329595.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5066025926219831215 as (
with aggView8220152337858817267 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin2041389175918838181 join aggView8220152337858817267 using(v51));
create or replace view aggJoin9199882608930155761 as (
with aggView1062884668485233475 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v66 from aggJoin6169597312542139503 join aggView1062884668485233475 using(v23));
create or replace view aggJoin3343147096950180728 as (
with aggView7748335184356500574 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView7748335184356500574 where mi.info_type_id=aggView7748335184356500574.v30);
create or replace view aggJoin5808955088410467173 as (
with aggView1036517862275554001 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin5066025926219831215 join aggView1036517862275554001 using(v9));
create or replace view aggJoin9189568737047351272 as (
with aggView848127477163224354 as (select v53, MIN(v65) as v65 from aggJoin5808955088410467173 group by v53,v65)
select v53, v65 from aggJoin3343147096950180728 join aggView848127477163224354 using(v53));
create or replace view aggJoin5546704325009984490 as (
with aggView8529439512157943701 as (select v53, MIN(v66) as v66 from aggJoin9199882608930155761 group by v53,v66)
select v65 as v65, v66 from aggJoin9189568737047351272 join aggView8529439512157943701 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin5546704325009984490;
