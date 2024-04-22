create or replace view aggJoin7832629690888866823 as (
with aggView889502371434075366 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView889502371434075366 where mc.company_id=aggView889502371434075366.v17);
create or replace view aggJoin3493018157563281625 as (
with aggView3547419899760981268 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView3547419899760981268 where ml.movie_id=aggView3547419899760981268.v24);
create or replace view aggJoin8247194706312394631 as (
with aggView9055011348686912807 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView9055011348686912807 where mk.keyword_id=aggView9055011348686912807.v22);
create or replace view aggJoin4156708884433668272 as (
with aggView1269104814009777515 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin7832629690888866823 join aggView1269104814009777515 using(v18));
create or replace view aggJoin2726424954143577001 as (
with aggView5631088069845882813 as (select id as v13 from link_type as lt)
select v24, v41 from aggJoin3493018157563281625 join aggView5631088069845882813 using(v13));
create or replace view aggJoin3277664957238377833 as (
with aggView3838024676472820918 as (select v24, MIN(v41) as v41 from aggJoin2726424954143577001 group by v24,v41)
select v24, v19, v39 as v39, v41 from aggJoin4156708884433668272 join aggView3838024676472820918 using(v24));
create or replace view aggJoin6835653370989385667 as (
with aggView1479249378505731813 as (select v24, MIN(v39) as v39, MIN(v41) as v41, MIN(v19) as v40 from aggJoin3277664957238377833 group by v24,v41,v39)
select v39, v41, v40 from aggJoin8247194706312394631 join aggView1479249378505731813 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin6835653370989385667;
