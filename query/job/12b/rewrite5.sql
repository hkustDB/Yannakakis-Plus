create or replace view aggJoin3041168498566091503 as (
with aggView9055175218503434176 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView9055175218503434176 where mi.info_type_id=aggView9055175218503434176.v21);
create or replace view aggView2186400368142901300 as select v29, v22 from aggJoin3041168498566091503 group by v29,v22;
create or replace view aggJoin4838238659414491474 as (
with aggView1621804813077946799 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView1621804813077946799 where mc.company_id=aggView1621804813077946799.v1);
create or replace view aggJoin6932057605093871319 as (
with aggView3005426856055936631 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin4838238659414491474 join aggView3005426856055936631 using(v8));
create or replace view aggJoin275595632410409721 as (
with aggView1064496530274638835 as (select v29 from aggJoin6932057605093871319 group by v29)
select movie_id as v29, info_type_id as v26 from movie_info_idx as mi_idx, aggView1064496530274638835 where mi_idx.movie_id=aggView1064496530274638835.v29);
create or replace view aggJoin8192605643417832127 as (
with aggView217440287571343455 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29 from aggJoin275595632410409721 join aggView217440287571343455 using(v26));
create or replace view aggJoin4333411719465598065 as (
with aggView2394980306988986065 as (select v29 from aggJoin8192605643417832127 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView2394980306988986065 where t.id=aggView2394980306988986065.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggView5492893848301489763 as select v29, v30 from aggJoin4333411719465598065 group by v29,v30;
create or replace view aggJoin44701945184365001 as (
with aggView5988877600092187137 as (select v29, MIN(v22) as v41 from aggView2186400368142901300 group by v29)
select v30, v41 from aggView5492893848301489763 join aggView5988877600092187137 using(v29));
select MIN(v41) as v41,MIN(v30) as v42 from aggJoin44701945184365001;
