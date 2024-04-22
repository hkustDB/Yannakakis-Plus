create or replace view aggJoin6443579481618212425 as (
with aggView7308894288336812901 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView7308894288336812901 where mc.company_id=aggView7308894288336812901.v17);
create or replace view aggJoin5115464132001851509 as (
with aggView4382719332092688552 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView4382719332092688552 where mk.keyword_id=aggView4382719332092688552.v22);
create or replace view aggJoin3634102333905443419 as (
with aggView9035491677903519042 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin6443579481618212425 join aggView9035491677903519042 using(v18));
create or replace view aggJoin2228782165557602839 as (
with aggView8355732971333173623 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin3634102333905443419 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView8355732971333173623 where t.id=aggView8355732971333173623.v24 and production_year>1950);
create or replace view aggJoin672909973761955890 as (
with aggView3125367251527175678 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView3125367251527175678 where ml.link_type_id=aggView3125367251527175678.v13);
create or replace view aggJoin3241546813504270414 as (
with aggView2990809821191554146 as (select v24 from aggJoin672909973761955890 group by v24)
select v24, v28, v31, v39 as v39, v40 as v40 from aggJoin2228782165557602839 join aggView2990809821191554146 using(v24));
create or replace view aggJoin7696569076077227907 as (
with aggView5767472274967813975 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin3241546813504270414 group by v24,v39,v40)
select v39, v40, v41 from aggJoin5115464132001851509 join aggView5767472274967813975 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7696569076077227907;
