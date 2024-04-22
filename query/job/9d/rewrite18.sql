create or replace view aggJoin1015770486102990141 as (
with aggView5324069961853619015 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58 from cast_info as ci, aggView5324069961853619015 where ci.person_id=aggView5324069961853619015.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6279895269592543291 as (
with aggView5210466190695286504 as (select id as v9, name as v59 from char_name as chn)
select v35, v18, v20, v22, v58, v59 from aggJoin1015770486102990141 join aggView5210466190695286504 using(v9));
create or replace view aggJoin3232776511836451055 as (
with aggView7918402656441581098 as (select id as v35, name as v60 from name as n where gender= 'f')
select v18, v20, v22, v58, v59, v60 from aggJoin6279895269592543291 join aggView7918402656441581098 using(v35));
create or replace view aggJoin5758462198107261548 as (
with aggView9005424560670620124 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v58, v59, v60 from aggJoin3232776511836451055 join aggView9005424560670620124 using(v22));
create or replace view aggJoin2054673329239569605 as (
with aggView9106129998275674564 as (select v18, MIN(v58) as v58, MIN(v59) as v59, MIN(v60) as v60 from aggJoin5758462198107261548 group by v18,v60,v59,v58)
select id as v18, title as v47, v58, v59, v60 from title as t, aggView9106129998275674564 where t.id=aggView9106129998275674564.v18);
create or replace view aggJoin4637704159228210220 as (
with aggView518753711021566652 as (select v18, MIN(v58) as v58, MIN(v59) as v59, MIN(v60) as v60, MIN(v47) as v61 from aggJoin2054673329239569605 group by v18,v60,v59,v58)
select company_id as v32, v58, v59, v60, v61 from movie_companies as mc, aggView518753711021566652 where mc.movie_id=aggView518753711021566652.v18);
create or replace view aggJoin2437487919090546028 as (
with aggView6098597621995288018 as (select id as v32 from company_name as cn where country_code= '[us]')
select v58, v59, v60, v61 from aggJoin4637704159228210220 join aggView6098597621995288018 using(v32));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin2437487919090546028;
