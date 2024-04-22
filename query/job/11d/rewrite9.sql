create or replace view aggJoin9164046514904289653 as (
with aggView6507957176773281377 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView6507957176773281377 where mc.company_id=aggView6507957176773281377.v17);
create or replace view aggJoin9041523431973804379 as (
with aggView21930043720786812 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView21930043720786812 where mk.keyword_id=aggView21930043720786812.v22);
create or replace view aggJoin1638211113886373056 as (
with aggView1684167127514072225 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin9164046514904289653 join aggView1684167127514072225 using(v18));
create or replace view aggJoin8873039835142112053 as (
with aggView4432203934124335564 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin1638211113886373056 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView4432203934124335564 where t.id=aggView4432203934124335564.v24 and production_year>1950);
create or replace view aggJoin2395294018270589442 as (
with aggView2645375526703535326 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin8873039835142112053 group by v24,v39,v40)
select movie_id as v24, link_type_id as v13, v39, v40, v41 from movie_link as ml, aggView2645375526703535326 where ml.movie_id=aggView2645375526703535326.v24);
create or replace view aggJoin6194506725249027785 as (
with aggView1354070836641420419 as (select id as v13 from link_type as lt)
select v24, v39, v40, v41 from aggJoin2395294018270589442 join aggView1354070836641420419 using(v13));
create or replace view aggJoin1488404560716896840 as (
with aggView6789750012705568623 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v41) as v41 from aggJoin6194506725249027785 group by v24,v41,v39,v40)
select v39, v40, v41 from aggJoin9041523431973804379 join aggView6789750012705568623 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin1488404560716896840;
