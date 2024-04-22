create or replace view aggView2557464813294993100 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin8233716451009377161 as (
with aggView6587236244999954217 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView6587236244999954217 where mc.company_id=aggView6587236244999954217.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin98017900478889929 as (
with aggView500016292865734603 as (select v18 from aggJoin8233716451009377161 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView500016292865734603 where t.id=aggView500016292865734603.v18 and production_year>=2005 and production_year<=2015);
create or replace view aggView7568265009118576988 as select v18, v47 from aggJoin98017900478889929 group by v18,v47;
create or replace view aggJoin6158876038232793317 as (
with aggView7476364724195622250 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select person_id as v35, name as v3 from aka_name as an, aggView7476364724195622250 where an.person_id=aggView7476364724195622250.v35);
create or replace view aggView1963005607757782019 as select v3, v35 from aggJoin6158876038232793317 group by v3,v35;
create or replace view aggJoin8574186525088803170 as (
with aggView4603134152833799608 as (select v9, MIN(v10) as v59 from aggView2557464813294993100 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView4603134152833799608 where ci.person_role_id=aggView4603134152833799608.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5048675085037498870 as (
with aggView1381776805342607132 as (select v18, MIN(v47) as v60 from aggView7568265009118576988 group by v18)
select v35, v20, v22, v59 as v59, v60 from aggJoin8574186525088803170 join aggView1381776805342607132 using(v18));
create or replace view aggJoin3248437941647313548 as (
with aggView2391431596856114609 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v60 from aggJoin5048675085037498870 join aggView2391431596856114609 using(v22));
create or replace view aggJoin2684757822580684059 as (
with aggView73555728025099194 as (select v35, MIN(v59) as v59, MIN(v60) as v60 from aggJoin3248437941647313548 group by v35,v59,v60)
select v3, v59, v60 from aggView1963005607757782019 join aggView73555728025099194 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2684757822580684059;
