create or replace view aggView2032694131197188814 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin2575312845429759746 as (
with aggView7792650806971982454 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView7792650806971982454 where mk.keyword_id=aggView7792650806971982454.v22);
create or replace view aggJoin8998280550749661616 as (
with aggView7202105656752363678 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView7202105656752363678 where mc.company_type_id=aggView7202105656752363678.v18);
create or replace view aggView7326350005621899997 as select v19, v24, v17 from aggJoin8998280550749661616 group by v19,v24,v17;
create or replace view aggJoin6124145328925406017 as (
with aggView4719034153630214146 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView4719034153630214146 where ml.link_type_id=aggView4719034153630214146.v13);
create or replace view aggJoin1370543374354634869 as (
with aggView8730823583378907162 as (select v24 from aggJoin6124145328925406017 group by v24)
select v24 from aggJoin2575312845429759746 join aggView8730823583378907162 using(v24));
create or replace view aggJoin2545470229029434980 as (
with aggView5162159810722899369 as (select v24 from aggJoin1370543374354634869 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView5162159810722899369 where t.id=aggView5162159810722899369.v24 and production_year>1950);
create or replace view aggView745164898566539828 as select v28, v24 from aggJoin2545470229029434980 group by v28,v24;
create or replace view aggJoin516441154541772842 as (
with aggView6377369559392664097 as (select v17, MIN(v2) as v39 from aggView2032694131197188814 group by v17)
select v19, v24, v39 from aggView7326350005621899997 join aggView6377369559392664097 using(v17));
create or replace view aggJoin2024428951742727632 as (
with aggView6924899464770288618 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin516441154541772842 group by v24,v39)
select v28, v39, v40 from aggView745164898566539828 join aggView6924899464770288618 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin2024428951742727632;
