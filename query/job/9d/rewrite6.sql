create or replace view aggJoin48345033441929238 as (
with aggView311642515910553708 as (select id as v35, name as v60 from name as n where gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView311642515910553708 where an.person_id=aggView311642515910553708.v35);
create or replace view aggJoin3809488351764330025 as (
with aggView8613957097484647689 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin48345033441929238 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView8613957097484647689 where ci.person_id=aggView8613957097484647689.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin9111954547814782286 as (
with aggView9113351787709348096 as (select id as v9, name as v59 from char_name as chn)
select v18, v20, v22, v60, v58, v59 from aggJoin3809488351764330025 join aggView9113351787709348096 using(v9));
create or replace view aggJoin2985413942060299649 as (
with aggView2021286761730546275 as (select id as v18, title as v61 from title as t)
select movie_id as v18, company_id as v32, v61 from movie_companies as mc, aggView2021286761730546275 where mc.movie_id=aggView2021286761730546275.v18);
create or replace view aggJoin506191363719527479 as (
with aggView8078996461485086146 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v60, v58, v59 from aggJoin9111954547814782286 join aggView8078996461485086146 using(v22));
create or replace view aggJoin3753020855857322437 as (
with aggView1104177089395299866 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin506191363719527479 group by v18,v60,v59,v58)
select v32, v61 as v61, v60, v58, v59 from aggJoin2985413942060299649 join aggView1104177089395299866 using(v18));
create or replace view aggJoin1759970708637186374 as (
with aggView5450346426688806771 as (select id as v32 from company_name as cn where country_code= '[us]')
select v61, v60, v58, v59 from aggJoin3753020855857322437 join aggView5450346426688806771 using(v32));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1759970708637186374;
