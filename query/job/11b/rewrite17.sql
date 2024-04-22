create or replace view aggJoin7951509621116025618 as (
with aggView7154886200216885910 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView7154886200216885910 where mc.company_id=aggView7154886200216885910.v17);
create or replace view aggJoin1572734669863664558 as (
with aggView301963324711077679 as (select id as v24, title as v41 from title as t where title LIKE '%Money%' and production_year= 1998)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView301963324711077679 where ml.movie_id=aggView301963324711077679.v24);
create or replace view aggJoin204611314423347263 as (
with aggView4095145151331145520 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select v24, v41, v40 from aggJoin1572734669863664558 join aggView4095145151331145520 using(v13));
create or replace view aggJoin1760057688724177419 as (
with aggView1816251959786636013 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin204611314423347263 group by v24,v40,v41)
select movie_id as v24, keyword_id as v22, v41, v40 from movie_keyword as mk, aggView1816251959786636013 where mk.movie_id=aggView1816251959786636013.v24);
create or replace view aggJoin8589193105757973764 as (
with aggView1956991299972654803 as (select id as v22 from keyword as k where keyword= 'sequel')
select v24, v41, v40 from aggJoin1760057688724177419 join aggView1956991299972654803 using(v22));
create or replace view aggJoin8391306588010894018 as (
with aggView8674641542182327501 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin7951509621116025618 join aggView8674641542182327501 using(v18));
create or replace view aggJoin3441512610180140413 as (
with aggView6252618884005805295 as (select v24, MIN(v39) as v39 from aggJoin8391306588010894018 group by v24,v39)
select v41 as v41, v40 as v40, v39 from aggJoin8589193105757973764 join aggView6252618884005805295 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin3441512610180140413;
