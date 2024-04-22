create or replace view aggJoin1360856098189680968 as (
with aggView2765370311793244701 as (select id as v40, title as v53 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v40, keyword_id as v24, v53 from movie_keyword as mk, aggView2765370311793244701 where mk.movie_id=aggView2765370311793244701.v40);
create or replace view aggJoin754977345529551252 as (
with aggView4068009573871750798 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select movie_id as v40, company_id as v13, company_type_id as v20, note as v31 from movie_companies as mc, aggView4068009573871750798 where mc.movie_id=aggView4068009573871750798.v40 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin5348004847805327619 as (
with aggView6501788783016735672 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView6501788783016735672 where mi.info_type_id=aggView6501788783016735672.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin6143455528121873208 as (
with aggView4973690432773156139 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select v40, v20, v31 from aggJoin754977345529551252 join aggView4973690432773156139 using(v13));
create or replace view aggJoin651468484583391168 as (
with aggView6892225124123475022 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin6143455528121873208 join aggView6892225124123475022 using(v20));
create or replace view aggJoin1327830993844952618 as (
with aggView6073413614797931565 as (select v40 from aggJoin651468484583391168 group by v40)
select v40, v35, v36 from aggJoin5348004847805327619 join aggView6073413614797931565 using(v40));
create or replace view aggJoin8575083325107625385 as (
with aggView5124573135853618341 as (select v40, MIN(v35) as v52 from aggJoin1327830993844952618 group by v40)
select v24, v53 as v53, v52 from aggJoin1360856098189680968 join aggView5124573135853618341 using(v40));
create or replace view aggJoin4864408713557912070 as (
with aggView5160001770722494847 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin8575083325107625385 join aggView5160001770722494847 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin4864408713557912070;
