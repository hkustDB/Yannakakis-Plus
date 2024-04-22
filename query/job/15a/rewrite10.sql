create or replace view aggJoin8516397473614846880 as (
with aggView7076265673982579519 as (select id as v40, title as v53 from title as t where production_year>2000)
select movie_id as v40, info_type_id as v22, info as v35, note as v36, v53 from movie_info as mi, aggView7076265673982579519 where mi.movie_id=aggView7076265673982579519.v40 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin51251382862335763 as (
with aggView6394007144443237315 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView6394007144443237315 where mk.keyword_id=aggView6394007144443237315.v24);
create or replace view aggJoin4820101994073973339 as (
with aggView240193015136703603 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView240193015136703603 where mc.company_id=aggView240193015136703603.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin4188695945872509361 as (
with aggView5722488278031390382 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin51251382862335763 join aggView5722488278031390382 using(v40));
create or replace view aggJoin6060026632015398454 as (
with aggView334552787119786261 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin4820101994073973339 join aggView334552787119786261 using(v20));
create or replace view aggJoin1477675579993715726 as (
with aggView1554436975846698592 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36, v53 from aggJoin8516397473614846880 join aggView1554436975846698592 using(v22));
create or replace view aggJoin2471664860747296325 as (
with aggView4366466160370019409 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin1477675579993715726 group by v40,v53)
select v40, v31, v53, v52 from aggJoin6060026632015398454 join aggView4366466160370019409 using(v40));
create or replace view aggJoin3587570969546924010 as (
with aggView1846589166876261965 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin2471664860747296325 group by v40,v53,v52)
select v53, v52 from aggJoin4188695945872509361 join aggView1846589166876261965 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin3587570969546924010;
