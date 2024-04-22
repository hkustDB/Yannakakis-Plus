create or replace view aggView8936904664494821936 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView6857779742832261079 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin7957618706997550019 as (
with aggView6367996608610230250 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView6367996608610230250 where mc.company_id=aggView6367996608610230250.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin1390973610521501364 as (
with aggView8438630073756668228 as (select v18 from aggJoin7957618706997550019 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView8438630073756668228 where t.id=aggView8438630073756668228.v18 and production_year>=2005 and production_year<=2015);
create or replace view aggView1091236895994905258 as select v18, v47 from aggJoin1390973610521501364 group by v18,v47;
create or replace view aggJoin8980874086911140364 as (
with aggView9068600320843389079 as (select v18, MIN(v47) as v60 from aggView1091236895994905258 group by v18)
select person_id as v35, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView9068600320843389079 where ci.movie_id=aggView9068600320843389079.v18 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2171525151117639806 as (
with aggView4171316588874951507 as (select v9, MIN(v10) as v59 from aggView8936904664494821936 group by v9)
select v35, v20, v22, v60 as v60, v59 from aggJoin8980874086911140364 join aggView4171316588874951507 using(v9));
create or replace view aggJoin9096351104114312686 as (
with aggView105591192357713804 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select v35, v20, v22, v60, v59 from aggJoin2171525151117639806 join aggView105591192357713804 using(v35));
create or replace view aggJoin5887716346578790595 as (
with aggView5815095198587211024 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v60, v59 from aggJoin9096351104114312686 join aggView5815095198587211024 using(v22));
create or replace view aggJoin8601772967032148487 as (
with aggView7360179560278617931 as (select v35, MIN(v60) as v60, MIN(v59) as v59 from aggJoin5887716346578790595 group by v35,v59,v60)
select v3, v60, v59 from aggView6857779742832261079 join aggView7360179560278617931 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin8601772967032148487;
