create or replace view aggView6202690451347048884 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8863835761858318800 as (
with aggView8191548574149651515 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8191548574149651515 where miidx.info_type_id=aggView8191548574149651515.v10);
create or replace view aggJoin7030554798901766469 as (
with aggView240120955131041291 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView240120955131041291 where mi.info_type_id=aggView240120955131041291.v12);
create or replace view aggJoin595083035731848939 as (
with aggView5624833324452642461 as (select v22 from aggJoin7030554798901766469 group by v22)
select v22, v29 from aggJoin8863835761858318800 join aggView5624833324452642461 using(v22));
create or replace view aggView3840284119021797172 as select v22, v29 from aggJoin595083035731848939 group by v22,v29;
create or replace view aggJoin5337813850587609665 as (
with aggView5490008396560037944 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5490008396560037944 where t.kind_id=aggView5490008396560037944.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView2272360184054106466 as select v32, v22 from aggJoin5337813850587609665 group by v32,v22;
create or replace view aggJoin5827737691470229515 as (
with aggView991794280722030049 as (select v22, MIN(v29) as v44 from aggView3840284119021797172 group by v22)
select movie_id as v22, company_id as v1, company_type_id as v8, v44 from movie_companies as mc, aggView991794280722030049 where mc.movie_id=aggView991794280722030049.v22);
create or replace view aggJoin2404588741679588406 as (
with aggView5464873634585503152 as (select v22, MIN(v32) as v45 from aggView2272360184054106466 group by v22)
select v1, v8, v44 as v44, v45 from aggJoin5827737691470229515 join aggView5464873634585503152 using(v22));
create or replace view aggJoin968851457362378809 as (
with aggView386859504208374558 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v44, v45 from aggJoin2404588741679588406 join aggView386859504208374558 using(v8));
create or replace view aggJoin3948853362999526827 as (
with aggView4785060532078892020 as (select v1, MIN(v44) as v44, MIN(v45) as v45 from aggJoin968851457362378809 group by v1,v45,v44)
select v2, v44, v45 from aggView6202690451347048884 join aggView4785060532078892020 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3948853362999526827;
