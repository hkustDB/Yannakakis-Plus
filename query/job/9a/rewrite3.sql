create or replace view aggView5290766242550548758 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView6740499344602801413 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin5094598295473216453 as (
with aggView261582974503797955 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView261582974503797955 where mc.company_id=aggView261582974503797955.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin5115586140602050293 as (
with aggView4479967082241123687 as (select v18 from aggJoin5094598295473216453 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView4479967082241123687 where t.id=aggView4479967082241123687.v18 and production_year>=2005 and production_year<=2015);
create or replace view aggView718418404441740505 as select v18, v47 from aggJoin5115586140602050293 group by v18,v47;
create or replace view aggJoin6053687185687580359 as (
with aggView3703262569356552927 as (select v35, MIN(v3) as v58 from aggView6740499344602801413 group by v35)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58 from cast_info as ci, aggView3703262569356552927 where ci.person_id=aggView3703262569356552927.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3990981687438904133 as (
with aggView8035321124024860505 as (select v9, MIN(v10) as v59 from aggView5290766242550548758 group by v9)
select v35, v18, v20, v22, v58 as v58, v59 from aggJoin6053687185687580359 join aggView8035321124024860505 using(v9));
create or replace view aggJoin5883931855578804394 as (
with aggView418087385151534797 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select v18, v20, v22, v58, v59 from aggJoin3990981687438904133 join aggView418087385151534797 using(v35));
create or replace view aggJoin8030901635776706241 as (
with aggView704228092494523667 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v58, v59 from aggJoin5883931855578804394 join aggView704228092494523667 using(v22));
create or replace view aggJoin561066913719462597 as (
with aggView729088282268962172 as (select v18, MIN(v58) as v58, MIN(v59) as v59 from aggJoin8030901635776706241 group by v18,v59,v58)
select v47, v58, v59 from aggView718418404441740505 join aggView729088282268962172 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v47) as v60 from aggJoin561066913719462597;
