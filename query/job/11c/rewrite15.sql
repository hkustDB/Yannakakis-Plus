create or replace view aggJoin6040866481634298191 as (
with aggView3689595861326986380 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView3689595861326986380 where mc.company_id=aggView3689595861326986380.v17);
create or replace view aggJoin1928000360936745082 as (
with aggView5507393262765161817 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView5507393262765161817 where mk.keyword_id=aggView5507393262765161817.v22);
create or replace view aggJoin3460890725810658362 as (
with aggView8671137285837579278 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin6040866481634298191 join aggView8671137285837579278 using(v18));
create or replace view aggJoin7287216783019235576 as (
with aggView2405537669294794672 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin3460890725810658362 group by v24,v39)
select v24, v39, v40 from aggJoin1928000360936745082 join aggView2405537669294794672 using(v24));
create or replace view aggJoin9102341619509700179 as (
with aggView8968861190486951674 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView8968861190486951674 where ml.link_type_id=aggView8968861190486951674.v13);
create or replace view aggJoin3959814146144576455 as (
with aggView8456774745758995847 as (select v24 from aggJoin9102341619509700179 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView8456774745758995847 where t.id=aggView8456774745758995847.v24 and production_year>1950);
create or replace view aggJoin687817367305068951 as (
with aggView4005760326249770655 as (select v24, MIN(v28) as v41 from aggJoin3959814146144576455 group by v24)
select v39 as v39, v40 as v40, v41 from aggJoin7287216783019235576 join aggView4005760326249770655 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin687817367305068951;
