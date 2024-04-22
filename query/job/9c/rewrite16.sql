create or replace view aggJoin2071774075399957162 as (
with aggView1423893657097348118 as (select id as v35, name as v60 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView1423893657097348118 where ci.person_id=aggView1423893657097348118.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6539498672781382534 as (
with aggView6059955348962540916 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select v18, v9, v20, v22, v60 as v60, v58 from aggJoin2071774075399957162 join aggView6059955348962540916 using(v35));
create or replace view aggJoin4187517589247864525 as (
with aggView1177663305602478799 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v60, v58 from aggJoin6539498672781382534 join aggView1177663305602478799 using(v22));
create or replace view aggJoin6700675398937543087 as (
with aggView9092833470861445672 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView9092833470861445672 where mc.company_id=aggView9092833470861445672.v32);
create or replace view aggJoin6050990010772498671 as (
with aggView506961035803919673 as (select v18 from aggJoin6700675398937543087 group by v18)
select id as v18, title as v47 from title as t, aggView506961035803919673 where t.id=aggView506961035803919673.v18);
create or replace view aggJoin3438361740147014678 as (
with aggView7411061785876212550 as (select v18, MIN(v47) as v61 from aggJoin6050990010772498671 group by v18)
select v9, v20, v60 as v60, v58 as v58, v61 from aggJoin4187517589247864525 join aggView7411061785876212550 using(v18));
create or replace view aggJoin1979366183888738462 as (
with aggView9111593556523584049 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin3438361740147014678 group by v9,v61,v60,v58)
select name as v10, v60, v58, v61 from char_name as chn, aggView9111593556523584049 where chn.id=aggView9111593556523584049.v9);
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1979366183888738462;
