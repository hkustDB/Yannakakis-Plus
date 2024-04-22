create or replace view aggJoin6069814581512738717 as (
with aggView6769656243559343251 as (select id as v18, title as v61 from title as t)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v61 from cast_info as ci, aggView6769656243559343251 where ci.movie_id=aggView6769656243559343251.v18 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7842592683819388878 as (
with aggView1807670187792794548 as (select id as v35, name as v60 from name as n where gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView1807670187792794548 where an.person_id=aggView1807670187792794548.v35);
create or replace view aggJoin5037481588423052691 as (
with aggView878488601315284934 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin7842592683819388878 group by v35,v60)
select v18, v9, v20, v22, v61 as v61, v60, v58 from aggJoin6069814581512738717 join aggView878488601315284934 using(v35));
create or replace view aggJoin6301968934576881299 as (
with aggView464405833521607442 as (select id as v9, name as v59 from char_name as chn)
select v18, v20, v22, v61, v60, v58, v59 from aggJoin5037481588423052691 join aggView464405833521607442 using(v9));
create or replace view aggJoin4887663915552681185 as (
with aggView5146812768664838416 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v61, v60, v58, v59 from aggJoin6301968934576881299 join aggView5146812768664838416 using(v22));
create or replace view aggJoin5873528890682987113 as (
with aggView9157489450531332894 as (select v18, MIN(v61) as v61, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin4887663915552681185 group by v18,v60,v59,v58,v61)
select company_id as v32, v61, v60, v58, v59 from movie_companies as mc, aggView9157489450531332894 where mc.movie_id=aggView9157489450531332894.v18);
create or replace view aggJoin3982133136537685624 as (
with aggView6293412572950849330 as (select id as v32 from company_name as cn where country_code= '[us]')
select v61, v60, v58, v59 from aggJoin5873528890682987113 join aggView6293412572950849330 using(v32));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3982133136537685624;
