create or replace view aggJoin3831471964507548464 as (
with aggView2737541506649521149 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView2737541506649521149 where mc.company_id=aggView2737541506649521149.v17);
create or replace view aggJoin3918236570732026815 as (
with aggView491930824247331049 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView491930824247331049 where mk.keyword_id=aggView491930824247331049.v22);
create or replace view aggJoin2275340517233162685 as (
with aggView5334431134255555088 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin3831471964507548464 join aggView5334431134255555088 using(v18));
create or replace view aggJoin3289072876221717784 as (
with aggView8157212305369692333 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView8157212305369692333 where ml.link_type_id=aggView8157212305369692333.v13);
create or replace view aggJoin1566504253540391621 as (
with aggView1874225482052079231 as (select v24 from aggJoin3289072876221717784 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView1874225482052079231 where t.id=aggView1874225482052079231.v24 and production_year>1950);
create or replace view aggJoin4804284561154605507 as (
with aggView5247887552769641966 as (select v24, MIN(v28) as v41 from aggJoin1566504253540391621 group by v24)
select v24, v19, v39 as v39, v41 from aggJoin2275340517233162685 join aggView5247887552769641966 using(v24));
create or replace view aggJoin8063714321943558244 as (
with aggView155199590974630195 as (select v24, MIN(v39) as v39, MIN(v41) as v41, MIN(v19) as v40 from aggJoin4804284561154605507 group by v24,v41,v39)
select v39, v41, v40 from aggJoin3918236570732026815 join aggView155199590974630195 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin8063714321943558244;
