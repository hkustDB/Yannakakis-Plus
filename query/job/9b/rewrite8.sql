create or replace view aggView4707007054735555559 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView4818020145695594056 as select title as v47, id as v18 from title as t where production_year>=2007 and production_year<=2010;
create or replace view aggJoin5345829552299484594 as (
with aggView9200778606372703449 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView9200778606372703449 where v36 LIKE '%Angel%');
create or replace view aggView8393329227716333998 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin1088883405079808382 as (
with aggView3191086693303210333 as (select v18, MIN(v47) as v61 from aggView4818020145695594056 group by v18)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v61 from cast_info as ci, aggView3191086693303210333 where ci.movie_id=aggView3191086693303210333.v18 and note= '(voice)');
create or replace view aggJoin4023668737636898753 as (
with aggView5677099952846933041 as (select v35, MIN(v36) as v60 from aggJoin5345829552299484594 group by v35)
select v3, v35, v60 from aggView8393329227716333998 join aggView5677099952846933041 using(v35));
create or replace view aggJoin9062281550104126925 as (
with aggView2554959503637063565 as (select v9, MIN(v10) as v59 from aggView4707007054735555559 group by v9)
select v35, v18, v20, v22, v61 as v61, v59 from aggJoin1088883405079808382 join aggView2554959503637063565 using(v9));
create or replace view aggJoin9144076178100332864 as (
with aggView8381114560361991121 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v18, v20, v61, v59 from aggJoin9062281550104126925 join aggView8381114560361991121 using(v22));
create or replace view aggJoin1924151275920828222 as (
with aggView6523313404332401206 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView6523313404332401206 where mc.company_id=aggView6523313404332401206.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin4820445255893193100 as (
with aggView8286818745863678316 as (select v18 from aggJoin1924151275920828222 group by v18)
select v35, v20, v61 as v61, v59 as v59 from aggJoin9144076178100332864 join aggView8286818745863678316 using(v18));
create or replace view aggJoin3363917230238285329 as (
with aggView3124180934492178516 as (select v35, MIN(v61) as v61, MIN(v59) as v59 from aggJoin4820445255893193100 group by v35,v59,v61)
select v3, v60 as v60, v61, v59 from aggJoin4023668737636898753 join aggView3124180934492178516 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3363917230238285329;
