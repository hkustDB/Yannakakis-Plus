create or replace view aggJoin1434848242766212615 as (
with aggView4027729974627334065 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView4027729974627334065 where mk.keyword_id=aggView4027729974627334065.v24);
create or replace view aggJoin23860108927597044 as (
with aggView5574633459210534785 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView5574633459210534785 where mc.company_id=aggView5574633459210534785.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin1358612305549388553 as (
with aggView198719150594657114 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView198719150594657114 where t.id=aggView198719150594657114.v40 and production_year>2000);
create or replace view aggJoin2516362724470362663 as (
with aggView1174608423094952451 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin23860108927597044 join aggView1174608423094952451 using(v20));
create or replace view aggJoin1096228557289810178 as (
with aggView7987538256582784018 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView7987538256582784018 where mi.info_type_id=aggView7987538256582784018.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin3958522588998920964 as (
with aggView3618435670978298972 as (select v40, MIN(v35) as v52 from aggJoin1096228557289810178 group by v40)
select v40, v41, v44, v52 from aggJoin1358612305549388553 join aggView3618435670978298972 using(v40));
create or replace view aggJoin6936938555685511713 as (
with aggView6385988422804841304 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin3958522588998920964 group by v40,v52)
select v40, v31, v52, v53 from aggJoin2516362724470362663 join aggView6385988422804841304 using(v40));
create or replace view aggJoin428357916167405063 as (
with aggView4411673850345780774 as (select v40, MIN(v52) as v52, MIN(v53) as v53 from aggJoin6936938555685511713 group by v40,v53,v52)
select v52, v53 from aggJoin1434848242766212615 join aggView4411673850345780774 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin428357916167405063;
