create or replace view aggView942673982874571292 as select id as v24, title as v28 from title as t where production_year>1950;
create or replace view aggView4934844494858810390 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin4770150275819806518 as (
with aggView6209811995015553562 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView6209811995015553562 where mk.keyword_id=aggView6209811995015553562.v22);
create or replace view aggJoin3307034614377409762 as (
with aggView1171281186686003918 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView1171281186686003918 where mc.company_type_id=aggView1171281186686003918.v18);
create or replace view aggJoin8723874155978625117 as (
with aggView8837145303722521155 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView8837145303722521155 where ml.link_type_id=aggView8837145303722521155.v13);
create or replace view aggJoin2254480881606218270 as (
with aggView6781147685243822831 as (select v24 from aggJoin8723874155978625117 group by v24)
select v24 from aggJoin4770150275819806518 join aggView6781147685243822831 using(v24));
create or replace view aggJoin1330266290130017966 as (
with aggView217931593821988606 as (select v24 from aggJoin2254480881606218270 group by v24)
select v24, v17, v19 from aggJoin3307034614377409762 join aggView217931593821988606 using(v24));
create or replace view aggView1774037117207047567 as select v19, v24, v17 from aggJoin1330266290130017966 group by v19,v24,v17;
create or replace view aggJoin2867522108189161637 as (
with aggView8182745497528961036 as (select v24, MIN(v28) as v41 from aggView942673982874571292 group by v24)
select v19, v17, v41 from aggView1774037117207047567 join aggView8182745497528961036 using(v24));
create or replace view aggJoin1190669342323801763 as (
with aggView6100187990679725052 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin2867522108189161637 group by v17,v41)
select v2, v41, v40 from aggView4934844494858810390 join aggView6100187990679725052 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin1190669342323801763;
