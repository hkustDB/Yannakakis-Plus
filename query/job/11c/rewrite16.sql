create or replace view aggJoin3231488411063267174 as (
with aggView7017462919156165982 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, company_id as v17, company_type_id as v18, note as v19, v41 from movie_companies as mc, aggView7017462919156165982 where mc.movie_id=aggView7017462919156165982.v24);
create or replace view aggJoin2192382711800753922 as (
with aggView3257045446024356031 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select v24, v18, v19, v41, v39 from aggJoin3231488411063267174 join aggView3257045446024356031 using(v17));
create or replace view aggJoin6889317034193955158 as (
with aggView1816636672568065971 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView1816636672568065971 where mk.keyword_id=aggView1816636672568065971.v22);
create or replace view aggJoin8058810079314068950 as (
with aggView553263679631119353 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v41, v39 from aggJoin2192382711800753922 join aggView553263679631119353 using(v18));
create or replace view aggJoin3340769618360796958 as (
with aggView833385086183175066 as (select v24, MIN(v41) as v41, MIN(v39) as v39, MIN(v19) as v40 from aggJoin8058810079314068950 group by v24,v39,v41)
select v24, v41, v39, v40 from aggJoin6889317034193955158 join aggView833385086183175066 using(v24));
create or replace view aggJoin7348610059206711792 as (
with aggView1661811225235874196 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView1661811225235874196 where ml.link_type_id=aggView1661811225235874196.v13);
create or replace view aggJoin2642750267214575793 as (
with aggView2709335734379583148 as (select v24 from aggJoin7348610059206711792 group by v24)
select v41 as v41, v39 as v39, v40 as v40 from aggJoin3340769618360796958 join aggView2709335734379583148 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin2642750267214575793;
