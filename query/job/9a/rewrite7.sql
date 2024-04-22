create or replace view aggView3251635516877529688 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView365951183105234646 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin286772714362049225 as (
with aggView6810264836846164934 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView6810264836846164934 where mc.company_id=aggView6810264836846164934.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin5744853191469672111 as (
with aggView6547571049107278243 as (select v18 from aggJoin286772714362049225 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView6547571049107278243 where t.id=aggView6547571049107278243.v18 and production_year>=2005 and production_year<=2015);
create or replace view aggView4003567676728862128 as select v18, v47 from aggJoin5744853191469672111 group by v18,v47;
create or replace view aggJoin7018312683500093541 as (
with aggView8361200727211787257 as (select v18, MIN(v47) as v60 from aggView4003567676728862128 group by v18)
select person_id as v35, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView8361200727211787257 where ci.movie_id=aggView8361200727211787257.v18 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6600693115062929895 as (
with aggView6776893121569936411 as (select v35, MIN(v3) as v58 from aggView365951183105234646 group by v35)
select v35, v9, v20, v22, v60 as v60, v58 from aggJoin7018312683500093541 join aggView6776893121569936411 using(v35));
create or replace view aggJoin352728823102784479 as (
with aggView2846089101156179493 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select v9, v20, v22, v60, v58 from aggJoin6600693115062929895 join aggView2846089101156179493 using(v35));
create or replace view aggJoin3797389497592660901 as (
with aggView2541350575588265643 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v60, v58 from aggJoin352728823102784479 join aggView2541350575588265643 using(v22));
create or replace view aggJoin6153578519356796277 as (
with aggView5228599302865756429 as (select v9, MIN(v60) as v60, MIN(v58) as v58 from aggJoin3797389497592660901 group by v9,v60,v58)
select v10, v60, v58 from aggView3251635516877529688 join aggView5228599302865756429 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60 from aggJoin6153578519356796277;
